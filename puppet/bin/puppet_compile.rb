require "puppet"
require "json"

def _usage
  abort("Usage: puppet_compile.rb /path/to/module")
end

def get_class_name(file_path)
  if not File.file?(file_path)
    abort("No such file #{file_path}")
  end
  open(file_path) do |f|
    f.each_line.detect do |line|
      if /^class\s+\S+/.match(line)
        return /^class\s+(\S+)/.match(line)[1]
      end
    end
  end
end

def get_autoload_path(module_path, class_name)
  tmp_dir = Dir.tmpdir()
  if File.basename(module_path) != class_name
    tmp_path = "#{tmp_dir}/#{class_name}"
    File.symlink(module_path, tmp_path)
    return tmp_path
  end
  return module_path
end

def run_compile(module_path)
  manifest_path = "#{module_path}/manifests/init.pp"
  class_name = get_class_name(manifest_path)

  autoload_path = get_autoload_path(module_path, class_name)
  module_paths = ["#{autoload_path}/../", autoload_path]

  puts module_paths

  config_dir = nil
  hiera_config = nil
  verbose = 1
 
  Puppet.initialize_settings
 
  if config_dir
    Puppet.settings.handlearg("--confdir", config_dir)
  end
  if verbose == 1
    Puppet::Util::Log.newdestination(:console)
    Puppet::Util::Log.level = :debug
  end
  Puppet.settings.handlearg("--config", ".")
  Puppet.settings.handlearg("--config", ".")
  Puppet.settings.handlearg("--manifest", manifest_path)
  module_path = module_paths.join(":")
  Puppet.settings.handlearg("--modulepath", module_path)
  if hiera_config
    raise ArgumentError, "[ERROR] hiera_config (#{hiera_config}) does not exist" if !FileTest.exist?(hiera_config)
    Puppet.settings[:hiera_config] = hiera_config
  end
 
  nodename = get_nodename
  facts_val = get_facts(nodename)
 
  Puppet[:code] = "include #{File.basename(module_path)}\n"
 
  begin
    compile_catalog(facts_val['hostname'], facts_val)
  rescue => e
    puts e.message
  end

  if autoload_path != module_path
    File.unlink(autoload_path)
  end
end
 
def get_nodename
  Puppet[:certname]
end
 
def get_facts(node)
  facts_val = {
    'clientversion' => Puppet::PUPPETVERSION,
    'environment' => 'production',
    'hostname' => node.split('.').first,
    'fqdn' => node,
    'domain' => node.split('.', 2).last,
    'clientcert' => node
  }
  facts_val
end
 
def compile_catalog(node_fqdn, facts = {})
  hostname = node_fqdn.split('.').first
  facts['hostname'] = hostname
  node = Puppet::Node.new(hostname)
  node.merge(facts)
  Puppet::Parser::Compiler.compile(node)
end

# CLI Argument Validation
if ARGV.length != 1
  _usage
end
if not File.directory?(ARGV[0])
  abort("Path #{ARGV[0]} is not a directory")
end
if not File.file?("#{ARGV[0]}/manifests/init.pp")
  abort("#{ARGV[0]} does not have an init.pp")
end

catalog = run_compile(ARGV[0])

json = catalog.to_data_hash.to_json
puts (JSON.pretty_generate JSON.parse(json))
vardir = Dir.mktmpdir
File.open("#{vardir}/catalog.json", "w").write(json)
File.open("#{vardir}/catalog.dot", "w").write(catalog.to_dot)
puts "# Wrote #{vardir}/catalog.{dot,json}"

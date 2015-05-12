# omnispec

All-in-one docker image for ansible and puppet spec testing.

# build
```
docker build -t omnispec .
docker run -it omnispec
```

# omni
The included `/usr/bin/omni` tool allows for easy switching between tool environments.

See the available tools
```
omni
```

See the available versions for a tool
```
omni ansible
omni puppet
```

Activate an environment.  The tool should be launched with a preceeding `.` to allow it to setup your shell environment and path.
```
$ . omni ansible 1.0
$ . omni puppet 3.2.4
```

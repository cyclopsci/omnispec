#!/bin/bash

PUPPET_EXCLUDED_DIRS=(
  'spec'
  'tests'
  'pkg'
)

function is_ansible_project() {
  local directory=$1
  if [ -f $(find_ansible_roles $directory | head -n1)/tasks/main.yml ]; then
    return 0
  fi
  return 1
}

function find_ansible_roles() {
  local directory=$1
  for a_dir in $(find $directory -type f -regex '.*/tasks/.*.yml' -exec dirname {} \; | sort | uniq); do
    echo $(dirname $a_dir)
  done
}

function run_ansible_syntax_check() {
  local directory=$1
  find_ansible_roles $directory
}

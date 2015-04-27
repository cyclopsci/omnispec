#!/bin/bash

SOURCE_DIR=${1:-.}

PUPPET_EXCLUDED_DIRS=(
  'spec'
  'tests'
  'pkg'
)

function is_ansible_project() {
  local directory=$1
  if [ -f $(find_ansible_roles | head -n1)/tasks/main.yml ]; then
    return 1
  fi
  return 0
}

function find_ansible_roles() {
  local directory=$1
  for a_dir in $(find $directory -type f -regex '.*/tasks/.*.yml' -exec dirname {} \; | sort | uniq); do
    echo $(dirname $a_dir)
  done
}

function run_ansible_syntax_check() {
  find_ansible_roles $SOURCE_DIR
}

#!/bin/bash

PUPPET_EXCLUDED_DIRS=(
  'spec'
  'tests'
  'pkg'
)

function is_puppet_project() {
  local directory=$1
  if find_puppet_files $directory | grep -q '.pp'; then
    return 0
  fi
  return 1
}

function find_puppet_files() {
  local directory=$1
  local excluded_dirs_regex="/($(echo ${PUPPET_EXCLUDED_DIRS[@]} | sed 's/ /\|/g'))/"
  find $directory -type f -name '*.pp' | egrep -v $excluded_dirs_regex
}

function find_puppet_modules() {
  local directory=$1
  local excluded_dirs_regex="/($(echo ${PUPPET_EXCLUDED_DIRS[@]} | sed 's/ /\|/g'))/"
  for p_dir in $(find $directory -type f -regex '.*/init.pp' \
    | egrep -v $excluded_dirs_regex \
    | egrep -o '.*/manifests/' | sort | uniq); do
    echo $(dirname $p_dir)
  done
}

function puppet_lint() {
  local directory=$1
  for file in $(find_puppet_files $directory); do
    puppet-lint $file
  done
}

function puppet_compile_catalog() {
  local directory=$1
  find_puppet_modules $directory
}

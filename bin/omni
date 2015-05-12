#!/bin/bash

TOOL=$1
VERSION=$2
TOOL_BASE=${3:-/usr/omni}

function validate_tool {
  if [ -z "$TOOL" ]; then
    print_tool_usage
  fi
  if [ ! -d "$TOOL_BASE/$TOOL" ]; then
    echo "Invalid tool: $TOOL"
    echo "---"
    print_tool_usage
  fi
}

function validate_version {
  if [ -z "$VERSION" ]; then
    print_version_usage
  fi
  if [ ! -d "$TOOL_BASE/$TOOL/$VERSION" ]; then
    echo "Invalid version: $VERSION"
    echo "---"
    print_version_usage
  fi
}

function print_tool_usage {
  echo "Usage: $0 [tool] [version]"
  echo ""
  echo "Tools:"
  ls $TOOL_BASE
  exit 1
}

function print_version_usage {
  echo "Usage: $0 $TOOL [version]"
  echo ""
  echo "Versions:"
  ls "$TOOL_BASE/$TOOL"
  exit 1
}

function clear_version {
 if [ ! -z "$VIRTUAL_ENV" ]; then
   deactivate
 fi
 if [ ! -z "$BUNDLE_GEMFILE" ]; then
   unset BUNDLE_GEMFILE
 fi
}

function activate_version {
  if [ -z "$ORIGPATH" ]; then
    export ORIGPATH=$PATH
  fi
  if [ -d "$TOOL_BASE/$TOOL/$VERSION/.venv" ]; then
    . $TOOL_BASE/$TOOL/$VERSION/.venv/bin/activate
    return
  fi
  if [ -f "$TOOL_BASE/$TOOL/$VERSION/Gemfile" ]; then
    export BUNDLE_GEMFILE=$TOOL_BASE/$TOOL/$VERSION/Gemfile
    export PATH=$TOOL_BASE/$TOOL/$VERSION/bin:$ORIGPATH
    return
  fi
}

function main {
  validate_tool
  validate_version
  clear_version
  activate_version
}

main

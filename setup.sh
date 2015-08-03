#!/bin/bash

TYPE=$1
VERSION=$2
TOOL_BASE=${3:-/usr/omni}

function boiler2dir() {
  local t=$1
  local v=$2
  mkdir -p $TOOL_BASE/$t/$v
  cp -R $t/boilerplate/* $TOOL_BASE/$t/$v
  sed -i "s/%%VERSION/${v}/g" $TOOL_BASE/$t/$v/*
}

[ -d "$TOOL_BASE/$TYPE/$VERSION" ] || boiler2dir $TYPE $VERSION

echo "Configuring $TYPE $VERSION"
cd $TOOL_BASE/$TYPE/$VERSION

if [[ $TYPE == "ansible" ]]; then
  virtualenv .venv
  . .venv/bin/activate
  [ -f requirements.txt ] && pip install -r requirements.txt
  deactivate
elif [[ $TYPE == "puppet" ]]; then
  [ -f Gemfile ] && bundle install --path .gem --binstubs
fi

cd -

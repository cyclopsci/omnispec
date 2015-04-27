#!/bin/bash

TYPE=$1
VERSION=$2

function boiler2dir() {
  local t=$1
  local v=$2
  cp -R $t/boilerplate $t/$v
  sed -i "s/%%VERSION/${v}/g" $t/$v/*
}

if grep -q $VERSION $TYPE/versions.txt; then
  [ -d "$TYPE/$VERSION" ] || boiler2dir $TYPE $VERSION
else
  echo "${TYPE} version '${VERSION}' not supported" && exit 1
fi

echo "Configuring $TYPE $VERSION"
cd $TYPE/$VERSION

if [[ $TYPE == "ansible" ]]; then
  virtualenv .venv
  . .venv/bin/activate
  [ -f requirements.txt ] && pip install -r requirements.txt
  deactivate
elif [[ $TYPE == "puppet" ]]; then
  [ -f Gemfile ] && bundle install --path .gem
fi

cd -

#!/bin/bash

TYPE=$1
VERSION=$2

[ -d "$TYPE/$VERSION" ] || exit 1
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

#!/bin/bash

PROJECT_DIR=/project
CWD=$(pwd)

[ -d $PROJECT_DIR ] || exit 1

echo "Project: ${PROJECT_DIR}"
echo "Project Files:"
ls ${PROJECT_DIR}

echo "=== python ==="
python --version
echo ""

for vers in $(cat ansible/versions.txt); do
  [ -d ansible/$vers ] || continue
  cd ansible/$vers
  if [ -f ".venv/bin/activate" ]; then
    . .venv/bin/activate
    ansible --version
    deactivate
  fi
  cd $CWD
done
echo ""

echo "===  ruby  ==="
rbenv versions

for vers in $(cat puppet/versions.txt); do
  [ -d puppet/$vers ] || continue
  cd puppet/$vers
  if [ -d ".gem" ]; then
    bundle exec puppet --version
  fi
  cd $CWD
done

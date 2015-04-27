#!/bin/bash
CWD=$(pwd)

echo "=== python ==="
python --version
echo ""

for vers in $(ls ansible); do
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

for vers in $(ls puppet); do
  cd puppet/$vers
  if [ -d ".gem" ]; then
    bundle exec puppet --version
  fi
  cd $CWD
done

#!/bin/bash

echo "=== python ==="
python --version
echo ""

for vers in $(ls /virtual/ansible); do
  . /virtual/ansible/$vers/.venv/bin/activate
  ansible --version
  ansible-playbook --syntax-check --list-tasks -i test.inv test.yml
  deactivate
done
echo ""

echo "===  ruby  ==="
rbenv versions

#!/bin/bash

ANSIBLES=(1.0 1.1 1.2 1.2.1 1.2.2 1.2.3 1.3.0 1.3.1 1.3.2 1.3.3 1.3.4 1.4 1.4.1 1.4.2 1.4.3 1.4.4 1.4.5 1.5 1.5.1 1.5.2 1.5.3 1.5.4 1.5.5 1.6 1.6.1 1.6.2 1.6.3 1.6.4 1.6.5 1.6.6 1.6.7 1.6.8 1.6.9 1.6.10 1.7 1.7.1 1.7.2 1.8 1.8.1 1.8.2 1.8.3 1.8.4 1.9.0.1)

echo "Configuring ansible environments"
mkdir -p /virtual/ansible

for a in "${ANSIBLES[@]}"; do
  mkdir /virtual/ansible/$a
  cd /virtual/ansible/$a
  virtualenv .venv
  . .venv/bin/activate
  pip install ansible==$a
  deactivate
done

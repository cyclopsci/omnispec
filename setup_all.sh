#!/bin/bash

echo "Configuring ansible environments"

for a in $(ls ansible); do
  cd ansible/$a
  virtualenv .venv
  . .venv/bin/activate
  [ -f requirements.txt ] && pip install -r requirements.txt
  deactivate
done

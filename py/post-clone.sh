#!/bin/bash

# Exit if any command fails
set -e

python3 -m venv .venv

. .venv/bin/activate
python3 -m pip install -r requirements.txt

deactivate

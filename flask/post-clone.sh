#!/bin/bash

# Exit if any command fails
set -e

START=$SECONDS

python3 -m venv .venv
source .venv/bin/activate

python3 -m pip install -r requirements.txt

deactivate

echo "Finished Post Clone in $((SECONDS - START)) s"

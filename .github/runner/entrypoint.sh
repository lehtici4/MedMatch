#!/bin/bash

./config.sh \
    --url https://github.com/lehtici4/MedMatch \
    --token "${RUNNER_TOKEN}" \
    --name "${RUNNER_NAME:-medmatch-runner}" \
    --labels "self-hosted,Linux,X64,devsecops" \
    --unattended \
    --replace

./run.sh
#!/bin/bash
set -euo pipefail

if [ -z "${GITHUB_REPO:-}" ]; then
  echo "GITHUB_REPO nao informado"
  exit 1
fi

if [ -z "${RUNNER_TOKEN:-}" ]; then
  echo "RUNNER_TOKEN nao informado"
  exit 1
fi

cd /actions-runner

if [ ! -f ".runner" ]; then
  ./config.sh \
    --unattended \
    --url "$GITHUB_REPO" \
    --token "$RUNNER_TOKEN" \
    --name "${RUNNER_NAME:-medmatch-runner}" \
    --labels "${RUNNER_LABELS:-self-hosted,linux,docker,medmatch}" \
    --work "_work" \
    --replace
fi

exec ./run.sh
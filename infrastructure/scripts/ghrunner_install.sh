#!/bin/bash
exec > >(sudo tee -a /var/log/ghrunner_install.log) 2>&1
set -x


sudo apt -y update
GH_PAT_TOKEN="${GH_PAT_TOKEN}"
GITHUB_ORG="tsrlearning-training"

curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${GH_PAT_TOKEN}" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/orgs/$GITHUB_ORG/actions/runners/generate-jitconfig \
  -d '{"name":"ghrunner-vm-01","runner_group_id"":1,"labels":["self-hosted","X64","linux","no-gpu"],"work_folder":"_work"}'

sudo systemctl status actions.runner.$GITHUB_ORG.ghrunner-vm-01.service
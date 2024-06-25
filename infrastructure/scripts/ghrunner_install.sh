#!/bin/bash
exec > >(sudo tee -a /var/log/ghrunner_install.log) 2>&1
set -x

# install
sudo apt -y update
# sudo apt  install jq -y
# sudo apt-get -y install expect

# Declare variables
# RUNNER_URL="${RUNNER_URL}"
# RUNNER_SHA="${RUNNER_SHA}"
# RUNNER_TAR="${RUNNER_TAR}"
GH_PAT_TOKEN="${GH_PAT_TOKEN}"
GITHUB_ORG="tsrlearning-training"
# USER_HOME="/home/tsrlearning"
# USER="tsrlearning"
# RUNNER_DIR="/actions-runner"

# # Debug: Print variables
# echo "RUNNER_URL: ${RUNNER_URL}"
# echo "RUNNER_SHA: ${RUNNER_SHA}"
# echo "RUNNER_TAR: ${RUNNER_TAR}"
# echo "GH_PAT_TOKEN: ${GH_PAT_TOKEN}"


# # Create a folder and navigate into it
# mkdir -p "$HOME/actions-runner"
# cd "$HOME/actions-runner"
# echo $PWD
# # sudo chown -R $USER:$USER "$HOME/actions-runner"

# curl -o actions-runner-linux-x64-2.317.0.tar.gz -L "${RUNNER_URL}"
# echo "${RUNNER_SHA}  actions-runner-linux-x64-2.317.0.tar.gz" | shasum -a 256 -c
# tar xzf "${RUNNER_TAR}"

# curl -L  -X POST -H "Accept: application/vnd.github+json" \
#     -H "Authorization: Bearer ${TOKEN}" -H "X-GitHub-Api-Version: 2022-11-28" \
#     https://api.github.com/orgs/$GITHUB_ORG/actions/runners/registration-token > response.json

curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${GH_PAT_TOKEN}" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/orgs/$GITHUB_ORG/actions/runners/generate-jitconfig \
  -d '{"name":"ghrunner-vm-01","runner_group_id"":1,"labels":["self-hosted","X64","linux","no-gpu"],"work_folder":"_work"}'


# # Ensure response.json is owned by the current user
# sudo chown $USER:$USER response.json

# RUNNER_TOKEN=$(jq -r '.token' response.json)
# echo "RUNNER_TOKEN: $RUNNER_TOKEN"

# # Run the configuration script with automated inputs
# echo "Running GitHub Actions runner configuration"

# # Ensure all files and directories have correct ownership before configuration
# sudo chown -R $USER:$USER "$RUNNER_DIR"

# Run the configuration script as the user (not with sudo)
# sudo -u tsrlearning bash <<EOF
# cd $RUNNER_DIR
# ./config.sh --url https://github.com/$GITHUB_ORG --token $RUNNER_TOKEN <<EOL
# TSRLearning Default Runner Group
# ghrunner-vm-01
# self-hosted,Linux,X64,ghrunner-vm-01
# _work
# EOL
# EOF

# ./run.sh &

# # Ensure correct ownership before installing the service
# sudo chown -R $USER:$USER "$RUNNER_DIR"

# ./svc.sh install
# ./svc.sh start

# # Debug: List files to ensure correct ownership and presence of svc.sh
# ls -la

# Check if the service is running
sudo systemctl status actions.runner.$GITHUB_ORG.ghrunner-vm-01.service
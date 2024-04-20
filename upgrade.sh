#!/bin/bash

# Define a spinner function
function spinner() {
  local pid=$1
  local delay=0.75
  local spinners="/-\|/"

  while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
    for ((i=0; i<${#spinners}; i++)); do
      local spin="${spinners[$i]}"
      printf "\e[0m\e[1A\e[7D %s" "$spin"
      sleep "$delay"
    done
  done
  printf "\e[0m\e[1A\e[7D\n"
}

# Stop ceremonyclient service (with spinner)
service ceremonyclient stop &
spin_pid=$!
echo -n "Stopping ceremonyclient service..."
spinner $spin_pid
wait $spin_pid
sleep 1  # Introduce 1 second delay

# Navigate to ceremonyclient directory
cd ~/ceremonyclient

# Fetch updates (with spinner)
git fetch origin &
spin_pid=$!
echo -n "Fetching latest updates..."
spinner $spin_pid
wait $spin_pid
sleep 1  # Introduce 1 second delay

# Merge updates (with spinner)
git merge origin &
spin_pid=$!
echo -n "Merging updates..."
spinner $spin_pid
wait $spin_pid
sleep 1  # Introduce 1 second delay

# Move to node directory
cd ~/ceremonyclient/node

# Clean project (with spinner)
GOEXPERIMENT=arenas go clean -v -n -a ./... &
spin_pid=$!
echo -n "Cleaning project..."
spinner $spin_pid
wait $spin_pid
sleep 1  # Introduce 1 second delay

# Remove old binary
rm /root/go/bin/node

# List contents of /root/go/bin (optional)
ls /root/go/bin

# Build and install project (with spinner)
GOEXPERIMENT=arenas go install ./... &
spin_pid=$!
echo -n "Building and installing..."
spinner $spin_pid
wait $spin_pid
sleep 1  # Introduce 1 second delay

# List contents of /root/go/bin (optional)
ls /root/go/bin

# Start ceremonyclient service
service ceremonyclient start

# Clear terminal screen
clear

# Follow ceremonyclient service logs
sudo journalctl -u ceremonyclient.service -f --no-hostname -o cat

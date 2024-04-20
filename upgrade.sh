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

# Stop ceremonyclient service (background & spinner)
service ceremonyclient stop &
spin_pid=$!
echo -n "Stopping ceremonyclient service..."
spinner $spin_pid
wait $spin_pid
echo  # Print a newline after stopping service

# Fetch updates (background & spinner)
git fetch origin &
spin_pid=$!
echo -n "Fetching latest updates..."
spinner $spin_pid
wait $spin_pid
echo  # Print a newline after fetching updates

# Merge updates (background & spinner)
git merge origin &
spin_pid=$!
echo -n "Merging updates..."
spinner $spin_pid
wait $spin_pid
echo  # Print a newline after merging updates

# Move to node directory (background)
cd ~/ceremonyclient &

# Clean project (background & spinner)
GOEXPERIMENT=arenas go clean -v -n -a ./... &
spin_pid=$!
echo -n "Cleaning project..."
spinner $spin_pid
wait $spin_pid
echo  # Print a newline after cleaning project

# Remove old binary (background)
rm /root/go/bin/node &

# List contents of /root/go/bin (optional)
# ls /root/go/bin

# Build and install project (background & spinner)
GOEXPERIMENT=arenas go install ./... &
spin_pid=$!
echo -n "Building and installing..."
spinner $spin_pid
wait $spin_pid
echo  # Print a newline after building and installing

# List contents of /root/go/bin (optional)
# ls /root/go/bin

# Start ceremonyclient service (background)
service ceremonyclient start &

# Wait for all background jobs to finish before showing logs
wait

# Clear terminal screen
clear

# Follow ceremonyclient service logs
sudo journalctl -u ceremonyclient.service -f --no-hostname -o cat

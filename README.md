Here's the README.md file you requested:

**## Ceremony Client Update Script**

This script automates the process of updating the Ceremony Client on your system.

**Requirements:**

- This script is designed to run on systems with root access.
- It assumes the script will be downloaded and executed on the target machine.

**Instructions:**

1. **Copy and Paste the Command:**
   Open a terminal window on your target machine and copy the following commands:

   ```bash
   wget https://raw.githubusercontent.com/tradersquareoff/ceremonyclient_update_script/main/upgrade.sh?token=GHSAT0AAAAAACOJYRABTU77T33WM4J6W6FMZREGOCA
   chmod +x /root/upgrade.sh
   ./upgrade.sh
   ```

2. **Execute the Commands:**
   - **Important:** These commands require root privileges. You might be prompted for your password.
   - Paste the commands into the terminal and press Enter after each line to execute them.

**Script Functionality:**

- The first command downloads the update script (`upgrade.sh`) from a specific URL on GitHub.
- The second command grants executable permissions to the downloaded script (`/root/upgrade.sh`).
- The third command runs the downloaded script (`./upgrade.sh`) to perform the update process.

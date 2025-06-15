#!/bin/bash
cd "$(dirname "$0")"

# Dependency check
for pkg in figlet lolcat; do if ! command -v $pkg &>/dev/null; then 
echo "Installing $pkg..."
 apt install $pkg -y 
fi 
done

while true; 
do
 clear
 clear 
[ -d "Raavan-Tools" ] || mkdir Raavan-Tools 
clear

# Ensure figlet is installed
command -v figlet >/dev/null 2>&1 || apt install figlet -y

clear 
 echo -e "\033[1;31m"
 figlet -f slant "RaavanXploit" 
 echo -e "\033[0m"

# Metadata
echo -e "\033[1;34m****=====================================================!!!\033[0m"
echo -e "\033[1;36m Author :\033[0m RaavanXploit & Wish690" 
echo -e "\033[1;36m Version :\033[0m 1.0"
echo -e "\033[1;36m GitHub :\033[0m https://github.com/Wish690" 
echo -e "\033[1;36m GitHub :\033[0m https://github.com/SivaKrishnaSiripurapu" 
echo -e "\033[1;34m!!!=====================================================****\033[0m" 
echo -e "\n"

# Menu
echo -e "\e[36m[1]  INFORMATION-GATHERING   \e[36m[7]  PHISHING TOOLS"
echo -e "\e[36m[2]  CAM-HACKING             \e[36m[8]  DORKS-EYE"
echo -e "\e[36m[3]  GPS-TRACKER             \e[36m[9]  ROUTERSPLOIT"
echo -e "\e[36m[4]  SUBFINDER               \e[36m[10] NIKTO"
echo -e "\e[36m[5]  AUTO-IP-CHANGER         \e[36m[11] RED HAWK"
echo -e "\e[36m[6]  SQLMAP                  \e[31m[00] EXIT"
echo -e "\n"

read -p $'\033[1;33mPlease choose an Option:\033[0m' choice

case $choice in 
    
  1) echo -e "\033[1;36mInstalling & Running fsociety...\033[0m"
  sleep 1

  FSOCIETY_DIR="Raavan-Tools/fsociety"

  # If not already cloned
  if [ ! -d "$FSOCIETY_DIR" ]; then
    echo -e "\033[1;33mCloning fsociety from GitHub...\033[0m"
    git clone https://github.com/Manisso/fsociety.git "$FSOCIETY_DIR"

    # Install requirements
    echo -e "\033[1;33mInstalling Python requirements and tools...\033[0m"
    apt update >/dev/null 2>&1
    apt install -y python3 python3-pip python3-distutils 2to3 >/dev/null 2>&1

    # Convert Python 2 code to Python 3
    echo -e "\033[1;33mConverting fsociety codebase to Python 3...\033[0m"
    2to3 -w "$FSOCIETY_DIR" >/dev/null 2>&1

    # Install Python module dependencies (if any)
    pip3 install -r "$FSOCIETY_DIR/requirements.txt" --break-system-packages >/dev/null 2>&1 || true
  else
    echo -e "\033[1;32m[+] fsociety is already installed.\033[0m"
  fi

  # Run the tool
  cd "$FSOCIETY_DIR" || exit
  echo -e "\033[1;34m[+] Launching fsociety menu...\033[0m"
  python2 fsociety.py

  echo -e "\n\033[1;33mExited fsociety. Press Enter to return to menu...\033[0m"
  read
  cd ../../
;;


  2) echo -e "[47;3;35m Installing CAM-HACKING... [0m" 
    cd Raavan-Tools 
if [ ! -d "CamPhish" ]; then
    git clone https://github.com/techchipnet/CamPhish.git
fi 
   cd CamPhish 
   bash camphish.sh 
   cd ../../
;;
  3) echo -e "[47;3;35m Installing GPS-LOCATION... [0m"
    cd Raavan-Tools
if [ ! -d "GPS-LOCATION" ]; then 
   git clone https://github.com/thewhiteh4t/seeker.git
fi
   cd seeker/
   chmod +x install.sh
   ./install.sh
   sudo python3 seeker.py
   cd ../../
;;

 4) echo -e "\033[1;36mInstalling & Running Subfinder...\033[0m"
  sleep 1

  # Check for Go installation
  if ! command -v go &> /dev/null; then
    echo -e "\033[1;31mGo (Golang) is not installed. Please install Go to proceed.\033[0m"
    read
    continue
  fi

  # Install or update Subfinder
  echo -e "\033[1;33mInstalling the latest Subfinder...\033[0m"
  go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

  # Add GOPATH/bin to PATH
  export PATH="$PATH:$(go env GOPATH)/bin"

  # Install or update httpx-toolkit
  echo -e "\033[1;33mInstalling the latest httpx-toolkit...\033[0m"
  go install -v github.com/projectdiscovery/httpx-toolkit/cmd/httpx-toolkit@latest

  # Ask user for domain
  echo -ne "\033[1;32mEnter domain to enumerate: \033[0m"
  read domain

  # Create output directory and file names
  mkdir -p outputs
  timestamp=$(date +%s)
  sub_file="outputs/${domain}_subdomains_$timestamp.txt"
  active_file="outputs/${domain}_active_$timestamp.txt"

  # Run Subfinder and save subdomains
  echo -e "\n\033[1;34mRunning Subfinder on $domain...\033[0m"
  subfinder -d "$domain" -o "$sub_file"

  echo -e "\n\033[1;33mSubdomains saved to: $sub_file\033[0m"

  # Run httpx-toolkit to find active subdomains
  echo -e "\n\033[1;34mFiltering active subdomains with httpx-toolkit...\033[0m"
  cat "$sub_file" | httpx-toolkit > "$active_file"

  echo -e "\n\033[1;32mActive subdomains saved to: $active_file\033[0m"
  echo -e "\n\033[1;33mPress Enter to return to the menu...\033[0m"
  read
  ;;


  5) echo -e "\033[1;32m[+] Installing Auto_Tor_IP_changer...\033[0m"
     sudo apt-get update 
     sudo apt-get install -y tor 
     pipx install requests || pip3 install --break-system-packages requests
     mkdir -p Raavan-Tools 
     cd Raavan-Tools
if [ ! -d "Auto_Tor_IP_changer" ]; then 
    git clone https://github.com/FDX100/Auto_Tor_IP_changer.git 
fi
   cd Auto_Tor_IP_changer 
echo -e "\033[47;3;35m[!] Now go to your browser and set the SOCKS proxy to 127.0.0.1:9050\033[0m" 
sleep 8
    python3 install.py

  echo -e "\033[1;36m[+] Launching Auto Tor IP Changer...\033[0m" 
sleep 1
    aut
    read -p "Press enter to return to menu..."
  ;;

 
 6) echo -e "\033[1;36mInstalling & Running SQLMap...\033[0m"
  sleep 1

  # Clone sqlmap if not already present
  if [ ! -d "Raavan-Tools/sqlmap" ]; then
    git clone --depth=1 https://github.com/sqlmapproject/sqlmap.git Raavan-Tools/sqlmap
  fi

  cd Raavan-Tools/sqlmap || {
    echo -e "\033[1;31mFailed to access SQLMap directory.\033[0m"
    read
    continue
  }

  # Ask user for target URL
  echo -ne "\033[1;32mEnter target URL (e.g., http://example.com/page.php?id=1): \033[0m"
  read target_url

  echo -e "\n\033[1;34mRunning SQLMap on: $target_url\033[0m"
  python3 sqlmap.py -u "$target_url" --batch

  echo -e "\n\033[1;33mScan complete! Press Enter to return to menu...\033[0m"
  read
  cd ../../
  ;;


  7) echo -e "[47;3;35m Installing PHISHING TOOLS... [0m" 
     cd Raavan-Tools 
if [ ! -d "zphisher" ]; then 
    git clone https://github.com/htr-tech/zphisher.git
fi 
  cd zphisher  
  bash zphisher.sh 
  cd ../../
;;
  8) echo -e "\033[1;32m[+] Installing Dorks Eye...\033[0m" 
     sudo apt-get update
     sudo apt-get install -y python3-venv git
     mkdir -p Raavan-Tools 
     cd Raavan-Tools
if [ ! -d "dorks-eye" ]; then 
   git clone https://github.com/BullsEye0/dorks-eye.git 
fi
   cd dorks-eye
 # Create virtual environment
   python3 -m venv dorks-eye-env 
   source dorks-eye-env/bin/activate
   pip install --upgrade pip 
   pip install -r requirements.txt
   echo -e "\033[1;36m[+] Launching Dorks Eye in interactive mode...\033[0m" 
   sleep 1 
   sudo python3 dorks-eye.py

   echo -e "\033[1;33m[+] Dorks Eye exited. Deactivating virtual environment...\033[0m" 
   deactivate
   read -p "Press enter to return to menu..."
 ;;

  9) echo -e "\033[1;36mInstalling & Launching RouterSploit...\033[0m"
   sleep 1

  # Clone if not already present
  if [ ! -d "Raavan-Tools/routersploit" ]; then
    git clone https://github.com/threat9/routersploit.git Raavan-Tools/routersploit
  fi

  cd Raavan-Tools/routersploit || exit

  # Create virtual environment to avoid package conflicts
  if [ ! -d "venv" ]; then
    python3 -m venv venv
  fi
  source venv/bin/activate

  # Upgrade pip and install dependencies
  pip install --upgrade pip >/dev/null 2>&1
  pip install -r requirements.txt >/dev/null 2>&1

  echo -e "\n\033[1;32m[+] RouterSploit installed successfully.\033[0m"
  echo -e "\033[1;34m[+] Launching RouterSploit interactive shell...\033[0m"
  sleep 1

  # Launch Routersploit
  sudo python3 rsf.py

  # On exit, deactivate virtual environment and return
  deactivate
  echo -e "\n\033[1;33mPress Enter to return to the main menu...\033[0m"
  read
  cd ../../
  ;;


 10) echo -e "\033[1;36mInstalling & Running Nikto...\033[0m"
  sleep 1

  # Install Nikto dependencies if not already present
  if ! command -v nikto &> /dev/null; then
    echo -e "\033[1;33mNikto not found. Installing...\033[0m"
    sudo apt update && sudo apt install nikto -y
  fi

  # Ask for target interactively
  echo -ne "\033[1;32mEnter target URL or IP (e.g., http://example.com): \033[0m"
  read target

  # Create output folder and timestamped filename
  mkdir -p Raavan-Tools/output
  ts=$(date +%s)
  nikto_output="Raavan-Tools/output/nikto_${ts}.txt"

  # Run Nikto scan and save results
  echo -e "\n\033[1;34mRunning Nikto scan on: $target\033[0m"
  nikto -h "$target" -output "$nikto_output"

  echo -e "\n\033[1;33mScan complete. Report saved to: $nikto_output\033[0m"
  echo -e "\n\033[1;33mPress Enter to return to menu...\033[0m"
  read
  ;;

 11)echo -e "\033[1;36mInstalling & Running Red Hawk...\033[0m"
  sleep 1

  # Install required PHP modules
  echo -e "\033[1;33mInstalling required PHP modules...\033[0m"
  sudo apt update -y >/dev/null 2>&1
  sudo apt install php php-curl php-xml -y >/dev/null 2>&1

  # Clone Red Hawk if not already cloned
  if [ ! -d "Raavan-Tools/RED_HAWK" ]; then
    git clone https://github.com/Tuhinshubhra/RED_HAWK.git Raavan-Tools/RED_HAWK
  fi

  cd Raavan-Tools/RED_HAWK || {
    echo -e "\033[1;31mFailed to access RED_HAWK directory.\033[0m"
    read
    continue
  }

  # Launch Red Hawk
  echo -e "\033[1;32mLaunching RED HAWK...\033[0m"
  php rhawk.php

  echo -e "\n\033[1;33mPress Enter to return to menu...\033[0m"
  read
  cd ../../
  ;;

# ... [Keep other cases unchanged] ...

    00)
      clear
      echo -e "\033[1;33m"
      echo "Thank you for using RaavanXploit!" | pv -qL 20
      echo "Created with 💀 by Wish690 & RaavanXploit" | pv -qL 20
      echo "Follow on GitHub for updates." | pv -qL 20
      echo -e "\033[0m"
      exit 00
      ;;

    *)
      echo -e "\033[1;31mInvalid Option\033[0m"
      sleep 2
      ;;

  Q|q) echo -e "\n\033[1;31mExiting RaavanXploit...\033[0m" exit 00
    ;;
  *) echo -e "\033[1;31mInvalid Option\033[0m"
    ;;
esac done

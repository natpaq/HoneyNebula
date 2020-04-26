# Contains list of commands required to install T-Pot onto a fresh GCP VM instance
# Note that you will be prompted to enter a username and password
sudo apt update
sudo apt install git
git clone https://github.com/dtag-dev-sec/tpotce
sudo tpotce/iso/installer/install.sh --type=user


# Please note that after first T-Pot installation in GCP and after reboot, the following must be done:
# On 'VM Instances' page, go to VM instance where you installed honeypot and click 3 vertical dots
# Select 'View network details'
# Go to 'Firewall rules'
# The following ports must be changed to the following values
# default-allow-https	tcp:64297
# default-allow-ssh	tcp:64295

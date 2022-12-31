#!/usr/bin/env sh
# curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/kpbeta/dotfiles/main/setup.sh | sh 
# curl https://raw.githubusercontent.com/kpbeta/dotfiles/main/setup.sh | sh 

sudo apt update -y && sudo apt upgrade -y

# Install python and ansible
sudo apt install -y python3 python2 curl git\
 python-pip python3-pip
curl https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py
python3 /tmp/get-pip.py --user
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output /tmp/get-pip2.py
python2 /tmp/get-pip2.py

python3 -m pip install --user ansible
python2 -m pip install --upgrade pip

# Clone dotfiles
! [ -d "~/MyApplications" ] && mkdir ~/MyApplications
cd ~/MyApplications
! [ -d "~/MyApplications/dotfiles" ] && \
git clone https://github.com/kpbeta/dots dotfiles
[ -d "~/MyApplications/dotfiles" ] && cd ~/MyApplications/dotfiles && \
git clone git@github.com:kpbeta/dotsfiles.git

# Ansible get playbook
ansible-galaxy collection install community.general
ansible-playbook -i ~/MyApplications/dotfiles/playbooks/inventory.ini \
~/MyApplications/dotfiles/playbooks/all.yaml
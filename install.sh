#!/bin/bash

#  Created by Richardson Lima - contato@richardsonlima.com.br

# set -x

printf "\033[0;33m [+] Install GIT Client \033[0m\n\n"
sudo apt-get update &&  sudo apt-get install git-core lynx -y

printf "\033[0;33m [+] Install Chef Solo \033[0m\n\n"
curl -L https://www.opscode.com/chef/install.sh | sudo bash
>> ~/.bash_profile && source ~/.bash_profile
sudo chef-solo -v

printf "\033[0;33m [+] Download and configure CHEF-REPO structure \033[0m\n\n"
wget http://github.com/opscode/chef-repo/tarball/master
tar -zxvf master
sudo mkdir -p /opt/chef-repo
sudo mv chef-chef-repo-*/ /opt/chef-repo
sudo mkdir /opt/chef-repo/.chef

printf "\033[0;33m [+] Configure cookbook \033[0m\n\n"
sudo touch /opt/chef-repo/.chef/knife.rb
sudo chown `whoami`: /opt/chef-repo/.chef/knife.rb
sudo cat << EOF > /opt/chef-repo/.chef/knife.rb
cookbook_path [ '/opt/chef-repo/cookbooks' ]
EOF
sudo chown root: /opt/chef-repo/.chef/knife.rb

printf "\033[0;33m [+] Configure solo.rb \033[0m\n\n"
sudo touch /opt/chef-repo/solo.rb
sudo chown `whoami`: /opt/chef-repo/solo.rb
sudo cat << EOF > /opt/chef-repo/solo.rb
file_cache_path "/opt/chef-solo"
cookbook_path "/opt/chef-repo/cookbooks"
EOF
sudo chown root: /opt/chef-repo/solo.rb

printf "\033[0;33m [+] Downloading cookbook \033[0m\n\n"
sudo git clone https://github.com/richardsonlima/hashId-Chef_LAMP.git -l /opt/chef-repo/cookbooks/lamp

printf "\033[0;33m [+] Creating your json \033[0m\n\n"
sudo touch /opt/chef-repo/lamp.json
sudo chown `whoami`: /opt/chef-repo/lamp.json
sudo cat << EOF > /opt/chef-repo/lamp.json
  { "run_list": [ "recipe[lamp]" ] }
EOF
sudo chown root:  /opt/chef-repo/lamp.json

printf "\033[0;33m [+] Execute CHEF-SOLO \033[0m\n\n"
sudo chef-solo -c /opt/chef-repo/solo.rb -j /opt/chef-repo/lamp.json

printf "\033[0;33m [+] See service status \033[0m\n\n"
ps -ef | grep apache |grep -v grep && ps -ef|grep mysql|grep -v grep

printf "\033[0;33m [+] Accessing Zabbix Web Interface \033[0m\n\n"
lynx http://localhost/index.php

* HowTo
------------
* Cookbook install and configure: Apache2 + PHP5 + MySQL5
* Test: Ubuntu Server 14.04.4 LTS
* Database Name: webapp-01-db (user: teamwebapp01 / pass: zwsIFHa3ZLd)
* Root MySQL password: P11xhDNhs4hmw

chef-solo is an open source version of the chef-client that allows using cookbooks with nodes
without requiring access to a Chef server.
chef-solo runs locally and requires that a cookbook

- Auto install - Fully Automated LAMP with Chef Solo - Coming soon :weary:
------------


- HandsOn install - Fully Automated LAMP with Chef Solo - Works fine :sunglasses:
------------

* Install GIT Client
``` bash
sudo apt-get update &&  sudo apt-get install git-core
```

* Install Chef Solo
``` bash
curl -L https://www.opscode.com/chef/install.sh | sudo bash
```

* Download and configure CHEF-REPO structure
``` bash
wget http://github.com/opscode/chef-repo/tarball/master
tar -zxvf master
sudo mkdir -p /opt/chef-repo
sudo mv chef-chef-repo-*/* /opt/chef-repo/
sudo mkdir /opt/chef-repo/.chef
```

* Configure cookbook path (/opt/chef-repo/.chef/knife.rb) - Add line
``` bash
sudo touch /opt/chef-repo/.chef/knife.rb
sudo chown `whoami`: /opt/chef-repo/.chef/knife.rb
sudo cat << EOF > /opt/chef-repo/.chef/knife.rb
cookbook_path [ '/opt/chef-repo/cookbooks' ]
EOF
sudo chown root: /opt/chef-repo/.chef/knife.rb
```

* Configure solo.rb (/opt/chef-repo/solo.rb) - Add lines
``` bash
sudo touch /opt/chef-repo/solo.rb
sudo chown `whoami`: /opt/chef-repo/solo.rb
sudo cat << EOF > /opt/chef-repo/solo.rb
file_cache_path "/opt/chef-solo"
cookbook_path "/opt/chef-repo/cookbooks"
EOF
sudo chown root: /opt/chef-repo/solo.rb
```

* Download cookbook
``` bash
sudo git clone https://github.com/richardsonlima/hashId-Chef_LAMP.git -l /opt/chef-repo/cookbooks/lamp
```

* Create your json (/opt/chef-repo/lamp.json) - Add line
``` bash
sudo touch /opt/chef-repo/lamp.json
sudo chown `whoami`: /opt/chef-repo/lamp.json
sudo cat << EOF > /opt/chef-repo/lamp.json
  { "run_list": [ "recipe[lamp]" ] }
EOF
sudo chown root:  /opt/chef-repo/lamp.json
```

* Execute CHEF-SOLO
``` bash
sudo chef-solo -c /opt/chef-repo/solo.rb -j /opt/chef-repo/lamp.json
```

* Status services
``` bash
ps -ef | grep apache |grep -v grep && ps -ef|grep mysql|grep -v grep
```   

* Test:
  http://localhost/index.php

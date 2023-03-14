#!/bin/bash
  sudo apt-get update
  sudo apt-get upgrade -y
  sudo apt update
  sudo apt install software-properties-common
  sudo add-apt-repository --yes --update ppa:ansible/ansible
  sudo apt install ansible -y 
  # sudo apt install apache2 -y
  # sudo chown ubuntu /var/www/html/index.html
  # sudo chmod 774 /var/www/html/index.html
  # sudo echo "<h1>Hello</h1>" > /var/www/html/index.html

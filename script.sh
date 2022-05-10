#!/bin/bash
  sudo apt update
  sudo apt install apache2 -y
  sudo chown ubuntu /var/www/html/index.html
  sudo chmod 774 /var/www/html/index.html
  sudo echo "<h1>Hello</h1>" > /var/www/html/index.html
#!/usr/bin/env bash

whoami

sudo apt-get update

# install git
sudo apt-get -y install git

# install nginx
sudo apt-get -y install nginx

# install php5
sudo apt-get -y install php5 php5-fpm php5-curl php5-cli

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt-get -y install mysql-server

#sudo mysqladmin -u root root secretroot

sudo apt-get install -y mysql-client php5-mysql

# setup nginx site

# enable site gcda
if [ -f /etc/nginx/sites-enabled/default ]; then
    sudo rm -rf /etc/nginx/sites-enabled/default
fi

if [ -f /etc/nginx/sites-enabled/blog ]; then
    sudo rm -rf /etc/nginx/sites-enabled/blog
fi

if [ -f /etc/nginx/sites-available/blog ]; then
    sudo rm -rf /etc/nginx/sites-available/blog
fi

sudo cat <<EOT >/vagrant/blog_conf
server {
    server_name local.sf.dev;
    root /vagrant/web;

    sendfile off;

    location / {
      index app_dev.php;
      try_files \$uri \@rewriteapp;
    }

    location \@rewriteapp {
        rewrite ^(.*)\$ /app_dev.php/\$1 last;
    }

    location ~ ^/(app|app_dev|config)\.php(/|\$) {
        fastcgi_pass unix:/var/run/php5-fpm.sock;
        fastcgi_split_path_info ^(.+\.php)(/.*)\$;
        fastcgi_buffer_size 128k;
        fastcgi_buffers 4 256k;
        fastcgi_busy_buffers_size 256k;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        fastcgi_param HTTPS off;
	    fastcgi_param SYMFONY__DATABASE_SERVER mongodb://localhost:27017;
        fastcgi_param SYMFONY__DATABASE_NAME blog;
        fastcgi_param SYMFONY__DATABASE_DRIVER_DEFAULT pdo_mysql;
    }

    error_log /var/log/nginx/blog_error.log;
    access_log /var/log/nginx/blog_access.log;
}
EOT

sudo mv /vagrant/blog_conf /etc/nginx/sites-available/blog
sudo ln -s /etc/nginx/sites-available/blog  /etc/nginx/sites-enabled/
sudo sed -i "s/user www-data;/user vagrant;/g" /etc/nginx/nginx.conf
sudo service nginx restart

sudo sed -i "s/;listen.owner = www-data/listen.owner = vagrant/g" /etc/php5/fpm/pool.d/www.conf
sudo sed -i "s/;listen.group = www-data/listen.group = vagrant/g" /etc/php5/fpm/pool.d/www.conf
sudo sed -i "s/user = www-data/user = vagrant/g" /etc/php5/fpm/pool.d/www.conf
sudo sed -i "s/group = www-data/group = vagrant/g" /etc/php5/fpm/pool.d/www.conf
sudo sed -i "s/;listen.mode = 0660/listen.mode = 0660/g" /etc/php5/fpm/pool.d/www.conf

sudo service php5-fpm restart

# elastiq search
sudo wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.0.1.deb
sudo dpkg -i elasticsearch-1.0.1.deb
sudo apt-get install elasticsearch
sudo update-rc.d elasticsearch defaults 95 10
sudo apt-get install -y openjdk-7-jre-headless
sudo /etc/init.d/elasticsearch start

# Configuring les acces au fichier de application pour user cli et web
sudo usermod -g www-data vagrant

if [ `grep -c "umask 0002" /home/vagrant/.bashrc` -eq 0 ]
then
    echo "umask 0002" >>/home/vagrant/.bashrc
fi

# Configuring environment bash for symfony
cat <<EOT >/home/vagrant/.bashrc_symphony
alias sf='php app/console'
alias composer='php /vagrant/composer.phar'
alias assetloadall='rm -rf web/js/* && rm -rf web/css/* && sf assetic:dump -e=dev && sf assets:install -e=dev && php app/console fos:js-routing:dump --env=dev'
EOT

if [ `grep -c "source /home/vagrant/.bashrc_symphony" /home/vagrant/.bashrc` -eq 0 ]
then
    echo "source /home/vagrant/.bashrc_symphony" >>/home/vagrant/.bashrc
fi


# configure project
cd /vagrant
curl -s http://getcomposer.org/installer | php
php composer.phar install

sudo apt-get -y install nodejs npm
sudo npm install -g bower
sudo npm install -g grunt-cli
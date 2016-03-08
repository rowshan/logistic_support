# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  _IRV = '2.3'
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/trusty64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  config.vm.provision :shell, privileged: false, inline: <<-FIX_NO_TTY
    sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile
  FIX_NO_TTY

  config.vm.provision :shell, inline: <<-SHELL
    if [ ! -d ~/.provision ];then mkdir ~/.provision; fi
    if [ ! -f ~/.provision/toolchain ]; then
        apt-get update -qqy
        apt-get install -qqy curl wget git git-core \
        python-software-properties apt-transport-https ca-certificates \
        htop lynx mc
        touch ~/.provision/toolchain
    fi
  SHELL

  config.vm.define :db do |db|
    db.vm.hostname = 'logistic-db.jonnyfresh.v2'
    # db.vm.network :forwarded_port, guest: 5432, host: 54321
    db.vm.network :private_network, ip: "192.168.200.150"

    db.vm.provider :virtualbox do |vb|
        vb.memory = 1024
        vb.linked_clone = true
    end

    db.vm.provision :shell, name: 'PostgreSQL', inline: <<-SHELL
    if [ ! -f ~/.provision/postgresql ]; then
        wget -qO - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
        apt-add-repository -y "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main"
        apt-get update -qqy
        apt-get install -y postgresql-9.5 postgresql-client libpq-dev
        sudo -u postgres psql -c "CREATE USER vagrant WITH PASSWORD 'vagrant';"
        sudo -u postgres psql -c "ALTER USER vagrant WITH superuser;"
        sed -i -e "s/#listen_addresses.*/listen_addresses = '*'/" /etc/postgresql/9.5/main/postgresql.conf
        echo 'host  all all 192.168.200.0/24  md5' >> /etc/postgresql/9.5/main/pg_hba.conf
        service postgresql restart
        touch ~/.provision/postgresql
    fi
    SHELL

    # db.vm.provision :shell, name:'Application', inline: <<-SHELL
    # if [ ! -f ~/.provision/application ]; then
    #     # eventually import a dump file
    #     touch ~/.provision/application
    # fi
    # SHELL
  end

  config.vm.define :web do |web|
    web.vm.hostname = 'logistic-app.jonnyfresh.v2'
    #web.vm.network :forwarded_port, guest: 80, host: 8080
    web.vm.network :private_network, ip: "192.168.200.50"

    # web.vm.synced_folder "www", "/var/www/jonnyfresh"

    web.vm.provider :virtualbox do |vb|
        vb.memory = 1024
        vb.linked_clone = true
    end

    web.vm.provision :shell, name:'Ruby', inline: <<-SHELL
    if [ ! -f ~/.provision/ruby ]; then
        apt-add-repository -y ppa:brightbox/ruby-ng
        apt-get update -qqy
        apt-get install -y ruby#{_IRV} ruby#{_IRV}-dev
        apt-get install -y libxml2 libxml2-dev libxslt1.1 libxslt1-dev libpq-dev libpq-dev libmysqlclient-dev libsqlite3-dev build-essential
        gem install bundler
        touch ~/.provision/ruby
    fi
    SHELL

    web.vm.provision :shell, name:'NginX', inline: <<-SHELL
    if [ ! -f ~/.provision/nginx ]; then
        apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ABF5BD827BD9BF62
        apt-add-repository -y "deb http://nginx.org/packages/ubuntu/ $(lsb_release -cs) nginx"
        apt-get purge nginx*
        apt-get update
        apt-get install -y nginx
        usermod -a -G www-data vagrant
        touch ~/.provision/nginx
    fi
    SHELL

    # cd /vagrant && bundle exec puma -e vagrant -d -b unix:///var/run/logistic.sock --pidfile /var/run/logistic.pid
    web.vm.provision :shell, name:'Application', inline: <<-SHELL
    if [ ! -f ~/.provision/application ]; then
        rm /etc/nginx/conf.d/sites-enabled/default
        cp -f /vagrant/.provision/site.conf /etc/nginx/conf.d/logistic.conf
        cp -f /vagrant/.provision/puma*.conf /etc/init/
        chmod -x /etc/init/puma*.conf
        touch /etc/puma.conf && echo '/vagrant' >> /etc/puma.conf
        if [ ! -d /var/log/puma ]; then
          mkdir -p /var/log/puma
        fi
        touch /etc/environment && echo 'RAILS_ENV=vagrant' >> /etc/environment
        # su -c "cd /vagrant && bundle install" -l vagrant
        cd /vagrant && bundle install
        start puma-manager
        service nginx restart
        echo '192.168.200.150  db' >> /etc/hosts
        echo '127.0.0.1     logistic.jonnyfresh.dev' >> /etc/hosts
        touch ~/.provision/application
    fi
    SHELL
  end

end

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

  config.vm.hostname = 'logistic'
  #config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.network :private_network, ip: "192.168.200.140"
  #config.vm.synced_folder "www", "/var/www/jonnyfresh"
  config.vm.provider :virtualbox do |vb|
    vb.memory = 1024
    vb.linked_clone = true
  end

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

  config.vm.provision :shell, name:'Ruby', inline: <<-SHELL
  if [ ! -f ~/.provision/ruby ]; then
      apt-add-repository -y ppa:brightbox/ruby-ng
      apt-get update -qqy
      apt-get install -y ruby#{_IRV} ruby#{_IRV}-dev
      apt-get install -y libxml2 libxml2-dev libxslt1.1 libxslt1-dev libpq-dev libpq-dev libmysqlclient-dev libsqlite3-dev build-essential
      gem install bundler
      touch ~/.provision/ruby
  fi
  SHELL

  config.vm.provision :shell, name: 'PostgreSQL', inline: <<-SHELL
  if [ ! -f ~/.provision/postgresql ]; then
      wget -qO - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
      apt-add-repository -y "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main"
      apt-get update -qqy
      apt-get install -y postgresql-9.5 postgresql-client libpq-dev
      sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'postgres';"
      sed -i -e "s/#listen_addresses.*/listen_addresses = '*'/" /etc/postgresql/9.5/main/postgresql.conf
      echo 'host  all all 192.168.200.0/24  md5' >> /etc/postgresql/9.5/main/pg_hba.conf
      echo 'host  all all 127.0.0.0/32  md5' >> /etc/postgresql/9.5/main/pg_hba.conf
      service postgresql restart
      touch ~/.provision/postgresql
  fi
  SHELL

  config.vm.provision :shell, name:'SSH', inline: <<-SHELL
    if [ ! -f ~/.provision/ssh ]; then
        cp /vagrant/.provision/developer_rsa /home/vagrant/.ssh/
        touch /home/vagrant/.ssh/config
        echo 'Host bitbucket.org' >> /home/vagrant/.ssh/config
        echo '  Hostname bitbucket.org' >> /home/vagrant/.ssh/config
        echo '  IdentityFile ~/.ssh/developer_rsa' >> /home/vagrant/.ssh/config
        touch ~/.provision/ssh
    fi
  SHELL
end

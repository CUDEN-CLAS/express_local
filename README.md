If you don't care how it works, you just want it to work now; checkout the [short version](README_COMMANDS.md)

# Express Local
A local development environment for Cu Boulder's Web Express Platform. **The playbooks require a vault password to run properly.**

# You will need
* git
* Ansible 1.9.x
* Vagrant
* VirtualBox
* Python 2.7

# Installation
## Ubuntu Installations
* `sudo apt-get install git ansible nfs-kernel-server`

## OSX
* Install Pypthon 2.7 (Can be with [Homebrew](http://brew.sh/))
* Install ansible
  ```
  sudo pip install ansible
  ```

## All operating systems
* Install Vagrant (https://www.vagrantup.com/downloads.html)
* Install VirtualBox (https://www.virtualbox.org/wiki/Downloads)
* Clone this repository
* Edit your hosts file (located at `/etc/hosts`) to include the following
  ```
  # express_local VMs
  192.168.33.20 express.local
  192.168.33.21 inventory.local
  192.168.33.22 log.local

  # Eve API URI
  # Local
  # 192.168.33.21 eveuri
  # DEV
  172.20.62.19  eveuri
  # PROD
  #172.20.62.87 eveuri
  ```
* Edit your SSH config (`~/.ssh/config`) to include the following
  ```
  # Connection information for express_local VMs
  Host 192.168.33.* express.local inventory.local logs.local
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
  User dplagnt
  LogLevel ERROR

  ```
* Change directory to the base of this repository and run `./install.sh` (_You will only ever run this script once_).
  The script will ask you for a SSH key to connect to GitHub and download all of our private repos. If you do not already have access to those repositories, ask a developer.

# This repo includes
* All VMs
  * Vagrant 2
  * Ansible 1.9.4
  * CentOS 6.7
* Webserver - express.local
  * Varnish 3.0.3
  * Apache 2.2.15
  * MySQL 5.6.20
  * PHP 5.3.3
    * CodeSniffer 1.5.6 (with Drupal coding standards)
  * APC 3.1.9
  * Memcache 3.0.6
  * xdebug 2.2.7
  * RVM
  * Behat
  * Logstash Forwarder
  * Drush
    * DSLM
    * Composer
  * Express code
    * cu_fit
    * dslm_base
    * packages_base
    * express_webcentral
* Webserver - inventory.local
  * Additional OS packages
    * Development tools # Allows us to compile Python 2.7
  * Python 2.7.1 # CentOS 6 ships with 2.6 and relies on it for yum to work
    * Flask
    * Eve
    * Celery
    * Fabric
  * Logstash Forwarder
* Webserver - logs.local
  * Elasticsearch
  * Logstash
  * Kibana

# To Dos:
* xprof
* Support SSL properly
* Make sure every package has a version

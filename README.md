# Express Local
A local development environment for Cu Boulder's Web Express Platform.

# You will need
* Vagrant
* VirtualBox
* Python
  * python-yaml
  * python-jinja

# Run these commands first

# Includes
* VMs
  * Vagrant 2
  * Ansible 1.9.4
  * CentOS 6.7
* Webserver - Express
  * Varnish 3.0.3
  * Apache 2.2.15
  * MySQL 5.6.20
  * PHP 5.3.3
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
* Webserver - Inventory
  * Additional OS packages
    * Development tools # Allows us to compile Python 2.7
    * Apache # Specific role for the inventory
  * Python 2.7.1
    * Flask
    * Eve
    * Celery
    * Fabric
  * Logstash Forwarder
* Webserver - Logging
  * Elasticsearch
  * Logstash
  * Kibana

# To Dos:
* xprof
* Support SSL properly
* Make sure every package has a version
* Combine apache roles

# Notes (and debugging)
* CentOS 6 ships with Python 2.6 and relies on it for yum to work. So we are running Python 2.7 in a virtualenv. [Nice Intro to virtualenv](http://www.dabapps.com/blog/introduction-to-pip-and-virtualenv-python/)
* If you are having trouble compiling python packages with errors like `Failed building wheel for [package]` or `Modules/errors.h:8:18: error: [filename].h: No such file or directory` make sure that you have the '-devel' version of the yum package dependency.

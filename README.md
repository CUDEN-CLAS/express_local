If you don't care how it works, you just want it to work now; checkout the [short version](README_COMMANDS.md)

# Express Local
A local development environment for Cu Boulder's Web Express Platform. **The playbooks require a vault password file to run properly.**

# You will need
* git
* Ansible 2.1.x
* Vagrant > 1.8 (recommend 1.8.6)
* VirtualBox 5.1.x
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
* Edit your hosts file (located at `/etc/hosts`) to include the following (_DEV, TEST, and PROD eveuri values are only applicable to CU Boulder_):
  ```
  # express_local VMs
  192.168.33.20 express.local
  192.168.33.21 inventory.local
  192.168.33.22 logs.local

  # Eve API URI
  # Local
  # 192.168.33.21 eveuri
  # DEV
  172.20.62.19  eveuri
  # TEST
  #172.20.62.49 eveuri
  # PROD
  #172.20.62.87 eveuri
  ```
* Edit your SSH config (`~/.ssh/config`) to include the following
  ```
  # Connection information for express_local VMs
  Host 192.168.33.* express.local inventory.local logs.local
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
  User osr_web_deploy
  LogLevel ERROR

  ```
* Copy the ssh keys for the deployment user to `ansible/keys`. Keys need to be passwordless and to be able to read all relevant repositories. When working with multiple developersm, consider create a machine account with a ssh key per user.
* Create `~/.ansible_vault.txt` and enter the vault password. Make sure that only your user has access to the file `chmod 600 ~/.ansible_vault.txt`.

# Logging (Commented out for now)
* Logs are viewable from [logs.local:5601](http://logs.local:5601)
* After each time the VM is provisioned you will need to setup index patterns.
  1. Choose 'Use event times to create index names'
  2. Index Pattern Interval: `Daily`
  3. Index name or pattern: `[logstash-drupal_syslog]-YYYY.MM.DD`
* Create a similar index pattern for [logstash-parsefailure]-YYYY.MM.DD. This pattern will catch log entries that fail to parse correctly.
* Create an index pattern for `logstash*`, do not choose 'Use event times to create index names'. This pattern will match all incoming logs.

# XDebug via PHPStorm
1. Once you have PHPStorm installed, go to PHPStorm > Preferences > PHP and click on the ellipsis in the "Interpreter" section.
2. This will bring up another screen where your PHP interpreters are listed. You want to click the "+" icon to add a "remote" interpreter.
3. On the next screen, you'll have the option of configuring via SSH or Vagrant, and you'll want to choose Vagrant.
4. Now you have to add the "Vagrant Instance Folder". The location where be where you setup your vm, for me it was "~/vms/express_local".
5. If you see the "vagrant host URL" line populate with an address, then you've successfully setup the remote PHP interpreter.
6. If you get an error message saying that the "VboxManage binary" can't be found and needs adding to the PATH variable, then you need to debug that, and there are several ways you could fix your issue. For me, I just had to create a symbolic link to fix the issue.
    ```
    sudo ln -s /usr/local/bin/VBoxManage /usr/bin/VBoxManage
    # Also may need to use this line while SSHing into your VM
    # set VBOX_INSTALL_PATH=%VBOX_MSI_INSTALL_PATH%

    ```
7. Now that PHPStorm is connected to your VM, you need to setup XDebug. The Xdebug extension is already loaded on your machine, but you need to add it to the php.ini settings in order for Apache to load it. To find out where your extension is, you can type the following into your terminal:
    ```
    find / -name 'xdebug.so' 2> /dev/null

    ```
8. You will now need to add the extension to your php.ini settings. On a local Drupal installation, you can go to "/admin/reports/status/php" to see where the php.ini file is being loaded. You should also see a section for other .ini files being parsed and loaded. Look for "xdbug.ini" and open that file in a text editor.
9. Your file will have options already declared in it, but you need to add a line to the top of where your Xdebug extension is located. My xdebug.ini file looks like this:
    ```
    zend_extension=/usr/lib64/php/modules/xdebug.so
    xdebug.remote_enable=1
    xdebug.remote_port=9000
    xdebug.remote_handler="dbgp"
    xdebug.remote_connect_back = 1

    xdebug.profiler_enable=0
    xdebug.profiler_output_dir=/tmp/xdebug_profiles
    xdebug.profiler_enable_trigger=1
    xdebug.profiler_output_name=cachegrind.out.%p

    xdebug.max_nesting_level=200
    ```
10. Once you change that file, you'll need to restart Apache "sudo apachectl restart", and you should see Xdebug now on "/admin/reports/status/php".
11. The last thing to do is to map the folders on your machine to the paths on your VM, PHPStorm > Preferences > PHP > Servers. Because of the symbolic links used in DSLM, the paths will reside in the "dslm_base" and "packages_base" folders. your root level project folder should map to a Drupal core, e.g. "/data/code/dslm_base/cores/drupal-7.41", and the profile path to whichever profile you are using, e.g. "/data/code/dslm_base/profiles/express"
12. Once your path mapping is setup, you should be able to turn on debugging in PHPStorm, Run > Start Listening for PHP Connections, set a breakpoint, and use XDebug from within PHPStorm.

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
  * Logstash
  * Drush
    * DSLM
    * Composer
  * Express code
    * express
    * dslm_base
    * packages_base
    * express_webcentral
* Webserver - inventory.local
  * Additional OS packages
    * Development tools # Allows us to compile Python 2.7
    * Apache 2.4 # Specific role for the inventory
    * GCC
    * MongoDB 2.4.14
    * PIP
  * Python 2.7.1
  * Logstash
* Webserver - logs.local
  * Java - 1.7.0
  * Elasticsearch - 1.6.2
  * Logstash
  * Kibana
  * Redis - 2.4.10

# To Dos:
* xprof
* Support SSL properly
* Make sure every package has a version
* Combine apache roles

# Notes
* If are on OSX you don't like typing your password each time you start the VMs add the following to `/etc/sudoers`. See https://docs.vagrantup.com/v2/synced-folders/nfs.html for other OSs.
  ```
  ## Allows us to run Vagrant (using NFS mount) without having to enter a password.
  Cmnd_Alias VAGRANT_EXPORTS_ADD = /usr/bin/tee -a /etc/exports
  Cmnd_Alias VAGRANT_NFSD = /sbin/nfsd restart
  Cmnd_Alias VAGRANT_EXPORTS_REMOVE = /usr/bin/sed -E -e /*/ d -ibak /etc/exports
  %admin ALL=(root) NOPASSWD: VAGRANT_EXPORTS_ADD, VAGRANT_NFSD, VAGRANT_EXPORTS_REMOVE

  ```

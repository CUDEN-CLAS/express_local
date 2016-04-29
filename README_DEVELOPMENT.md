# Playing with variables
* You can modify variables after they are entered using Jinja2 filters. See http://docs.ansible.com/ansible/playbooks_filters.html.

# Ansible Vaults
There are two encrypted files that define variables as follows you only need to substitute your own values for the variables in square brackets):
* `ansible/roles/apache/defaults/main.yml` defines:
```
API_URI: https://[username]:[password]@eveuri/inventory/
EVE_API_USER: [username]
EVE_API_PW: [password]
EVE_HOST: eveuri
WWWNG_ENV: local_dev

```
* `ansible/roles/python/defaults/main.yml` defines:
```
LDAP_USER: [username]
LDAP_PASSWORD: [password]
GSA_USER: [gsa_username]
GSA_PASSWORD: [gsa_password]

```

# Errors and debugging
* If there are issues with passwordless SSH, check file and directory perms starting at the users home directory. Only the user can have perms to the dirs and files.
* RVM, if you get the following, try again later:
  ```
  failed: [express.local] => {"changed": true, "cmd": "gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3", "delta": "0:00:00.834859", "end": "2016-03-16 22:25:10.460638", "rc": 2, "start": "2016-03-16 22:25:09.625779", "warnings": []}
  stderr: gpg: directory `/root/.gnupg' created
  gpg: new configuration file `/root/.gnupg/gpg.conf' created
  gpg: WARNING: options in `/root/.gnupg/gpg.conf' are not yet active during this run
  gpg: keyring `/root/.gnupg/secring.gpg' created
  gpg: keyring `/root/.gnupg/pubring.gpg' created
  gpg: requesting key D39DC0E3 from hkp server keys.gnupg.net
  gpg: no valid OpenPGP data found.
  gpg: Total number processed: 0
  stdout: gpgkeys: key 409B6B1796C275462A1703113804BB82D39DC0E3 not found on keyserver

  ```
* CentOS 6 ships with Python 2.6 and relies on it for yum to work. So we are running Python 2.7 in a virtualenv. [Nice Intro to virtualenv](http://www.dabapps.com/blog/introduction-to-pip-and-virtualenv-python/).
* CentOS 6 also ships with Apache 2.2. We need Apache 2.4 (2.2 is deprecated and on the way out), so we need to add httpd24. Because we need to side load Pytohn 2.7 and Apache 2.4, we need to compile mod_wsgi by hand. Compiling by hand requires Apache Extension tool (apxs), for that we need to add a library path because of our non standard install locations. After we compile mod_wsgi, we need to move it so that Apache 2.4 can see it.
* If you are having trouble compiling python packages with errors like `Failed building wheel for [package]` or `Modules/errors.h:8:18: error: [filename].h: No such file or directory` make sure that you have the '-devel' version of the yum package dependency.

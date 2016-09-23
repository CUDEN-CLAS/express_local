# Software Packages
Makes use of the centos-release-scl repo mainly because that repo is likely to update with some frequency and because it so far plays somewhat well with our OIT's version of Nessus.
Packages from the centos SCL repo include PHP 5.5.21 and HTTPD 2.4.18 (http2 ready but disabled until it ever matures).

#Install
On Linux systems it doesn't seem to matter which server is provisioned first but on MAC OS X, provision inventory first, then express. You will need a local_settings.py file and an inventory.wsgi file.
Checkout varnish repo branch with version 4 default config file. Checkout inventory branch called "feature/centos7." Contains updates for opcache clearing and varnish version setting in settings.php.
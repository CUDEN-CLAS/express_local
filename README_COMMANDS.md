**Some playbooks require a vault password file to run properly.** Ask one of the developers for this password.

# Running express_local
* Vagrant commands
  * To start the VM, open a Terminal window and type the following commands:  
    ```
    cd ~/vms/express_local
    vagrant up

    ```
  * To stop the VM, open a Terminal window and type the following commands:  
    ```
    cd ~/vms/express_local
    vagrant halt

    ```
  * To start a share session (requires account on atlas.hashicorp.com)
    ```
    cd ~/vms/express_local
    vagrant login
    vagrant share

    ```
* Express_local commands
  * Create a new express site:  
    ```
    cd ~/vms/express_local
    ansible-playbook -i ansible/hosts ansible/express_site.yml

    ```
    ```
    cd ~/vms/express_local
    ansible-playbook -i ansible/hosts ansible/express_site.yml --extra-vars "type=[r,reinstall,c,create] profile=[e,express] path=[anything-you-want]"

    ```
  * Run tests:  
    ```
    cd ~/vms/express_local  
    ansible-playbook -i ansible/hosts ansible/run_tests.yml

    ```
  * Update code to the latest version of Express 2.0:  
    ```
    cd ~/vms/express_local  
    ansible-playbook -i ansible/hosts ansible/update_repos.yml

    ```
* SSH onto the VM:  
  `ssh express.local`
* Commands that run on the VM (_SSH onto the VM first_):
  * Run tests:
    ```
    cd /data/web/express/testing/profiles/cu_fit/tests  
    behat --tags=[tag_you_want_to_test]

    ```
  * Use CodeSniffer.

    `drupalcs` is an alias to phpcs with the Code Standard and types of file extensions to scan predefined. The extensions are `php, module, inc, install, test, profile, theme, js, css, info, txt`
    ```
    phpcs --standard=Drupal /path/to/example.module
    drupalcs /path/to/example.module

    ```

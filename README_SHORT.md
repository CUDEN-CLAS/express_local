**Some playbooks require a 'Vault password' to run properly.** Ask one of the developers for this password.

# Running express_local
* Start Vagrant: `vagrant up`
* Stop Vagrant: `vagrant halt`
* Unlock your SSH key: `cd ~/express_local/data/code/dslm_base/profiles/cu_fit && git pull`
* Create a new express site: `ansible-playbook -i ansible/hosts ansible/express_site.yml`
* Run tests: `ansible-playbook -i ansible/hosts ansible/run_tests.yml`
* SSH onto the VM: `ssh express_local`
* Run tests on the VM (_SSH onto the VM first_):
  ```
  cd /data/web/express/testing/profiles/cu_fit/tests
  behat --tags=[tag_you_want_to_test]
  ```

vagrant halt
ansible-playbook -i ansible/hosts ansible/util_update_repos.yml
vagrant up
vagrant provision

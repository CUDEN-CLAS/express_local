vagrant halt
ansible-playbook -i ansible/hosts ansible/update_repos.yml
vagrant up
vagrant provision

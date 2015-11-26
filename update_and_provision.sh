vagrant halt
ansible-playbook -i ansible/hosts ansible/playbooks/utilities/update_repos.yml
vagrant up
vagrant provision

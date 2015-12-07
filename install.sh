ansible-playbook -i ansible/hosts ansible/setup_clone_repos.yml
vagrant up
ansible-playbook -i ansible/hosts ansible/express_site.yml

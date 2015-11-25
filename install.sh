ansible-playbook -i ansible/hosts ansible/playbooks/utilities/setup_clone_repos.yml
vagrant up
ansible-playbook -i ansible/hosts ansible/playbooks/express/express_site.yml

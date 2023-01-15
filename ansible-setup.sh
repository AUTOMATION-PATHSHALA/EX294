#!/bin/bash

yum install ansible -y

ansible localhost -m shell -a "adduser autoadmin;echo 'devops' | passwd --stdin autoadmin"

ansible localhost -m file -a "path=/home/autoadmin/.ssh state=directory"

ansible localhost -m openssh_keypair -a "path=/home/autoadmin/.ssh/id_rsa owner=autoadmin group=autoadmin type=rsa"

#ansible all -m user -a "name=autoadmin password={{ 'devops' | password_hash('sha512') }}"

ansible all -m shell -a "adduser autoadmin;echo 'devops' | passwd --stdin autoadmin"

ansible all -m file -a "path=/home/autoadmin/.ssh state=directory"

ansible all -m copy -a "src=/home/autoadmin/.ssh/id_rsa.pub dest=/home/autoadmin/.ssh/authorized_keys"

ansible all -m shell -a "echo 'autoadmin ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/autoadmin"

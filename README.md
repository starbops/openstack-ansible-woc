openstack-ansible-woc
=====================


Yet another OpenStack Ansible deployment project but without container!


Supported OpenStack Versions
----------------------------

* Kilo


Deployment Flavor
-----------------

* All-in-One
* *Multi-node* (we're working on it!)


Dependencies
------------

Please refer to [official installation guide](http://docs.ansible.com/ansible/intro_installation.html) for installing the latest Ansible.

For example, if you're using Ubuntu:

~~~ sh
$ sudo apt-get install software-properties-common
$ sudo apt-add-repository ppa:ansible/ansible
$ sudo apt-get update
$ sudo apt-get install ansible
~~~

Python 3rd party package dependencies:

* python-netaddr

~~~ sh
$ pip install netaddr
~~~

Also, the project has Ansible role dependencies:

* geerlingguy.mysql

~~~ sh
$ ansible-galaxy install -r requirements.yml -p roles
~~~


Installation
------------

Firstly, configure variables in `group_vars/all` to suit your need. All the variables are introduced briefly in the last section. Another important place that you must take a look at, it `Vagrantfile`. You might want to change the hostname of the VM. Just in case it won't collide with other existing VMs' hostnmae. And the VM image (box) specified in the config file should be imported before you start up the VM. The last thing to check is the private network setting. If the network segment is changed, corresponding values in `group_vars/all` must be changed, too.

Currently the project supports two providers:

* VirtualBox
* Libvirt (QEMU/KVM)

~~~ sh
$ vagrant up --provider <provider_name>
~~~

To clean up the environment, i.e. remove the VM:

~~~ sh
$ vagrant destroy -f
~~~


Variables
---------

* `geerlingguy.mysql` role:
  * `mysql_root_password`: Password of MySQL root user. Default set to **empty**.

* `openstack` role:
  * `all_in_one`: Deploy OpenStack as All-in-One mode. Default set to `True`
  * `nodes.block.storage_device`: Second disk of block storage node. Default set to `sdb`.



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

Firstly, configure variables in `group_vars/all` to suit your need. All the
variables are introduced briefly in the last section.

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



openstack-ansible-noc
=====================


Yet another OpenStack Ansible deployment project but without container!

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


Usage
-----

Currently support two providers:

* VirtualBox
* Libvirt (QEMU/KVM)

~~~ sh
$ vagrant up --provider <provider_name>
~~~

To clean up the environment, i.e. remove the VM:

~~~ sh
$ vagrant destroy -f
~~~



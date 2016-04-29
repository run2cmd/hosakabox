# hosakabox

Hosakabox is local linux working environment.


## Description
Hosakabox is lightweight VirtualBox VM managed by Vagrant with CentOS 7 and Puppet 3. 
It's purpose is to bring linux working environment to whoever is bound to MS Windows. 
You can have MS Outlook, Lync, MS Office, etc. togheter with linux set of tools
like ruby, python, bash, rpm etc. Hosakabox is aimed for people who need all MS tools,
but mostly develop software, scripts, solution for Linux OS.


## How to use
You might need to change some settings in `Vagrantfile` that describe your VM like
- IP address
- name
- Mounted shares

To start your VM just run
```
vagrant up
```
There is default image there that I personally manage, however you can change it for 
your vagrant image.

## Copyright
Piotr Bugała<Piotr.Bugala@gmail.com>

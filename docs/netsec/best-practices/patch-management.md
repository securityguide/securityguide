---
title: Patch Management
toc: true
---

A deliberate patch management plan is required for all service owners and sysadmins.

Although every development team, service owner or system administrator will determine their own particular plan, what is vitally important is that there is a plan in place.


## System Patching Standards

* Critical/High security updates should be applied as soon as possible but no later than 48 hours after they have been published.
* Medium/Low security updates can wait until a standard maintenance window or weekly/monthly scheduled patching.

If possible, package updates should be installed and tested in a test/dev/staging/uat environment before being deployed in production.

## Automatic Updates

### Windows

Turn on automatic updates.

### Mac

Turn on automatic updates.

### Linux

#### RedHat/Centos/Amazon Linux

Method 1

https://www.centos.org/docs/5/html/yum/sn-updating-your-system.html

The yum package supplied with CentOS includes scripts to perform full system updates every day. To activate automatic daily updates, enter this command:

    sudo '/sbin/chkconfig --level 345 yum on && /sbin/service yum start'

Method 2: use “yum-cron” tool

Enabling automatic updates in Centos 6 and Red Hat 6 (yum-cron version 3.2.29 for CentOS 6):

https://linuxaria.com/pills/enabling-automatic-updates-in-centos-6-and-red-hat-6

Automatic updates for CentOS: yum-cron installing and configuring (yum-cron version 3.4.3, for Amazon Linux and CentOS 7): https://jonathansblog.co.uk/yum-cron

#### Debian/Ubuntu

Install the packages `unattended-upgrades` and `apt-listchanges`:

    apt-get install unattended-upgrades apt-listchanges

* `unattended-upgrades` will automatically install updates.
* `apt-listchanges` will send you email alerts when there are new versions available (defaults to `root`).

To test to make sure it will work:

    unattended-upgrade -d

For more information, see https://wiki.debian.org/UnattendedUpgrades

## Manual Updates

### Redhat/Centos

Make sure you have the yum security plugin installed:

    # yum -y install yum-plugin-security

Update yum’s metadata:

    # yum updateinfo

Check to see what security updates need to be installed:

    # yum updateinfo list sec

Install the security updates:

    # yum -y update-minimal —security

If you want to install *all* the available updates, do this:

    # yum -y update

### Debian/Ubuntu

Manual update:

    # apt-get update && sudo apt-get -y upgrade

### Ansible

Syntax to run the playbook manually:

    ansible-playbook -i inventory update-machines.yml -u <username> -kK

The inventory file is just a list of machines:

    elkkeyrecdb01.thoughtworks.com
    elkkeyrecdb02.thoughtworks.com
    elkkeyrecprod01.thoughtworks.com
    elkkeyrecprod02.thoughtworks.com
    elkkeyrecstaging01.thoughtworks.com
    elkkeyrecstaging02.thoughtworks.com

update-machines.yml is the ansible playbook. Here is some sample syntax:

    ---
    - hosts: all
      sudo: yes

      tasks:
        - name: Install security plugin
          yum: pkg=yum-plugin-security state=present

        - name: Update yum metadata
          command: yum updateinfo

        - name: See what updates are going to be installed
          command: yum check-update --security
          register: packageList

        - debug: msg="The following packages will be updated {{ packageList.stdout }}"

        - name: Install security updates
          command: yum -y update --security


Here’s another playbook example:

    ---
    - hosts: all
      sudo: yes

      tasks:
          - name: update all packages
            action: yum name=* state=latest



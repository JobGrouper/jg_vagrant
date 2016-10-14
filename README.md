# JOBGROUPER VAGRANT ENVIRONMENT

Okay. I'm a little tired, so this is going to be a rough rough version of this tutorial.

## BACKGROUND
-----------

This configuration is meant to mimic our live site as closely as possible. To that end, it includes:

- CentOS 6.8
- PHP 5.6.21
- Composer: 1.1.2
- Apache (httpd): 2.2.31
- MySQL: 5.6.33
- Perl: 5.10.1
- Laravel: 5.2.39

This installation was tested using the latest versions of VirtualBox and Vagrant:

VirtualBox 5.0.26rsomethingorother
Vagrant 1.8.5
Ruby 2.2.5p319

And all that running on Windows 10. These are all the latest versions of this software and are easy enough to find on the WWW.

This tutorial assumes that you have some sort of command line interface available. If not, you may have to get a little creative about cloning from the repo, using Git in general,
SSH'ing into the Vagrant box, etc. I personally like to do all my work using Vim in ConEmu, but if you're just trying to get everything installed, I recommend Git Bash.

You will experience errors during this process. These aren't your fault and they can't be helped, but they can be worked around;
you'll see how. Please list any additional issues you find in this repo's Issues section.

Anyway, I've divided the tutorial up into two sections. Section one is getting Vagrant and VirtualBox to play nice, and section two is primarily about getting the code working on your machine.
So with that, let's get started.

## 1) VAGRANT UP
------------

First things first, clone this repo into whatever folder you want to develop in. It shouldn't matter as long as vagrant can get in there.

Run

`vagrant up`

and wait for this message:

`Authentication Failure: Retrying`

Once you get it, hit Ctrl-C. The terminal will say something like 'Vagrant exited after cleanup,' this is unimportant. Go ahead and run vagrant halt.

### Changing SSH Permissions and Adding Guest Additions 

If you don't experience this error, I congratulate you on being born lucky. Move on to the next section.

If you're normal and are experiencing this error, you should know that the problem has to do with SSH permissions. We need to make sure that Vagrant can have SSH access to the VM. 
However, before we handle that, we're going to take a detour.

Here we're preparing to update the Guest Additions to the VM. If the Guest Additions aren't in sync with the Host Additions, then you will be unable to share folders between the Guest and Host OS,
making it very difficult to actually get any work done (since I'll assume you want to actually work on this code). 

	+ Open the VirtualBox application
	+ Right click our VM (the name should resemble jg_something_or_other) and enter Settings
	+ Go into the Storage Menu
	+ Add an Optical Drive: click the CD with the plus icon
	+ Choose 'Leave Empty'
	+ Start the machine from the VirtualBox program (you need the window to access the Devices menu)
	+ Go into the devices menu, and click "Insert GuestAdditions CD Image"

** Note ** It might say 'invalid settings detected' at the bottom of the Settings Menu. I don't know what they're talking about and I haven't run into any problems...except for the problems we're fixing right now. Maybe they're onto something...

- Enter the username and password
username: vagrant
password: vagrant

1) Take care of the SSH permissions issue

Type in this command

`chmod 0600 ~/.ssh/authorized_keys`

And you're done. Now for the other thing...

2) Installing the Guest Additions

We have to add Guest Additions manually because of some weird Linux problem with GCC and make. Go ahead and input these commands

`sudo mkdir -p /mnt/cdrom`
`sudo mount -t iso9660 -o ro /dev/sr0 /mnt/cdrom`

`cd /mnt/cdrom`
`sudo sh ./VBoxLinuxAdditions.run`

The final command executes the installer. After it starts running, you will probably see the message "Stopping VirtualBox Additions [FAILED]." That means it's working, just give it a second.

Once it's done, power off the machine, and take a breath. Now you'll actually be able to

`vagrant up`

without any problems.

------

** Note for vagrant-hostsupdater **

If you're using vagrant-hostsupdater, you may get an error that requires you to modify the hosts file manually. For Windows 10 users, 
it should be in 

`C:/Windows/System32/drivers/etc/hosts` 

You'll need administrator privileges to make modifications.

## 2) CONFIGURATION
------------

------

1) Run vagrant up (if you haven't already done so)

On this vagrant up the machine will boot the machine and run the provisioning process - basically just installing and configuring all required software.

** Note ** When you get to "Running provisioner: puppet," you may have to wait a while. The system is updating in the background

Optional ) Once this process is completed, You can put localhost:3000 into the browser to make sure your host OS can find Apache on the guest OS. It should work,
but I don't know what you'll see, since there isn't anything in the folders at the moment, which we'll fix right now.

--------

2) Get the JobGrouper Code

Inside the html directory, clone the jobgrouperdevteam repo into a directory called 'application.' To be clear, your directory structure should look like this:

/<jg-vagrant-box-directory>
--/html
----/application

The VM will be looking for these folders, so make sure that they're arranged in just this way.

If you're running this from a terminal, the command looks like this (from inside the html folder)

`git clone https://github.com/JobGrouper/jobgrouperdevteam.git application`

Once the clone is finished, place a copy of the .env and .htaccess files into the application root folder. I've included versions of these files as an attachment on the Trello board.

-------

3) Run Composer

You'll now have to install JobGrouper's dependencies. For this you'll use composer. If you have composer on your host machine, you can run that. 
This tutorial will show you what to do in vagrant's ssh shell. It's a pretty simple set of commands.

`vagrant ssh`
`cd /home/jobgrou2/public_html/application`
`php composer.phar install`

AND THAT'S IT!! You should be done! Type

`http://localhost:3000`

Into your browser of choice and you should see your own version of JobGrouper, ready to be hacked to pieces!

--------

TROUBLESHOOTING SECTION

I'm gonna keep this empty for now, because I'm tired.

--------

PLANNED IMPROVEMENTS

- making the bleh into the home directory
- Aliases (so we can have http://jobgrouper.build instead of localhost:3000)
- utilizing SELinux protocols
- standardized iptables settings
- Installing Git 2.10 (didn't feel like doing it because it's a longer process than you think)

Looking me list these things like I know something about them. I know nothing about them. That's why they're in this section.


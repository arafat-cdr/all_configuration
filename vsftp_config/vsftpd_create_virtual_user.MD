Follow this::
# link ** https://help.ubuntu.com/community/vsftpd

# link ** https://help.ubuntu.com/community/vsftpd

# search: Create The Virtual Users Database

** -----------------------------------------------------

# mkdir /etc/vsftpd # if necessary
# cd /etc/vsftpd
# sudo gedit vusers.txt

VSFTPD: Very Secure File Transfer Protocol Deamon

Introduction

Contents

Introduction
Features
Configuration Instructions and Basic Setup
Download
To disable anonymous login and to enable local users login and give them write permissions:
To chroot users
To deny (or allow) just some users to login
To allow just some users to login:
TLS/SSL/FTPS
Additional Options
Apply new configuration settings
Webmin Module
Set pasv_min_port and pasv_max_port in /etc/vsftpd.conf and allow outbound connections in the ports you set in your firewall.
Virtual users with TLS/SSL/FTPS and a common upload directory - Complicated VSFTPD
The workshop
Create The Virtual Users Database
Sample output:
Configure VSFTPD for virtual user
Create a PAM File Which Uses Your New Database
Append (or create with) the following:
Restart The FTP Server
Test Your Setup
Sample success output:
Troubleshooting
See Also
VSFTPD stands for "Very Secure FTP Daemon" is a GPL licensed FTP server for UNIX systems. It is licensed under the GNU General Public License. It supports IPv6 and SSL. vsftpd supports explicit (since 2.0.0) and implicit (since 2.1.0) FTPS. vsftpd is the default FTP server in the Ubuntu, CentOS, Fedora, NimbleX, Slackware and RHEL Linux distributions. It is secure and extremely fast. It is stable. VSFTPD is a mature and trusted solution which supports virtual users with PAM (pluggable authentication modules). A virtual user is a user login which does not exist as a real login on the system in /etc/passwd and /etc/shadow file. Virtual users can therefore be more secure than real users, because a compromised account can only use the FTP server but cannot login to system to use other services such as SSH or SMTP.

In July 2011, it was discovered that VSFTPD version 2.3.4 downloadable from the master site had been compromised. Users logging into a compromised vsftpd-2.3.4 server may issue a ":)" smiley-face as the username and gain a command shell on port 6200. This was not an issue of a security hole in VSFTPD, instead, someone had uploaded a different version of VSFTPD which contained a backdoor. Since then, the site was moved to Google App Engine.


Features
Despite being small for purposes of speed and security, many more complicated FTP setups are achievable with vsftpd! vsftpd can handle:

Virtual IP configurations
Virtual users
Standalone or inetd operation
Powerful per-user configurability
Bandwidth throttling
Per-source-IP configurability
Per-source-IP limits
IPv6
Encryption support through SSL integration...

Configuration Instructions and Basic Setup
Download
The latest vsftpd release is v3.0.2, currently at https://security.appspot.com/downloads/vsftpd-3.0.2.tar.gz

Or you can install via apt-get like sudo apt-get install vsftpd

Now you can configure it to either allow "local users" to be able to login via ftp, or "virtual users".

To disable anonymous login and to enable local users login and give them write permissions:
Code:
# No anonymous login 
anonymous_enable=NO 
# Let local users login 
# If you connect from the internet with local users, you should enable TLS/SSL/FTPS 
local_enable=YES
# Write permissions 
write_enable=YES 

To chroot users
To jail / chroot users (not the VSFTPD service), there are three choices. Search for "chroot_local_users" on the file and consider one of the following: Code:
# 1. All users are jailed by default:
chroot_local_user=YES
chroot_list_enable=NO

# 2. Just some users are jailed:
chroot_local_user=NO
chroot_list_enable=YES
# Create the file /etc/vsftpd.chroot_list with a list of the jailed users.

# 3. Just some users are "free":
chroot_local_user=YES
chroot_list_enable=YES
# Create the file /etc/vsftpd.chroot_list with a list of the "free" users.

To deny (or allow) just some users to login
To deny some users to login, add the following options in the end of the file: Code: userlist_deny=YES
userlist_file=/etc/vsftpd.denied_users
In the file /etc/vsftpd.denied_users add the username of the users that can't login. One username per line.

To allow just some users to login:
Code: userlist_deny=NO
userlist_enable=YES
userlist_file=/etc/vsftpd.allowed_users
In the file /etc/vsftpd.allowed_users add the username of the users that can login.

The not allowed users will get an error that they can't login before they type their password.

TLS/SSL/FTPS
NOTE: you definitely should use this if you connect from the Internet to your box, otherwise passwords will be sent in plaintext, etc.

To use vsftpd with encryption (it's safer), change or add the following options (some options aren't on the original config file, so add them): Code: ssl_enable=YES
allow_anon_ssl=NO
force_local_data_ssl=YES
force_local_logins_ssl=YES
ssl_tlsv1=YES
ssl_sslv2=NO
ssl_sslv3=NO
# Filezilla uses port 21 if you don't set any port
# in Servertype "FTPES - FTP over explicit TLS/SSL"
# Port 990 is the default used for FTPS protocol.
# Uncomment it if you want/have to use port 990.
# listen_port=990
No need to create a certificate if openssl package is installed!

Install Filezilla (on the client side), and use the Servertype "FTPES - FTP over explicit TLS/SSL" option to connect to your server with TLS/SSL/FTPS.

Additional Options
Here are some other available options. The values are examples: Code: # Show hidden files and the "." and ".." folders.
# Useful to not write over hidden files:
force_dot_files=YES

# Hide the info about the owner (user and group) of the files.
hide_ids=YES

# Connection limit for each IP:
max_per_ip=2

# Maximum number of clients:
max_clients=20

Apply new configuration settings
Don't forget that to apply new configurations, you must restart the vsftpd service. Code:
sudo /etc/init.d/vsftpd restart

Webmin Module
For those who use webadmin, there is a module for VSFTPD here http://www.webmin.com/third.html.

Set pasv_min_port and pasv_max_port in /etc/vsftpd.conf and allow outbound connections in the ports you set in your firewall.
Code:
pasv_min_port=12000
pasv_max_port=12100

Virtual users with TLS/SSL/FTPS and a common upload directory - Complicated VSFTPD
Virtual users are users that do not exist on the system - they are not in /etc/passwd, do not have a home directory on the system, can not login but in vsftpd - or if they do exist, they can login in vsftpd with a non system password - security.

You can set different definitions to each virtual user, granting to each of these users different permissions. If TLS/SSL/FTPS and virtual users are enabled, the level of security of your vsftpd server is increased: encrypted passwords, with passwords that are not used on the system, and users that can't access directly to their home directory (if you want).

The following example is based and adapted on the example for virtual users in vsftpd site, on documentation and the very good examples in this forum that can be found here and here. Currently there is a restriction that with guest_enable enabled, local users also get mapped to guest_username. This is a polite way to say that if the default vsftpd PAM file is used, the system users will be guests too. To avoid confusions change the PAM file used by vsftpd to authenticate only virtual users, make all vsftpd users as virtual users and set their passwords, home and permissions based on this example.


The workshop
Create The Virtual Users Database
To create a "db4" format file to store usernames (another option here would be an apache htpasswd style file, not discussed), first create a plain text files with the usernames and password on alternating lines. For e.g. create user called "vivek" with password called "vivekpass" and sayali with password "sayalipass":

# mkdir /etc/vsftpd # if necessary
# cd /etc/vsftpd
# sudo gedit vusers.txt

Sample output:
vivek
vivekpass
sayali
sayalipass

Next, create the actual database file like this (may require the db_util package to be installed first):

# sudo db_load -T -t hash -f vusers.txt vsftpd-virtual-user.db
# sudo chmod 600 vsftpd-virtual-user.db # make it not global readable
# rm vusers.txt

Configure VSFTPD for virtual user
Edit the vsftpd configuration file (/etc/vsftpd.conf). Add or correct the following configuration options, depending on if they're already listed somewhere in the file or not (or just add these all to the bottom):

anonymous_enable=NO
local_enable=YES
# Virtual users will use the same privileges as local users.
# It will grant write access to virtual users. Virtual users will use the
# same privileges as anonymous users, which tends to be more restrictive
# (especially in terms of write access).
virtual_use_local_privs=YES
write_enable=YES

# Set the name of the PAM service vsftpd will use
pam_service_name=vsftpd.virtual

# Activates virtual users
guest_enable=YES

# Automatically generate a home directory for each virtual user, based on a template.
# For example, if the home directory of the real user specified via guest_username is
# /home/virtual/$USER, and user_sub_token is set to $USER, then when virtual user vivek
# logs in, he will end up (usually chroot()'ed) in the directory /home/virtual/vivek.
# This option also takes affect if local_root contains user_sub_token.
user_sub_token=$USER

# Usually this is mapped to Apache virtual hosting docroot, so that
# Users can upload files
local_root=/home/vftp/$USER

# Chroot user and lock down to their home dirs
chroot_local_user=YES

# Hide ids from user
hide_ids=YES

Save and close the file.

Create a PAM File Which Uses Your New Database
The following PAM is used to authenticate users using your new database. Create /etc/pam.d/vsftpd.virtual: # sudo gedit /etc/pam.d/vsftpd.virtual

Append (or create with) the following:
#%PAM-1.0
auth       required     pam_userdb.so db=/etc/vsftpd/vsftpd-virtual-user
account    required     pam_userdb.so db=/etc/vsftpd/vsftpd-virtual-user
session    required     pam_loginuid.so

Create The Location Of The Files

You need to set up the location of the files / dirs for the virtual users. Type the following command: # mkdir /home/vftp
# mkdir -p /home/vftp/{vivek,sayali}
# chown -R ftp:ftp /home/vftp

Restart The FTP Server
Type the following command:
# service vsftpd restart

Test Your Setup
Open another shell session and type:
$ ftp localhost

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

For add new User Run this:

```bash
sudo  touch /etc/vsftpd/vusers.txt
cat /etc/vsftpd/vusers.txt

sudo nano /etc/vsftpd/vusers.txt
sudo db_load -T -t hash -f /etc/vsftpd/vusers.txt /etc/vsftpd/vsftpd-virtual-user.db
sudo chmod 600 /etc/vsftpd/vsftpd-virtual-user.db

########################################################################################################
echo "" | sudo tee -a /etc/vsftpd/vusers.txt; echo "jarifpass" | sudo tee -a /etc/vsftpd/vusers.txt

sudo db_load -T -t hash -f /etc/vsftpd/vusers.txt /etc/vsftpd/vsftpd-virtual-user.db

sudo chmod 600 /etc/vsftpd/vsftpd-virtual-user.db

sudo mkdir -p /home/vftp/jarif

sudo chown -R ftp:ftp /home/vftp


# rm vusers.txt
```
First:
install:: db4

## sudo apt-get install libdb-dev

```bash

# Then Set Up this:::

## Create a PAM File Which Uses Your New Database
## The following PAM is used to authenticate users using your new database. 

Create /etc/pam.d/vsftpd.virtual: 

sudo gedit /etc/pam.d/vsftpd.virtual

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

```
## To create a virtual user in vsftpd, you can follow these steps:

- sudo apt-get install vsftpd
- sudo useradd myuser
- sudo passwd myuser
- sudo mkdir /home/mydir
- sudo chown myuser:myuser /home/mydir
- sudo chmod 755 /home/mydir

# now nano /etc/vsftpd.conf

```bash
listen=YES
anonymous_enable=NO
local_enable=YES
virtual_use_local_privs=YES
write_enable=YES
local_umask=022
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
chroot_local_user=YES
secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
guest_enable=YES
guest_username=myuser
user_sub_token=$USER
local_root=/home/$USER/mydir
hide_ids=YES

```


### In this configuration, myuser is the virtual user that you created in step 2, and /home/mydir is the directory that you created in step 4.

## Restart vsftpd

- sudo /sbin/service vsftpd restart

The instructions should be applicable to other Linux Ubuntu versions.

## Install VSFTPD Server :
- Open Terminal
- sudo apt update
- sudo apt install vsftpd
- sudo service vsftpd status

## Configure Firewall :
- sudo ufw allow 20/tcp
- sudo ufw allow 21/tcp
- sudo ufw allow 40000:50000/tcp
- sudo ufw allow 990/tcp
- sudo ufw allow openssh
- sudo ufw enable
- sudo ufw status

## Delete a Firewall rule
- sudo ufw status numbered
- sudo ufw delete 3
- sudo ufw status numbered


## Create FTP User:
- sudo adduser ftpuser
- sudo mkdir /home/ftpuser/ftp
- sudo chown nobody:nogroup /home/ftpuser/ftp
- sudo chmod a-w /home/ftpuser/ftp
- sudo mkdir /home/ftpuser/ftp/files
- sudo chown ftpuser:ftpuser /home/ftpuser/ftp/files
- sudo chmod 775 /home/ftpuser/ftp
- echo "ftpuser" | sudo tee -a /etc/vsftpd.userlist

## VSFTPD Server Configuration :
bkup: sudo mv /etc/vsftpd.conf /etc/vsftpd.conf.bkup
- sudo nano /etc/vsftpd.conf

```bash
listen=NO
listen_ipv6=YES
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
chroot_local_user=YES
secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
force_dot_files=YES
pasv_min_port=40000
pasv_max_port=50000

user_sub_token=$USER
local_root=/home/$USER/ftp
allow_writeable_chroot=YES
tcp_wrappers=YES

userlist_file=/etc/vsftpd.userlist
userlist_deny=NO
userlist_enable=YES

xferlog_enable=YES
log_ftp_protocol=YES
xferlog_file=/var/log/ftp/xferlog

```
## Now:
sudo chown root /etc/vsftpd/vsftpd.conf

- sudo systemctl restart vsftpd.service
## or
sudo /sbin/service vsftpd restart

```bash
Checking Ftp Connections:
Local test
ftp ftpuser:password@localhost
remote test
ftp ftpuser:password@x.x.x.x
```

## How to Change Vsftpd Default port

# /etc/vsftp/vsftpd.conf
```bash
listen_port=A
ftp_data_port=B
```

**For example if you want the vsftpd service to run on ports 2020 and 2121 respectively, add below lines to the configuration file /etc/vsftp/vsftpd.conf.

# example
```bash
Here,
A – listening port.
B – data originate port.
```

# /etc/vsftp/vsftpd.conf
```bash
listen_port=2020
ftp_data_port=2121
```

# Now restart the vsftpd service
```bash
sudo /sbin/service vsftpd restart
```


# original post url
https://www.thegeekdiary.com/centos-rhel-how-to-change-vsftpd-port-number-from-the-default-port-numbers-20-and-21/


** Test FTP Connection
- We recommend FileZilla, which works on Windows, Mac and Linux : https://filezilla-project.org/

We recommended to secure your FTP server, you can watch the second video which describes the steps of securing an FTP server :  📽 🎞 ▶ https://youtu.be/N7hwrPiji3c


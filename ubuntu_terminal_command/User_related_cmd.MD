##  Create FTP User:
- sudo adduser ftpuser
- sudo mkdir /home/ftpuser/ftp
- sudo chown nobody:nogroup /home/ftpuser/ftp
- sudo chmod a-w /home/ftpuser/ftp
- sudo mkdir /home/ftpuser/ftp/files
- sudo chown ftpuser:ftpuser /home/ftpuser/ftp/files
- sudo chmod 775 /home/ftpuser/ftp
- echo "ftpuser" | sudo tee -a /etc/vsftpd.userlist

## Check all User:

** getent passwd
# or
** cat /etc/passwd

## check all Ftp User

** cat /etc/passwd | grep 'first_user'

## Or

**   grep ftp /etc/passwd | cut -d: -f1 | sort

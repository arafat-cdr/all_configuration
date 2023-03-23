```bash

# working Example::

mysqldump -u root -p ebelong-prod > test.sql

# It will Download the ebelong-prod database to its ssh login 
# directory and rename it test.sql
# Now we will download to our local ubnuntu using below command
# scp mean secure copy use for network file download from source to desitination

scp -i "ebelong.pem" ec2-user@ec2-54-225-91-98.compute-1.amazonaws.com:test.sql ~/Desktop/log_with_others/logs/fiverr/2023/adeel/ebelongs

# Our file is in the same directory where we logged in and its name test.sql
# That's why we use--> :test.sql

# Now we are saving this to our ubuntu machine here-->

# ~/Desktop/log_with_others/logs/fiverr/2023/adeel/ebelongs 


```



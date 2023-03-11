# In order to send attachment we need to use path not url
## if our mail sending script in root folder and our pdf file path is
**pdf/pdfs/3eba5b6cd8edd162a13ac2dee5e88d8c.pdf

***Then we pass it this way

### $res = send_mail('arafat@sendmail.com', 'Test mail from server', 'Hello there', 'pdf/pdfs/3eba5b6cd8edd162a13ac2dee5e88d8c.pdf');

#### $mail->AddAttachment('pdf/pdfs/3eba5b6cd8edd162a13ac2dee5e88d8c.pdf');

#### if you send the url instead of file path then it will give you not able to access file Issue
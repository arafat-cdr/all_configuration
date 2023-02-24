```php
<?php

if (extension_loaded('ssh2')) {
  // echo "SSH2 extension is enabled!";
} else {
  echo "SSH2 extension is not enabled. Run<br/>";

  echo "install any of this: php8.2-ssh2 php8.1-ssh2 php8.0-ssh2 php7.4-ssh2 php7.3-ssh2 php7.2-ssh2 php7.1-ssh2 php7.0-ssh2
  php5.6-ssh2 php-ssh2-all-dev php-ssh2 <br/>";

  echo 'example: sudo apt-get install  php8.0-ssh2 <br/>';

  echo 'Your Full PHP version: ' . phpversion().'<br/>';
  echo 'Your short version '.substr(phpversion(), 0,3).'<br/>';

  echo 'Run this command example: sudo apt-get install  php'.substr(phpversion(), 0,3).'-ssh2 <br/>';

  echo 'Now Run This: sudo /etc/init.d/apache2 restart<br/>';
  die();
}

if( !function_exists( 'pr' ) ){

	function pr($data){
		echo '<pre>';
		print_r($data);
		echo '</pre>';
	}

}

$host = 'x.x.x.x';
$port = 2222;
$username = 'ssh_user_name';
$password = 'ssh_password_here';

$ftp_username = 'my_ftp_user_name';
$ftp_password = 'my_given_pass';
$ftp_directory = "/home/$ftp_username/ftp";

// Establish SSH connection
$connection = ssh2_connect($host, $port);

if (ssh2_auth_password($connection, $username, $password)) {
  // echo "Authentication successful!\n";

  #---------------------------------------

  // $ftp_command = "sudo useradd -m -d $ftp_directory $ftp_username -s /usr/sbin/nologin";
  $ftp_command  = "sudo useradd -m -p $(openssl passwd -1 $ftp_password) $ftp_username";
  $ftp_command = "echo '" . $password . "' | sudo -S " . $ftp_command;

  $stream = ssh2_exec($connection, $ftp_command);
  stream_set_blocking($stream, true);
  $output = stream_get_contents($stream);
  fclose($stream);

  // pr($output);

  $ftp_command = "sudo mkdir $ftp_directory && sudo mkdir $ftp_directory/files && sudo chown $ftp_username:$ftp_username $ftp_directory/files && sudo chmod 775 $ftp_directory && echo $ftp_username | sudo tee -a /etc/vsftpd.userlist";

  $ftp_command = "echo '" . $password . "' | sudo -S " . $ftp_command;
  $stream = ssh2_exec($connection, $ftp_command);
  stream_set_blocking($stream, true);
  $output = stream_get_contents($stream);
  fclose($stream);


  $ftp_command = "sudo chown nobody:nogroup $ftp_directory && sudo chmod a-w $ftp_directory";
  $ftp_command = "echo '" . $password . "' | sudo -S " . $ftp_command;

  $stream = ssh2_exec($connection, $ftp_command);
  stream_set_blocking($stream, true);
  $output = stream_get_contents($stream);
  fclose($stream);

  // pr($output);

  #---------------------------------------

  echo json_encode(
  	array(
  	    	'ftp_user' => $ftp_username,
  	    	'ftp_pass' => $ftp_password,
  	    	'ftp_directory' => $ftp_directory,
  	    )
  );

}else {
  echo "Authentication failed.\n";
}

```
<?php
//include('Net/SSH2.php');

$ftp_server = "cslab2.kku.ac.kr";
$ftp_username ="200917307";
$ftp_password = "900705";

$connection = ssh2_connect($ftp_server, 22);
$login = ssh2_auth_password($connection, $ftp_username, $ftp_password);


var_dump($login);	// true로 나오면 정상 접속.	

//$sftp = ssh2_sftp($connection);		


//$sftp_dir = "ssh2.sftp://$sftp/home/아이디/경로/";	
?>
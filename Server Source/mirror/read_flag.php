<?php
$myfile = fopen("flag.txt", "r") or die("Unable to open file!");
$result = json_decode(fread($myfile,filesize("flag.txt")));
fclose($myfile);


if($result->flag == 0)
{
	$oConnection = ssh2_connect('cslab2.kku.ac.kr', '22');
	ssh2_auth_password($oConnection, '200917307','900705');
	$stream = ssh2_exec($connection, "rm /public_html/login_face/cam.jpg");
    $errorStream = ssh2_fetch_stream($stream, SSH2_STREAM_STDERR);
	echo "{\"flag\":\"0\"}"; 
}
else
{
	$oConnection = ssh2_connect('cslab2.kku.ac.kr', '22');
	ssh2_auth_password($oConnection, '200917307','900705');
	ssh2_scp_send($oConnection,'/var/www/html/cam.jpg','/home/students/200917307/public_html/login_face/cam.jpg',0644);
	echo "{\"flag\":\"1\"}"; 
}
?>
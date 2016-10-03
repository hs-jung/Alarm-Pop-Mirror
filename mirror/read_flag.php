<?php
$myfile = fopen("flag.txt", "r") or die("Unable to open file!");
$result = json_decode(fread($myfile,filesize("flag.txt")));
fclose($myfile);


if($result->flag == 0)
{
	echo "{\"flag\":\"0\"}"; 
}
else
{
	echo "{\"flag\":\"1\"}"; 
}
?>
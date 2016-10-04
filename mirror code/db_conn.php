<?php

$conn = mysqli_connect("222.116.135.137", "kalon", "rjsrnreo09", "apm");

if(mysqli_connect_errno())
{
	echo "Fail to connet to mysql : ", mysqli_connect_errno();
}
?>
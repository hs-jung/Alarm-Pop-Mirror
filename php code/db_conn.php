<?php

$conn = mysqli_connect("10.251.20.182", "dbadmin", "tksgk1209", "apm");

if(mysqli_connect_errno())
{
	echo "Fail to connet to mysql : ", mysqli_connect_errno();
}
?>
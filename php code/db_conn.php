<?php

$conn = mysqli_connect("10.", "dbadmin", "tksgk1209", "apm");

if(mysqli_connect_errno())
{
	echo "Fail to connet to mysql : ", mysqli_connect_errno();
}
?>
<?php
		date_default_timezone_set('Asia/Seoul');
	$t = time();
	$months = [ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
	$index = (int)substr(date("Y-m-d",$t),5,2)-1;
	$monthstr = $months[$index];
		        //datestr = time.getDate() +" "+  monthstr;
	echo "<font size=\"20px\">".date("m",$t)." ".$monthstr."</font>";

	//echo $monthstr;
?>

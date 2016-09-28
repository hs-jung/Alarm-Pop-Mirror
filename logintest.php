
<?php

include_once 'db_conn.php';

$id =$_GET['id'];
 
$pw = $_GET['pw'];

global $conn;

$sql = "select count(*) cnt from user where uuid = '".$id."' and pw = PASSWORD('".$pw."');";

//echo $sql;
//echo "<br><br>";
$result = mysqli_query($conn, $sql) or die("[{\"Success\":\"3\"}]");
mysqli_data_seek($result,0);
$row = mysqli_fetch_array($result);
$total_record = $row['cnt'];

if($total_record == 1)
{
	echo "{\"Success\":\"1\"}";
}
else
{
	echo "{\"Success\":\"2\"}";
}
?>
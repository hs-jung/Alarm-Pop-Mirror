<?php
	
  include_once 'db_conn.php';

  $id =$_POST['id'];
  $nickname = $_POST['nickname'];
  $pw = $_POST['pw'];

  if(mysqli_connect_errno())
  {
    echo "Fail to connet to mysql : ", mysqli_connect_errno();
  }

  mysqli_query($conn, "set session character_set_connection=UTF-8;");

  $sql1 = "insert into user (uuid, pw, uname, uface) value ( '".$id."',PASSWORD('".$pw."'), '".$nickname."', 'temp_value');";
  $result1 = mysqli_query($conn, $sql1) or die("{\"Success\":\"2\"}");   
  
  echo "{\"Success\":\"1\"}";
    
?>
<?php
	
  include_once 'db_conn.php';

  $id =$_POST['id'];
  $ymdt = $_POST['ymdt'];
  $content = $_POST['subject'];

  if(mysqli_connect_errno())
  {
    echo "Fail to connet to mysql : ", mysqli_connect_errno();
  }

  mysqli_query($conn, "set session character_set_connection=UTF-8;");

  $sql1 = "insert into schedule (uuid, subject, ymdt) value ( '".$id."','".$content."', '".$ymdt."');";

  $result1 = mysqli_query($conn, $sql1) or die("{\"Success\":\"3\"}");   

  echo "{\"Success\":\"1\"}";
    
?>
<?php

include_once 'db_conn.php';

  $id =$_POST['id'];
  $content = $_POST['content'];

  if(mysqli_connect_errno())
  {
    echo "Fail to connet to mysql : ", mysqli_connect_errno();
  }

  mysqli_query($conn, "set session character_set_connection=UTF-8;");

  $sql = "update memo set content = '".$content."' where uuid = '".$id."';";
  $result1 = mysqli_query($conn, $sql) or die("[{\"Success\":\"3\"}]");
  echo "{\"Success\":\"1\"}";
      
     
?>
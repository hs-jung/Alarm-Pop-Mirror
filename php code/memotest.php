<?php

include_once 'db_conn.php';

  $id =$_GET['id'];

  if(mysqli_connect_errno())
  {
    echo "Fail to connet to mysql : ", mysqli_connect_errno();
  }

  mysqli_query($conn, "set session character_set_connection=UTF-8;");

  $sql = "select umemo_id, content from memo where uuid = '".$id."';";
  $result = mysqli_query($conn, $sql) or die("[{\"umemo_id\":\"-3\"}]");        //success : 3 Db연결오류   
  mysqli_data_seek($result,0);
  $row = mysqli_fetch_array($result);

  echo "{\"umemo_id\":\"$row[umemo_id]\",\"content\":\"$row[content]\"}";
      
     
?>
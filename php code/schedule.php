<?php

include_once 'db_conn.php';

  $id =$_POST['id'];

  if(mysqli_connect_errno())
  {
    echo "Fail to connet to mysql : ", mysqli_connect_errno();
  }

  mysqli_query($conn, "set session character_set_connection=UTF-8;");

  $sql = "select schedule_id, subject, ymdt from schedule where uuid = '".$id."';";
  $result = mysqli_query($conn, $sql) or die("[{\"umemo_id\":\"-3\"}]");        //success : 3 Db연결오류   
  mysqli_data_seek($result,0);
  $row = mysqli_fetch_array($result);

  echo "{\"schedule_id\":\"$row[schedule_id]\",\"subject\":\"$row[subject]\",\"ymdt\":\"$row[ymdt]\"}";
      
     
?>
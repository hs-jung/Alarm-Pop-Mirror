<?php

include_once 'db_conn.php';

  $id =$_POST['id'];
  $schedule_id = $_POST['sid'];

  if(mysqli_connect_errno())
  {
    echo "Fail to connet to mysql : ", mysqli_connect_errno();
  }

  mysqli_query($conn, "set session character_set_connection=UTF-8;");

  $sql = "delete from schedule where uuid = '".$id."' and  schedule_id =".$schedule_id.";";
  $result = mysqli_query($conn, $sql) or die("[{\"umemo_id\":\"-3\"}]");        //success : 3 Db연결오류   
 
?>
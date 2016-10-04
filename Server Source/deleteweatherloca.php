<?php

include_once 'db_conn.php';

  $id =$_POST['id'];
  $stdid=$_POST['stdid'];
  $city = $_POST['location'];

  if(mysqli_connect_errno())
  {
    echo "Fail to connet to mysql : ", mysqli_connect_errno();
  }
  
  mysqli_query($conn, "set session character_set_connection=UTF-8;");

  $sql = "delete from location where uuid='".$id."' and ulid =".$stdid.";";
  $result = mysqli_query($conn, $sql) or die("{\"Success\":\"-3\"}");        //success : 3 Db연결오류   

  echo "{\"Success\":\"1\"}"

?>
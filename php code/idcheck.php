<?php

 // $conn = mysqli_connect("222.116.135.137", "windadmin", "project06", "wind");
  include_once 'db_conn.php';

  $id =$_POST['id'];

  if(mysqli_connect_errno())
  {
    echo "Fail to connet to mysql : ", mysqli_connect_errno();
  }

  mysqli_query($conn, "set session character_set_connection=UTF-8;");

  $sql = "select count(*) cnt from user where uuid = '".$id."';";
  $result = mysqli_query($conn, $sql) or die("[{\"Success\":\"3\"}]");        //success : 3 Db연결오류   
  mysqli_data_seek($result,0);
  $row = mysqli_fetch_array($result);
  $total_record = $row['cnt'];

  //already enrolled address
  if($total_record > 0 )
  {
    echo "{\"Success\":\"2\"}";
  }
  else if($total_record == 0)
  {
     echo "{\"Success\":\"1\"}";
  }
 
  

?>
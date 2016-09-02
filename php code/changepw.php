<?php

 include_once 'db_conn.php';

  $id =$_POST['id'];
  $new_pw = $_POST['new_pw'];
  $pw = $_POST['pw'];

  if(mysqli_connect_errno())
  {
    echo "Fail to connet to mysql : ", mysqli_connect_errno();
  }

  mysqli_query($conn, "set session character_set_connection=UTF-8;");

  $sql = "select count(*) cnt from user where uuid = '".$id."' and pw = PASSWORD('".$pw."');";
  $result = mysqli_query($conn, $sql) or die("[{\"Success\":\"3\"}]");        //success : 3 Db연결오류   
  mysqli_data_seek($result,0);
  $row = mysqli_fetch_array($result);
  $total_record = $row['cnt'];

  //already enrolled address
  if($total_record > 0 )
  {
    $sql1 = "update user set pw = PASSWORD('".$new_pw."') where uuid = '".$id."' and pw = PASSWORD('".$pw."');";
    $result1 = mysqli_query($conn, $sql1) or die("[{\"success\":\"3\"}]");
    echo "{\"Success\":\"1\"}";
  }
  else if($total_record == 0)
  {
     echo "{\"Success\":\"2\"}";
  }
 
  

 


?>
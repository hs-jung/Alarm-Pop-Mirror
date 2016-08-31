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

 $sql = "update user set pw = PASSWORD('".$new_pw."') where uuid = '".$id."' and pw = PASSWORD('".$pw."');";
 $result = mysqli_query($conn, $sql) or die("[{\"success\":\"3\"}]");

 echo "{\"Success\":\"1\"}";


?>
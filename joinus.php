<?php
	
  include_once 'db_conn.php';

  $id =$_POST['id'];
  $nickname = $_POST['nickname'];
  $pw = $_POST['pw'];
  $img1 = $_FILES['img1']['name'];
  $img2 = $_FILES['img2']['name'];
  $img3 = $_FILES['img3']['name'];
  /*

  if(mysqli_connect_errno())
  {
    echo "Fail to connet to mysql : ", mysqli_connect_errno();
  }

  mysqli_query($conn, "set session character_set_connection=UTF-8;");

  $sql1 = "insert into user (uuid, pw, uname, uface) value ( '".$id."',PASSWORD('".$pw."'), '".$nickname."', 'temp_value');";
  $result1 = mysqli_query($conn, $sql1) or die("{\"Success\":\"2\"}");   

  $sql2 = "insert into memo (uuid, subject, content) value ( '".$id."','', 'Insert Memo');";
  $result2 = mysqli_query($conn, $sql2) or die("{\"Success\":\"2\"}"); 

  $sql3 = "insert into checkupdate (uuid) value ( '".$id."');";
  $result3 = mysqli_query($conn, $sql3) or die("{\"Success\":\"2\"}"); 
  
  echo "{\"Success\":\"1\"}";

  */

  echo $img1;
  echo "<br><br>";
  echo $img2;
  echo "<br><br>";
  echo $img3;
    
?>
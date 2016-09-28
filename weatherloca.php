<?php

include_once 'db_conn.php';

  $id =$_POST['id'];

  if(mysqli_connect_errno())
  {
    echo "Fail to connet to mysql : ", mysqli_connect_errno();
  }
  
  mysqli_query($conn, "set session character_set_connection=UTF-8;");

  $sql = "select ulid, city from location where uuid = '".$id."';";
  $result = mysqli_query($conn, $sql) or die("{\"rows\":\"-3\"}");        //success : 3 Db연결오류   
  mysqli_data_seek($result,0);
  $row = mysqli_fetch_array($result);
  $total_record = mysqli_num_rows($result);

if($total_record <= 0)
{
  echo "{\"rows\":\"0\"}";
 
}
else if($total_record == 1)
{
  echo "{\"rows\":\"1\",\"stdid\":\"$row[ulid]\",\"city\":\"$row[city]\"}";
}
else
{
  $j=0;
  echo "{\"rows\":\"$total_record\",\"array\":";
  echo "[";

  for($i=0;$i<$total_record;$i++)
  {
     mysqli_data_seek($result,$i);
     $row = mysqli_fetch_array($result);
     echo "{\"stdid\":\"$row[ulid]\",\"city\":\"$row[city]\"}";
    
     if(mysqli_data_seek($result,++$j))
     {
      echo ",";
     }
     else
     {
      echo "]}";
     }

  }
  
}


?>
<?php

include_once 'db_conn.php';

  $id =$_POST['id'];
  date_default_timezone_set('Asia/Seoul');
  $strtime =  date("Y-m-d",time());

  if(mysqli_connect_errno())
  {
    echo "Fail to connet to mysql : ", mysqli_connect_errno();
  }
  
  mysqli_query($conn, "set session character_set_connection=UTF-8;");

  $sql = "select schedule_id, subject, ymdt from schedule where uuid = '".$id."' and  ymdt like '".$strtime."%' order by ymdt;";
  $result = mysqli_query($conn, $sql) or die("[{\"umemo_id\":\"-3\"}]");        //success : 3 Db연결오류   
  mysqli_data_seek($result,0);
  $row = mysqli_fetch_array($result);
  $total_record = mysqli_num_rows($result);

if($total_record <= 0)
{
  echo "{\"rows\":\"$total_record\"}";
 
}
else if($total_record == 1)
{
  echo "{\"rows\":\"1\",\"schedule_id\":\"$row[schedule_id]\",\"subject\":\"$row[subject]\",\"ymdt\":\"$row[ymdt]\"}";
}
else
{
  //echo "{\"rows\":\"$total_record\"}";


  
  $j=0;
  echo "{\"rows\":\"$total_record\",\"array\":";
  echo "[";

  for($i=0;$i<$total_record;$i++)
  {
     mysqli_data_seek($result,$i);
     $row = mysqli_fetch_array($result);
     echo "{\"schedule_id\":\"$row[schedule_id]\",\"subject\":\"$row[subject]\",\"ymdt\":\"$row[ymdt]\"}";
     
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
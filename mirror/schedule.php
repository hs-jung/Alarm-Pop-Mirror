<html>
<head>
</head>
<body style="margin-top:0px; margin-bottom: 0px;">

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
  echo "<font size=\"5px\" color='#323434'>No schedule</font>";
 
}
else if($total_record == 1)
{
  echo "<font size=\"5px\" color='#323434'> $row[subject] </font> <br> <font size=\"4px\" color='#323434'>&nbsp".substr("$row[ymdt]",11,5)."</font>";
}
else
{
  $j=0;

  for($i=0;$i<$total_record;$i++)
  {
     mysqli_data_seek($result,$i);
     $row = mysqli_fetch_array($result);
     echo "<font size=\"5px\" color='#323434'> $row[subject]</font> <br> <font size=\"4px\" color='#323434'>&nbsp".substr("$row[ymdt]",11,5)."</font>";
     
     if(mysqli_data_seek($result,++$j))
     {
      echo "<hr style=\"margin-top: 6px; margin-bottom: 0px;\">";
     }
     else
     {
      echo "";
     }

  }
  
}
?>
</body>
</html>
<html>
<head>
</head>
<body style="margin-top:0px; margin-bottom: 0px;">
<?php

  include_once 'db_conn.php';

  $id = $_POST["id"];

  if(mysqli_connect_errno())
  {
    echo "Fail to connet to mysql : ", mysqli_connect_errno();
  }

  mysqli_query($conn, "set session character_set_connection=UTF-8;");

  $sql = "select umemo_id, content from memo where uuid = '".$id."';";
  $result = mysqli_query($conn, $sql) or die("[{\"umemo_id\":\"-3\"}]");        //success : 3 Db연결오류   
  mysqli_data_seek($result,0);
  $row = mysqli_fetch_array($result);

  //echo "<font size=\"5px\" color=\"#222644\" face=\"Nanum Gothic\">".$row[content]."</font>";
  echo "<font size=\"5px\" color=\"#ffffff\" face=\"Nanum Gothic\">".$row[content]."</font>";
?>
</body>
</html>    

<html>

<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8"></head>

<body>
<?php

include_once 'db_conn.php';

  $id =$_POST['id'];
  $content = $_POST['content'];

  if(mysqli_connect_errno())
  {
    echo "Fail to connet to mysql : ", mysqli_connect_errno();
  }

 echo $content;
     
?>

</body>

</html>
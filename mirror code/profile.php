<html>
<head>
	<script>
	   
	</script>

	<style type="text/css">

		 
		@import url('http://fonts.googleapis.com/earlyaccess/nanumgothic.css');
        body, table, div, p {font-family:'Nanum Gothic';}

        #box3 { 
        	width:100px; text-align:center; vertical-align:middle;
        }

        #time {
          	font-size:150px;
          	color: white;
          	font-weight: bold;
          
        }

        #date {
          	font-size:17px;
          	color: #ffffff;
          	
        }
        #date p{
        	vertical-align: middle;

        }

        body {
        	margin: 0px;
            background: center; 
            background-color: #46529E;
            overflow-y:hidden;
        }
    
    </style>
 </head>
 <body >
 	<div style="float: right; width:70px; height: 70px;">
    	<img src="http://cslab2.kku.ac.kr/~200917307/login_face/cam.jpg" width="70"; height="70"/>
    </div>

    <div style="float: left; width:120px; height: 70px; padding-left: 0px; font-family:'Nanum Gothic';">
    	<?php 
      include_once 'db_conn.php';

      $id =$_POST['id'];

      if(mysqli_connect_errno())
      {
        echo "Fail to connet to mysql : ", mysqli_connect_errno();
      }

      mysqli_query($conn, "set session character_set_connection=UTF-8;");

      $sql1 = "select uname from user where uuid='".$id."';";
      $result1 = mysqli_query($conn, $sql1) or die("{\"Success\":\"2\"}");   
      mysqli_data_seek($result1,0);
      $row = mysqli_fetch_array($result1);

      echo "<p id=\"date\" align=\"center\" style=\"margin-top: 23px; margin-bottom: 0px; height: 24px\">hi ".$row['uname']."!</p>"; 

      ?>
    </div>
    
	
	
</body>
</html>
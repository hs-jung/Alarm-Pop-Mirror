<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
	    <meta name="description" content="Metro, a sleek, intuitive, and powerful framework for faster and easier web development for Windows Metro Style.">
	    <meta name="keywords" content="HTML, CSS, JS, JavaScript, framework, metro, front-end, frontend, web development">
	    <meta name="author" content="Sergey Pimenov and Metro UI CSS contributors">

	    <link rel='shortcut icon' type='image/x-icon' href='favicon.ico' />
	    <title>APM Mirror Device</title>

	    <link href="css/metro.css" rel="stylesheet">
	    <link href="css/metro-icons.css" rel="stylesheet">
	    <link href="css/metro-responsive.css" rel="stylesheet">
	    <link href="css/metro-schemes.css" rel="stylesheet">
	    <link href="css/metro-colors.css" rel="stylesheet">
	    <link href="css/docs.css" rel="stylesheet">

        <script language="JavaScript">

                //alert(1);
        function requestFullScreen() {
         var element = document.body;
         console.debug(element);
            // Supports most browsers and their versions.
         var requestMethod = element.requestFullScreen || element.webkitRequestFullScreen || element.mozRequestFullScreen || element.msRequestFullScreen;

         if (requestMethod) { // Native full screen.
             requestMethod.call(element);
         } else if (typeof window.ActiveXObject !== "undefined") { // Older IE.
             var wscript = new ActiveXObject("WScript.Shell");
             if (wscript !== null) {
                 wscript.SendKeys("{F11}");
             }
         }

         var docElm = document.documentElement;
         if (docElm.requestFullscreen) {
             docElm.requestFullscreen();
         }
         else if (docElm.mozRequestFullScreen) {
             docElm.mozRequestFullScreen();
         }
         else if (docElm.webkitRequestFullScreen) {
             docElm.webkitRequestFullScreen(Element.ALLOW_KEYBOARD_INPUT);
         }
        }

        window.onload = function() {
        setInterval(function() {checkupdate() }, 5000);
        }

        function checkupdate()
        {
            var id = <?php echo "\"".$_POST['id']."\""; ?>

            
            $.ajax({
                type: "POST",
                url: "checkupdate.php",
                data: {
                    "id":id
                },
                success: function(data)
                {
                    switch(data)
                    {
                        case "000":
                        break;
                        case "001":
                        break;
                        case "010":
                        break;
                        case "011":
                        break;
                        case "100":
                        break;
                        case "101":
                        break;
                        case "110":
                        break;
                        case "111":
                        break;


                    }   
                }



            });
            <?php
                  include_once 'db_conn.php';

                  $id = $_POST['id'];
                  date_default_timezone_set('Asia/Seoul');
                  $strtime =  date("Y-m-d",time());

                  if(mysqli_connect_errno())
                  {
                    echo "Fail to connet to mysql : ", mysqli_connect_errno();
                  }
                  
                  mysqli_query($conn, "set session character_set_connection=UTF-8;");

                  $sql = "select scheck, mcheck, wcheck from checkupdate where uuid = '".$id."';";
                  $result = mysqli_query($conn, $sql) or die("[{\"umemo_id\":\"-3\"}]");        //success : 3 Db연결오류   
                  mysqli_data_seek($result,0);
                  $row = mysqli_fetch_array($result);

                  //if($row["scheck"] == 0) echo "alert(\"bingo\");";
                  

                 //echo "alert(\"row: $row[scheck]\");";
            ?>
        }

       //document.getElementById('id').submit();
        //-->
        </script>
        <style type="text/css">
            body
            {
                background: center; 
                background-color: #777;
                overflow:hidden;
                font-family:'Nanum Gothic';
            }

            #news {
                color: #222644;
                background-color: #c3c5c5;
                border-color: #00838F;
            }

            #schedule{
                color: black;
                background-color: #c3c5c5;
                 border-color: #00838F;
            }

            #memo{
                color: black;
               background-color: #c3c5c5;
                 border-color: #00838F;
            }

            #day{
                background-color: #46529E;
                border-bottom-color: #ffffff;
            }

            #time{
                background-color: #1C80CF;
            }

            #weather{
                background-color: #4D59A1;
                border-top-color: #ffffff;
            }

            #div3{
                background-color : #2196F3;
            }
            #container {
                background-image: "./img/bgimg.png";
            }
        </style>  
	</head>
<body>

    <form id="id_form_sch" method="POST" target="ifr_schedule" action="schedule.php">
     <?php  $idx = $_POST["id"]; echo "<input type=\"hidden\" name=\"id\" value=\"".$idx."\"></input>"; ?>
    </form> 
    <form id="id_form_mem" method="POST" target="ifr_memo" action="memo.php">
     <?php  $idx = $_POST["id"]; echo "<input type=\"hidden\" name=\"id\" value=\"".$idx."\"></input>"; ?>
    </form>
     <form id="id_form_pro" method="POST" target="ifr_pro" action="profile.php">
     <?php  $idx = $_POST["id"]; echo "<input type=\"hidden\" name=\"id\" value=\"".$idx."\"></input>"; ?>
    </form>   
    <form id="id_form_wea" method="POST" target="ifr_wea" action="weather.php">
     <?php  $idx = $_POST["id"]; echo "<input type=\"hidden\" name=\"id\" value=\"".$idx."\"></input>"; ?>
    </form>   

   <div id="container" style="float: left; width: 710px; height: 400px; margin-top: 8px;margin-left: 8px;">

        <div style="float: left; width: 28%; height: 380px; margin-right: 0px;">
       
             <div id="schedule" style=" float: left; width: 200px; height: 380px; margin-left: 0px;">
               <iframe name="ifr_schedule" width="200px" height="190px" style="border:none;">날짜 </iframe>
                   <script type="text/javascript">
                        document.getElementById('id_form_sch').submit();
                   </script>
             </div>

        </div>



        <div style="float: left; width: 294.641px; height:380px; padding-right: 0px;">
        
            <div id="memo" style="float: left; width: 100%; height: 380px; margin-bottom: 16px;">
                <iframe name="ifr_memo" src="memo.php" width="294.641px" height="380px" style="border:none;"></iframe>
                <script type="text/javascript">
                        document.getElementById('id_form_mem').submit();
                </script>
             </div>
        </div>



        <div id="div3" style="float: left; width: 190px; height: 380px; ">
        
            <div id="day" style="float: left; width: 190px; height: 70px; margin-bottom: 0px;">
                <iframe name="ifr_pro" src="profile.php" width="190px" height="70px" style="border:none;">프로필 </iframe>
                 <script type="text/javascript">
                        document.getElementById('id_form_pro').submit();
              </script>  
             </div>
             <div id="time" style="float: left; width: 190px; height: 180px; margin-bottom: 0px;">
               <iframe name="test" src="main_time.html" width="190px" height="180px" style="border:none;">날짜 </iframe>
             </div>
             <div id="weather" style="float: left;width: 190px; height: 130px;">
              <iframe name="ifr_wea" width="190px" height="130px" style="border:none;"> </iframe>
              <script type="text/javascript">
                        document.getElementById('id_form_wea').submit();

              </script>    
             </div>
        </div>
    </div>
     
  
</body>
</html>

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

      <script src="js/jquery-2.1.3.min.js"></script>
      <script src="js/metro.js"></script>
      <script src="js/docs.js"></script>
      <script src="js/prettify/run_prettify.js"></script>
      <script src="js/ga.js"></script>

        <script language="JavaScript">
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

       //document.getElementById('id').submit();
        //-->
        </script>
        <style type="text/css">
            body
            {
                background: center; 
                background-color: #4D59A1;
                overflow:hidden;
                font-family:'Nanum Gothic';
            }

        
        </style>  
  </head>
<body style="margin-top: 0px; margin-bottom: 0px; margin-right: 0px; margin-left: 0px; width: 190px; height: 122px;">
<?php

class weather_parameter
{
	var $message_code;
	var $station_name;
	var $sky_code;
	var $rain_sinceOntime;
	var $temperature_tc;
	var $temperature_tmax;
	var $temperature_tmin;
  var $weather_img_path;
}

function get_img_path($sky_code)
{
  switch($sky_code)
  {
    case "SKY_A01":
      $path = "./img/1.png";
      break;
      
    case "SKY_A02":
      $path = "./img/2.png";
      break;

    case "SKY_A03":
    case "SKY_A04":
    case "SKY_A05":
    case "SKY_A06":
      $path = "./img/3.png";
      break;

    case "SKY_A07":
    case "SKY_A08":
    case "SKY_A09":
    case "SKY_A10":
    case "SKY_A11":
      $path = "./img/7.png";
      break;

    case "SKY_A12":
    case "SKY_A14":
      $path = "./img/12.png";
      break;

    case "SKY_A13":
      $path = "./img/13.png";
      break;

    default:
      $path = "./img/1.png";
  }

  return $path;
}

function get_weather($stdid)
{
  $ch = curl_init();

  curl_setopt($ch, CURLOPT_URL, "http://apis.skplanetx.com/weather/current/minutely?&Content-Length=320&Content-Type=utf-8&Accept=application/json&Accept-Language=ko&host=www.skplanetx.com&appKey=49712187-23b7-3bc4-a200-8b30d4daf837&version=1&stnid=".$stdid);
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
  curl_setopt($ch, CURLOPT_HEADER, FALSE);

  $response = curl_exec($ch);
  curl_close($ch);

  return json_decode($response);
}

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
  echo "등록된 날씨 정보가 없습니다.";
}
else if($total_record == 1)
{
  $weather_result = get_weather($row['ulid']);

  $wp = new weather_parameter;

  $wp->message_code = $weather_result->result->code;
  $wp->station_name = $weather_result->weather->minutely[0]->station->name;
  $wp->sky_code = $weather_result->weather->minutely[0]->sky->code;
  $wp->weather_img_path = get_img_path($wp->sky_code);
  $wp->rain_sinceOntime = $weather_result->weather->minutely[0]->rain->sinceOntime;
  $wp->temperature_tc = $weather_result->weather->minutely[0]->temperature->tc;
  $wp->temperature_tmax = $weather_result->weather->minutely[0]->temperature->tmax;
  $wp->temperature_tmin = $weather_result->weather->minutely[0]->temperature->tmin;

    echo "<p align = \"center\" style=\"margin-top: 0px; margin-bottom: 0px; margin-left: 95px; margin-top: 15px; font-family:'Nanum Gothic'; color: #ffffff;\">".$wp->station_name."</p>";
    echo  "<div style=\"float: left; width: 50%; height: 80px; margin-right: 0px;\">";
    echo "<img src=\"".$wp->weather_img_path."\" width=\"72\" style=\"margin-left: 5px;\"/>";
    echo "</div>";
    echo  "<div style=\"float: left; width: 50%; height: 80x; margin-right: 0px;\">";
    echo "<p align = \"center\" style=\"width: 87px; height:50px; margin-top: 0px; margin-bottom: 0px; margin-left: 5px; font-size: 40px; font-family:'Nanum Gothic'; color: #ffffff;\">".(int)$wp->temperature_tc."℃</p>";
    echo "<p align = \"center\" style=\"width: 87px; height:30px; margin-top: 0px; margin-bottom: 0px; margin-left: 5px; font-size: 16px; font-family:'Nanum Gothic'; color: #ffffff;\">".(int)$wp->temperature_tmax."℃ / ".(int)$wp->temperature_tmin."℃</p>";
    echo "</div>";
}
else
{

  //echo "<div id=\"carousel\" class=\"carousel\" data-role=\"carousel\" data-direction=\"vertical\" data-delay=\"2500\" data-repeteat='0'>";
  echo "<div id=\"carousel\" class=\"carousel\" data-role=\"carousel\" data-controls=\"false\" style=\"width: 190px; height: 130px;\">";
  for($i=0;$i<$total_record;$i++)
  {
     mysqli_data_seek($result,$i);
     $row = mysqli_fetch_array($result);

     $weather_result = get_weather($row['ulid']);
     $wp[$i] = new weather_parameter;
     $wp[$i]->message_code = $weather_result->result->code;
     $wp[$i]->station_name = $weather_result->weather->minutely[0]->station->name;
     $wp[$i]->sky_code = $weather_result->weather->minutely[0]->sky->code;
     $wp[$i]->weather_img_path = get_img_path($wp[$i]->sky_code);
     $wp[$i]->rain_sinceOntime = $weather_result->weather->minutely[0]->rain->sinceOntime;
     $wp[$i]->temperature_tc   = $weather_result->weather->minutely[0]->temperature->tc;
     $wp[$i]->temperature_tmax = $weather_result->weather->minutely[0]->temperature->tmax;
     $wp[$i]->temperature_tmin = $weather_result->weather->minutely[0]->temperature->tmin;

     echo "<div class=\"slide\" style=\"margin-left: 3px;\">";
     echo  "<div style=\"float: left; width: 40%; height: 80px; margin-top: 21px;\">";
     echo "<img src=\"".$wp[$i]->weather_img_path."\" width=\"72\" style=\"margin-left: 10px;\"/>";
     echo "</div>";
     echo  "<div style=\"float: left; width: 50%; height: 80x; margin-left: 8px;\">";
     echo "<p align = \"center\" style=\"margin-top: 0px; margin-bottom: 0px; margin-left: 0px; margin-top: 15px; font-family:'Nanum Gothic'; font-size: 16px;  color: #ffffff;\">".$wp[$i]->station_name."</p>";
     echo "<p align = \"center\" style=\"width: 87px; height:50px; margin-top: 0px; margin-bottom: 0px; margin-left: 5px; font-size: 40px; font-family:'Nanum Gothic'; color: #ffffff;\">".(int)$wp[$i]->temperature_tc."℃</p>";
     echo "<p align = \"center\" style=\"width: 87px; height:30px; margin-top: 0px; margin-bottom: 0px; margin-left: 5px; font-size: 16px; font-family:'Nanum Gothic'; color: #ffffff;\">".(int)$wp[$i]->temperature_tmax."℃ / ".(int)$wp[$i]->temperature_tmin."℃</p>";
     echo "</div>";
     echo "</div>";
       //echo "</div>";
  }
  echo "</div>";
}

?>
   <script>
      $('.carousel').carousel();
   </script>
                  

</body>
</html>
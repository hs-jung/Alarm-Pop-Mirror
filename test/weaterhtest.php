<?php

class weather_parameter
{
	var $message_code;
	var $station_name;
	var $sky_code;
	var $rain_sinceOntime;
	var $temperature_tc;
	var $temperatuer_tmax;
	var $temperatuer_tmin;
}
/*
  $ch = curl_init();

  curl_setopt($ch, CURLOPT_URL, "http://apis.skplanetx.com/weather/current/minutely?&Content-Length=320&Content-Type=utf-8&Accept=application/json&Accept-Language=ko&host=www.skplanetx.com&appKey=49712187-23b7-3bc4-a200-8b30d4daf837&version=1&stnid=108");
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
  curl_setopt($ch, CURLOPT_HEADER, FALSE);
  curl_setopt($ch, CURLOPT_GET, TRUE);

  $response = curl_exec($ch);
  curl_close($ch);

  echo $response;
*/

  $weather_result = json_decode("{\"result\":{\"message\":\"성공\",\"code\":9200,\"requestUrl\":\"/weather/current/minutely?=&Accept-Language=ko&host=www.skplanetx.com&Content-Length=320&stnid=108&Accept=application/json&Content-Type=utf-8&version=1&appKey=49712187-23b7-3bc4-a200-8b30d4daf837\"},\"common\":{\"alertYn\":\"Y\",\"stormYn\":\"Y\"},\"weather\":{\"minutely\":[{\"station\":{\"name\":\"서울\",\"id\":\"108\",\"type\":\"KMA\",\"latitude\":\"37.5714100000\",\"longitude\":\"126.9657900000\"},\"wind\":{\"wdir\":\"100.70\",\"wspd\":\"1.90\"},\"precipitation\":{\"type\":\"0\",\"sinceOntime\":\"0.00\"},\"sky\":{\"name\":\"맑음\",\"code\":\"SKY_A01\"},\"rain\":{\"sinceOntime\":\"0.00\",\"sinceMidnight\":\"0.00\",\"last10min\":\"0.00\",\"last15min\":\"0.00\",\"last30min\":\"0.00\",\"last1hour\":\"0.00\",\"last6hour\":\"0.00\",\"last12hour\":\"0.00\",\"last24hour\":\"0.00\"},\"temperature\":{\"tc\":\"26.70\",\"tmax\":\"27.00\",\"tmin\":\"16.00\"},\"humidity\":\"27.60\",\"pressure\":{\"surface\":\"1005.70\",\"seaLevel\":\"1015.40\"},\"lightning\":\"0\",\"timeObservation\":\"2016-09-20 15:26:00\"}]}}");

  //echo $weather_result->result->code;

  $wp = new weather_parameter;

  $wp->message_code = $weather_result->result->code;
  $wp->station_name = $weather_result->weather->minutely[0]->station->name;
  $wp->sky_code = $weather_result->weather->minutely[0]->sky->code;
  $wp->rain_sinceOntime = $weather_result->weather->minutely[0]->rain->sinceOntime;
  $wp->temperature_tc = $weather_result->weather->minutely[0]->temperature->tc;
  $wp->temperatuer_tmax = $weather_result->weather->minutely[0]->temperature->tmax;
  $wp->temperatuer_tmin = $weather_result->weather->minutely[0]->temperature->tmin;

  //echo "<br></br>";
  echo $wp->message_code;
  echo $wp->station_name;
  echo $wp->sky_code;
  echo $wp->rain_sinceOntime;
  echo $wp->temperature_tc;
  echo $wp->temperatuer_tmax;
  echo $wp->temperatuer_tmin;
?>
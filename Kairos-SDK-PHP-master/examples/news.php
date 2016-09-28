<?php

include_once 'db_conn.php';

  //$id =$_POST['id'];
  $query_str = '축구';
  date_default_timezone_set('Asia/Seoul');

  //$path = urlencode("GET v1/search/news.xml?query=".$query_str."&display=10&start=1&sort=sim HTTP/1.1");
  echo "GET v1/search/news.xml?query=".urlencode($query_str)."&display=10&start=1&sort=sim HTTP/1.1";
  $ch = curl_init();
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
  curl_setopt($ch, CURLOPT_HEADER, FALSE);
  curl_setopt($ch, CURLOPT_HTTPHEADER, array(
    "GET v1/search/news.xml?query=".urlencode($query_str)."&display=10&start=1&sort=sim HTTP/1.1",
    "Host: openapi.naver.com",
    "User-Agent: curl/7.43.0",
    "Accept: */*",
    "Content-Type: application/xml",
    "X-Naver-Client-Id: Odfwk21RfR6rEPLvCQXw",
    "X-Naver-Client-Secret: yczMws1nHc"
  ));
  $response = curl_exec($ch);
  var_dump($response);

  //header($path.";Host: openapi.naver.com;User-Agent: curl/7.43.0;Accept: */*;Content-Type: application/xml;X-Naver-Client-Id: Odfwk21RfR6rEPLvCQXw;X-Naver-Client-Secret: yczMws1nHc");
  //$xml=simplexml_load_string(header($path.";Host: openapi.naver.com;User-Agent: curl/7.43.0;Accept: */*;Content-Type: application/xml;X-Naver-Client-Id: Odfwk21RfR6rEPLvCQXw;X-Naver-Client-Secret: yczMws1nHc"));
  //print_r($xml);


/*
  $ch = curl_init();

  curl_setopt($ch, CURLOPT_URL, "https://openapi.naver.com/v1/search/news.xml");
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
  curl_setopt($ch, CURLOPT_HEADER, FALSE);
  curl_setopt($ch, CURLOPT_HTTPHEADER, array(
    "Host: openapi.naver.com",
    "User-Agent: curl/7.43.0",
    "Accept: **",
    "Content-Type: application/xml",
    "X-Naver-Client-Id: Odfwk21RfR6rEPLvCQXw",
    "X-Naver-Client-Secret: yczMws1nHc"
  ));

  $response = curl_exec($ch);
  var_dump($response);

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
  echo "<font size=\"5px\" color='#222644'>No schedule</font>";
 
}
else if($total_record == 1)
{
  echo "<font size=\"5px\" color='#222644'> $row[subject] <br> ".substr("$row[ymdt]",11,5)."</font>";
}
else
{
  $j=0;

  for($i=0;$i<$total_record;$i++)
  {
     mysqli_data_seek($result,$i);
     $row = mysqli_fetch_array($result);
     echo "<font size=\"5px\" color='#222644'> $row[subject] <br> ".substr("$row[ymdt]",11,5)."</font>";
     
     if(mysqli_data_seek($result,++$j))
     {
      echo "<br><br>";
     }
     else
     {
      echo "";
     }

  }
  
}
*/
?>
<html>
<head>
</head>
<body style="margin-top:0px; margin-bottom: 0px;">
<?php

$ch = curl_init();
curl_setopt($ch, CURLOPT_URL,"https://openapi.naver.com/v1/search/shop.xml?query=의류&display=10&start=1&sort=sim");
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS,true);  //Post Fields
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

$headers = [
    "User-Agent: curl/7.43.0",
    "Accept: */*",
    "Content-Type: application/xml",
    "X-Naver-Client-Id: Odfwk21RfR6rEPLvCQXw", // 사용자가 발급받은 오픈API 키 
    "X-Naver-Client-Secret: yczMws1nHc",
];
//curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

$server_output = curl_exec($ch);
  
 //$data =file_get_contents($ch);
  //curl_close($ch);
 // $xml = simplexml_load_string($data);

  echo $server_output;
         

  //var_dump($response);

?>
</body>
</html>    
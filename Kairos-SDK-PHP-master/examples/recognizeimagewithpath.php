<?php
	//$path = $_POST["path"];
	$path = "http://cslab2.kku.ac.kr/~200917307/Kairos-SDK-PHP-master/examples/assets/images/test3.jpg";
	$ch = curl_init();

	curl_setopt($ch, CURLOPT_URL, "https://api.kairos.com/recognize");
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
	curl_setopt($ch, CURLOPT_HEADER, FALSE);

	curl_setopt($ch, CURLOPT_POST, TRUE);

	curl_setopt($ch, CURLOPT_POSTFIELDS, "{
	  \"image\": \"".$path."\",
	  \"gallery_name\": \"apm\"
	}");

	curl_setopt($ch, CURLOPT_HTTPHEADER, array(
	  "Content-Type: application/json",
	  "app_id: d4ba9c0f",
	  "app_key: de1162ff744a3a79fddf7b5ecca7a158"
	));

	$response = curl_exec($ch);
	curl_close($ch);

	$json = json_decode($response);
	//echo $response;

	if( $json->images[0]->transaction->status == "success" )
	{
		$id =  $json->images[0]->transaction->subject;
		//echo "<script> document.location.href='http://cslab2.kku.ac.kr/~200917307/mirror/main.html'; </script>"; 
		echo "<form name=\"id_form\" method=\"post\" action=\"http://cslab2.kku.ac.kr/~200917307/mirror/main.php\">";
		echo "<input type=\"hidden\" name=\"id\" value=\"".$id."\">";
		echo "</form>";
		echo "<script> document.id_form.submit() </script>";
	}
	else
	{
		echo "<script> document.location.href='http://cslab2.kku.ac.kr/~200917307/mirror/time.html'; </script>"; 
	}
?>
<?php
	//$path = $_POST["path"];
	$path = "http://cslab2.kku.ac.kr/~200917307/login_face/cam.jpg";
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
	  "app_id: a1690fc3",
	  "app_key: 3be8a64f3267f268b5bd5a68111c0e2b"
	));

	$response = curl_exec($ch);
	curl_close($ch);

	$json = json_decode($response);
	//echo $response;

	if( $json->images[0]->transaction->status == "success" )
	{
		$id =  $json->images[0]->transaction->subject;
		//echo "<script> document.location.href='http://cslab2.kku.ac.kr/~200917307/mirror/main.html'; </script>"; 
		echo "<form name=\"id_form\" method=\"post\" action=\"http://localhost/mirror/main.php\">";
		echo "<input type=\"hidden\" name=\"id\" value=\"".$id."\">";
		echo "</form>";
		echo "<script> document.id_form.submit() </script>";
	}
	else
	{
		echo "<script> document.location.href='http://localhost/mirror/time.php'; </script>"; 
	}
?>
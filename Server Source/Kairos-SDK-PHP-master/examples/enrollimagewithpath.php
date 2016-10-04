<html>
<head>
<link rel="stylesheet" href="css/bootstrap.min.css" />
</head>
<body>
<h2>Enrolling an Image Using a File Path</h2>
<i>This example enrolls the following image</i><br />
<img src="assets/images/2.jpg" />
<?php

//* * * * include the wrapper class
include('../Kairos.php');
include('assets/helper.php');

$id = $_POST['id'];
$target_dir = '/home/students/200917307/public_html/enroll_face/';
  $target_file1 = $target_dir.$id."_" . basename($_FILES["img1"]["name"]);
  $target_file2 = $target_dir.$id."_" . basename($_FILES["img2"]["name"]);
  $target_file3 = $target_dir.$id."_" . basename($_FILES["img3"]["name"]);

//* * * * sample api credentials (works for example)
$app_id  = 'a1690fc3';
$api_key = '3be8a64f3267f268b5bd5a68111c0e2b';

//* * * * create a new instance and authenticate
$Kairos  = new Kairos($app_id, $api_key);

/*
 In this example, we enroll a
 subject into a gallery using a
 path to an image file. */
$gallery_id = 'apm';
$subject_id = $id;
$image_path1 = $target_file1;
$image_path2 = $target_file2;
$image_path3 = $target_file3;
 // 2.업로드된 파일의 존재여부 및 전송상태 확인
  if ( (isset($_FILES['img1']) && !$_FILES['img1']['error']) && (isset($_FILES['img2']) && !$_FILES['img2']['error']) &&  (isset($_FILES['img3']) && !$_FILES['img3']['error'])) 
  {

    //echo "File Type is : ".$_FILES['img1']['type'];

    // 3-1.허용할 이미지 종류를 배열로 저장
    $imageKind = array ('image/pjpeg', 'image/jpeg', 'image/JPG', 'image/X-PNG', 'image/PNG', 'image/png', 'image/x-png');

    // 3-2.imageKind 배열내에 $_FILES['upload']['type']에 해당되는 타입(문자열) 있는지 체크
    if ( in_array($_FILES['img1']['type'], $imageKind) &&  in_array($_FILES['img2']['type'], $imageKind) &&  in_array($_FILES['img3']['type'], $imageKind) ) 
    {
    
      // 4.허용하는 이미지파일이라면 지정된 위치로 이동
      //if (move_uploaded_file ($_FILES['upload']['tmp_name'], "./image/{$_FILES['upload']['name']}")) {

      //$_FILES['img']['name'] = 'profile_image_'.$id.'.png';

        if ( move_uploaded_file($_FILES["img1"]["tmp_name"], $target_file1) && move_uploaded_file($_FILES["img2"]["tmp_name"], $target_file2)  && move_uploaded_file($_FILES["img3"]["tmp_name"], $target_file3))
        {


			$response1 = $Kairos->enrollImageWithPath($image_path1, $gallery_id, $subject_id);
			$response2 = $Kairos->enrollImageWithPath($image_path2, $gallery_id, $subject_id);
			$response3 = $Kairos->enrollImageWithPath($image_path3, $gallery_id, $subject_id);
		}
	}
}

echo '<br /><b>Response:</b><br />';
echo '<div class="text-left" style="padding:10px;border:1px solid rgba(51, 51, 51, 0.08);background-color: rgba(204, 204, 204, 0.26);"><br />';
echo format_json($response1, true);
echo '</div>';

?>
</body>
</html>
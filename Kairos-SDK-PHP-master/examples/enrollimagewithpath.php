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
$img1 = $_FILES['image']['image1'];
$img2 = $_FILES['image']['image2'];
$img3 = $_FILES['image']['image3'];

//* * * * sample api credentials (works for example)
$app_id  = 'd4ba9c0f';
$api_key = 'de1162ff744a3a79fddf7b5ecca7a158';

//* * * * create a new instance and authenticate
$Kairos  = new Kairos($app_id, $api_key);

/*
 In this example, we enroll a
 subject into a gallery using a
 path to an image file. */
$gallery_id = 'apm';
$subject_id = $id;
$image_path1 = "assets/images/".$id."-1.jpg";
$image_path2 = "assets/images/".$id."-2.jpg";
$image_path3 = "assets/images/".$id."-3.jpg";

$response = $Kairos->enrollImageWithPath($image_path, $gallery_id, $subject_id);

echo '<br /><b>Response:</b><br />';
echo '<div class="text-left" style="padding:10px;border:1px solid rgba(51, 51, 51, 0.08);background-color: rgba(204, 204, 204, 0.26);"><br />';
echo format_json($response, true);
echo '</div>';

?>
</body>
</html>
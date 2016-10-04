<html>
<head>
<link rel="stylesheet" href="assets/css/bootstrap.min.css" />
</head>
<body>
<h2>List Subjects for Galleries</h2>
<i>This example returns a list of subjects currently enrolled in a given gallery</i><br />
<?php

//* * * * include the wrapper class
include('../Kairos.php');
include('assets/helper.php');

//* * * * sample api credentials (works for example)
$app_id  = 'a1690fc3';
$api_key = '3be8a64f3267f268b5bd5a68111c0e2b';

//* * * * create a new instance and authenticate
$Kairos  = new Kairos($app_id, $api_key);

/*
 In this example, we request a list of all galleries */
$gallery_id = "apm";
$response = $Kairos->listSubjectsForGallery($gallery_id);

echo '<br /><b>Response:</b><br />';
echo '<div class="text-left" style="padding:10px;border:1px solid rgba(51, 51, 51, 0.08);background-color: rgba(204, 204, 204, 0.26);"><br />';
echo format_json($response, true);
echo '</div>';

?>
</body>
</html>
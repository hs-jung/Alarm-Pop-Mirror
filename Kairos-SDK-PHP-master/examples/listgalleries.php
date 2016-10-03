<html>
<head>
<link rel="stylesheet" href="assets/css/bootstrap.min.css" />
</head>
<body>
<h2>List Galleries</h2>
<i>This example returns a list of galleries you created</i><br />
<?php

//* * * * include the wrapper class
include('../Kairos.php');
include('assets/helper.php');

//* * * * sample api credentials (works for example)
$app_id  = 'd4ba9c0f';
$api_key = 'de1162ff744a3a79fddf7b5ecca7a158';

//* * * * create a new instance and authenticate
$Kairos  = new Kairos($app_id, $api_key);

/*
 In this example, we request a list of all galleries */
$response = $Kairos->listGalleries();

echo '<br /><b>Response:</b><br />';
echo '<div class="text-left" style="padding:10px;border:1px solid rgba(51, 51, 51, 0.08);background-color: rgba(204, 204, 204, 0.26);"><br />';
echo format_json($response, true);
echo '</div>';

?>
</body>
</html>
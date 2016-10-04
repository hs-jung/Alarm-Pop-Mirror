<?php

  $target_dir = '/home/students/200917307/public_html/login_face/';
  $target_file1 = $target_dir.$id."_" . basename($_FILES["img1"]["name"]);

  // 2.업로드된 파일의 존재여부 및 전송상태 확인
  if ( (isset($_FILES['img1']) && !$_FILES['img1']['error']) 
  {

    //echo "File Type is : ".$_FILES['img1']['type'];

    // 3-1.허용할 이미지 종류를 배열로 저장
    $imageKind = array ('image/pjpeg', 'image/jpeg', 'image/JPG', 'image/X-PNG', 'image/PNG', 'image/png', 'image/x-png');

    // 3-2.imageKind 배열내에 $_FILES['upload']['type']에 해당되는 타입(문자열) 있는지 체크
    if ( in_array($_FILES['img1']['type'], $imageKind)) 
    {
    
      // 4.허용하는 이미지파일이라면 지정된 위치로 이동
      //if (move_uploaded_file ($_FILES['upload']['tmp_name'], "./image/{$_FILES['upload']['name']}")) {

      //$_FILES['img']['name'] = 'profile_image_'.$id.'.png';

        if ( move_uploaded_file($_FILES["img1"]["tmp_name"], $target_file1) )
        {

        }
            
  
  // 7.임시파일이 존재하는 경우 삭제
  if (file_exists ($_FILES['img1']['tmp_name']) && is_file($_FILES['img1']['tmp_name']) ) {
    unlink ($_FILES['img1']['tmp_name']);
  }
  
  
?>
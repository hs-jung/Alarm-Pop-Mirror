<?php
  
  include_once 'db_conn.php';
  include_once('./Kairos-SDK-PHP-master/Kairos.php');
  include_once('./Kairos-SDK-PHP-master/examples/assets/helper.php');

  $id = $_POST['id'];
  $nickname = $_POST['nickname'];
  $pw = $_POST['pw'];
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
          //echo "1";
         $response1 = $Kairos->detectImageWithPath($image_path1);
         $response2 = $Kairos->detectImageWithPath($image_path2);
         $response3 = $Kairos->detectImageWithPath($image_path3);
         
         $ercode1 =  json_decode($response1);
         $ercode2 =  json_decode($response2);
         $ercode3 =  json_decode($response3);
         
         try
         {
           if( ($ercode1->images[0]->status == "Complete") && ($ercode2->images[0]->status == "Complete") && ($ercode3->images[0]->status == "Complete"))
           {
            $response1 = $Kairos->enrollImageWithPath($image_path1, $gallery_id, $subject_id);
            $response2 = $Kairos->enrollImageWithPath($image_path2, $gallery_id, $subject_id);
            $response3 = $Kairos->enrollImageWithPath($image_path3, $gallery_id, $subject_id);

            $ercode1 =  json_decode($response1);
            $ercode2 =  json_decode($response2);
            $ercode3 =  json_decode($response3);

            if( ($ercode1->images[0]->transaction->status == "success") && ($ercode2->images[0]->transaction->status == "success") && ($ercode3->images[0]->transaction->status == "success") )
            {
              if(mysqli_connect_errno())
              {
                echo "Fail to connet to mysql : ", mysqli_connect_errno();
              }

              mysqli_query($conn, "set session character_set_connection=UTF-8;");

              $sql1 = "insert into user (uuid, pw, uname, uface) value ( '".$id."',PASSWORD('".$pw."'), '".$nickname."', 'success');";
              $result1 = mysqli_query($conn, $sql1) or die("{\"Success\":\"-1\"}");   

              $sql2 = "insert into memo (uuid, subject, content) value ( '".$id."','', 'Insert Memo');";
              $result2 = mysqli_query($conn, $sql2) or die("{\"Success\":\"-2\"}"); 

              $sql3 = "insert into checkupdate (uuid,scheck,mcheck,wcheck,ncheck) value ( '".$id."',1,1,1,1);";
              $result3 = mysqli_query($conn, $sql3) or die("{\"Success\":\"-3\"}"); 
              
              echo "{\"Success\":\"1\"}";
            }
            
           }
       }
      catch(Exception $e)
       {
         echo "{\"Success\":\"3\"}";
       }
         
        
      } //if , move_uploaded_file

    }
    else 
    { // 3-3.허용된 이미지 타입이 아닌경우
      echo "{\"Success\":\"-2\"}"; //'<p>JPEG 또는 PNG 이미지만 업로드 가능합니다.</p>';
    }//if , inarray

}  

  // 6.에러가 존재하는지 체크
  if ($_FILES['img1']['error'] > 0) {
    echo '<p>파일 업로드 실패 이유: <strong>';
  
    // 실패 내용을 출력
    switch ($_FILES['img1']['error']) {
      case 1:
        echo 'php.ini 파일의 upload_max_filesize 설정값을 초과함(업로드 최대용량 초과)';
        break;
      case 2:
        echo 'Form에서 설정된 MAX_FILE_SIZE 설정값을 초과함(업로드 최대용량 초과)';
        break;
      case 3:
        echo '파일 일부만 업로드 됨';
        break;
      case 4:
        echo '업로드된 파일이 없음';
        break;
      case 6:
        echo '사용가능한 임시폴더가 없음';
        break;
      case 7:
        echo '디스크에 저장할수 없음';
        break;
      case 8:
        echo '파일 업로드가 중지됨';
        break;
      default:
        echo '시스템 오류가 발생';
        break;
    } // switch
    
    echo '</strong></p>';
    
  } // if
  // 6.에러가 존재하는지 체크
  if ($_FILES['img2']['error'] > 0) {
    echo '<p>파일 업로드 실패 이유: <strong>';
  
    // 실패 내용을 출력
    switch ($_FILES['img2']['error']) {
      case 1:
        echo 'php.ini 파일의 upload_max_filesize 설정값을 초과함(업로드 최대용량 초과)';
        break;
      case 2:
        echo 'Form에서 설정된 MAX_FILE_SIZE 설정값을 초과함(업로드 최대용량 초과)';
        break;
      case 3:
        echo '파일 일부만 업로드 됨';
        break;
      case 4:
        echo '업로드된 파일이 없음';
        break;
      case 6:
        echo '사용가능한 임시폴더가 없음';
        break;
      case 7:
        echo '디스크에 저장할수 없음';
        break;
      case 8:
        echo '파일 업로드가 중지됨';
        break;
      default:
        echo '시스템 오류가 발생';
        break;
    } // switch
    
    echo '</strong></p>';
    
  } // if
  // 6.에러가 존재하는지 체크
  if ($_FILES['img3']['error'] > 0) {
    echo '<p>파일 업로드 실패 이유: <strong>';
  
    // 실패 내용을 출력
    switch ($_FILES['img3']['error']) {
      case 1:
        echo 'php.ini 파일의 upload_max_filesize 설정값을 초과함(업로드 최대용량 초과)';
        break;
      case 2:
        echo 'Form에서 설정된 MAX_FILE_SIZE 설정값을 초과함(업로드 최대용량 초과)';
        break;
      case 3:
        echo '파일 일부만 업로드 됨';
        break;
      case 4:
        echo '업로드된 파일이 없음';
        break;
      case 6:
        echo '사용가능한 임시폴더가 없음';
        break;
      case 7:
        echo '디스크에 저장할수 없음';
        break;
      case 8:
        echo '파일 업로드가 중지됨';
        break;
      default:
        echo '시스템 오류가 발생';
        break;
    } // switch
    
    echo '</strong></p>';
    
  } // if
  
  // 7.임시파일이 존재하는 경우 삭제
  if (file_exists ($_FILES['img1']['tmp_name']) && is_file($_FILES['img1']['tmp_name']) ) {
    unlink ($_FILES['img1']['tmp_name']);
  }
  if (file_exists ($_FILES['img2']['tmp_name']) && is_file($_FILES['img2']['tmp_name']) ) {
    unlink ($_FILES['img1']['tmp_name']);
  }
  if (file_exists ($_FILES['img3']['tmp_name']) && is_file($_FILES['img3']['tmp_name']) ) {
    unlink ($_FILES['img1']['tmp_name']);
  }

?>
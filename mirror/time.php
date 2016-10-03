<html>
<head>
    <script src="http://code.jquery.com/jquery-latest.js"></script>
	<script>

	    window.onload = function() { var interval=
	      setInterval(function() {
	        
	        var time = new Date();
	        var datestr;
	        var timestr;
	        var h = time.getHours();
	        var m = time.getMinutes();
	        var s = time.getSeconds();
	     
	        timestr = "";

	        if( h < 10)
	        	timestr = '0'+ h + ':';
	        else
	        	timestr = h + ':';

	        if( m < 10)
	        	timestr += '0' + m + ":";
	        else
	        	timestr += m + ':';

	        if( s < 10)
	        	timestr += '0' + s;
	        else
	        	timestr += s;

	        var months = [ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ];

	        var monthstr = months[time.getMonth()];
	        //datestr = time.getDate() +" "+  monthstr;
	        datestr = time.getDate() +" "+  monthstr;

	        document.getElementById("date").innerHTML = datestr;
	        document.getElementById("time").innerHTML = timestr;

	        if( s%5 == 0 || s%5 == 5)
	        {
	        	$.ajax({
                    url:'http://cslab2.kku.ac.kr/~200917307/mirror/read_flag.php',
                    dataType:'json',
                    type:'POST',
                    success:function(result){
                        if(result['flag']==0){
                         //window.alert("0");
                         //document.getElementById("date").innerHTML = datestr;
	        			//document.getElementById("time").innerHTML = timestr;
                        }
                        else{
                        	//window.alert("1");
                        	$('#time').html('');
                        	$('#date').html(result['flag']);

                        }
                    }
                });
	        }

	      }, 1000);

	    }
	</script>

	<style type="text/css">

		 
		@import url('http://fonts.googleapis.com/earlyaccess/nanumgothic.css');
        body, table, div, p {font-family:'Nanum Gothic';}

        #box3 { 
        	width:100px; text-align:center; vertical-align:middle;
        }

        #time {
          	font-size:150px;
          	color: white;
          	font-weight: bold;
          
        }

        #date {
          	font-size:50px;
          	color: white;
          	
        }

        body {
            background: center; 
            background-color: #0d0d0d;
            overflow-y:hidden;
        }
    
    </style>
 </head>
 <body>
 	
    <div id="result" style="float: left; width: 100%; height: 60%; padding-top: 20px; ">
    	<p id="time" align="center" style="margin-top: 40px; margin-bottom: 0px;"></p>
    	<p id="date" align="center" style=" margin-top: 0px; margin-bottom: 0px;"></p>
    </div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<input type = "text" name = "text" id = "text">
	<input type = "button" value = "변환" name = "btn" id = "btn">
</body>

<script src = "http://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
	$(document).ready(function(){
		$('#text').focus();
		$('#btn').click(function(){
			var strCode = $('#text').val().charCodeAt();
			console.log(typeof(strCode.toString()));
			console.log('유니코드 : ' + strCode);
			var hexStr = strCode.toString(16);
			console.log('유니코드를 16진수로 : ' + hexStr);
			console.log('유니코드 16진수를 문자로 : ' + String.fromCharCode(hexStr.toString()));
			
			var str = String.fromCharCode(strCode.toString());
			console.log(str);
			
			var arr = new Array();
			for(var i = 0; i < $('#text').val().length; i++){
				arr[i] = $('#text').val().substr(i, 1);
			}
			console.log(arr);
			
			var ja = new Array();
			for(var i = 0; i < arr.length; i++){
				//ja[i] = arr[i].charCodeAt().toString(16);
				ja[i] = arr[i].charCodeAt();
			}
			console.log(ja);
			
			for(var i = 0; i < arr.length; i++){
				ja[i] = String.fromCharCode(ja[i].toString());	
			}
			console.log(ja);
			
			$('#text').focus();
		});
		
		$(document).on('keydown', function(key){
			if(key.keyCode == 13){
				$('#btn').trigger('click');	
			}
		});
	});
</script>
</html>
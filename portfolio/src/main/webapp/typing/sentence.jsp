<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
div#seqspan{
	background-image:url("/resources/img/quiz.gif");
	--background-image:url("/board/image/moni01_1.gif"),url("/taja/image/moni01_bg.gif"),url("/taja/image/moni01_2.gif");
	background-repeat:no-repeat;
	background-size:945,100;
	--background-position:left,center,right;
	height: 101px;
	width:  945px;
	line-height:95px;
	margin:0 auto;
	color:#FFFFFF;
	font-size: 14pt;
	text-align:center;
	font-weight:bold;
}

#trainning_panel{
	padding-top : 50px;
	text-align : center;
}

#seinputspan #inputbox {
	width: 95px;
	height:55px;
	line-height:50px;
	padding-left:40px;
	border: 1px dotted #95B647;
	font-size: 14pt;
}
#q_panel{
	padding-top : 50px;
}
	
</style>
<div id="q_panel">
	<!-- 문제 글자 -->
	<div id="seqspan" style="text-align: center;">${q_sentence}</div>
	<!-- 디버그용 출력 글자-->
	<!-- <span id="debug">'<span id="mb_nick">어어그래</span>'님이 등록한 낱말입니다.</span> -->
	<!-- <input type="checkbox" class="form-check-input" id="ismyreg" name="ismyreg" onclick="javascript:myreglist();"> -->
	<!-- <label class="form-check-label" for="ismyreg">내가등록한문장만출제</label> -->
	<!-- <input type="hidden" name="ismyreglist" id="ismyreglist" value="n"> -->
</div>


<div id="trainning_panel" class="roundcorner">
		<div id="seinputspan">
		<input type="text" name="inputbox" id="inputbox" class="notcp" ondrop="drop(event)" ondragover="allowDrop(event)" style="width: 500px;">
	</div>
</div>


<script>
	//마지막 문장을 서버에 보낼때, 평균 속도, 평균정확도 배열을 보내줘야할듯


	$(document).ready(function(){
		$('#inputbox').focus();
		
		//평균속도, 평균정확도 계산 변수 선언필요
		var spd = 0;	//속도 변수
		var timer;		//스탑워치 함수
		var timerIsNotRunning = true;	//타이머 상태체크 변수
		
		var typing = 0;		//타이핑[i] == 문제글[i] 일경우 증가
		var red = 0;	//오답카운트
		
		$(document).on('keydown', '#inputbox', function(key){	//키 입력 이벤트
			var acc;	//정확도 변수
			
			//TypingController에게 시간 정보를 보내주어야함
			
			
			//1. 타이핑 시 스탑워치 작동
			if(timerIsNotRunning){
				timerIsNotRunning = false;
				
				timer = setInterval(function(){
					spd += 0.01;
					console.log(spd.toFixed(2));
				}, 10);//0.01초
			}
			
			var redArr = new Array();	//에러 글자 배열
			
			if (key.keyCode == 13) {
				//2. 타이핑 완료 시 스탑워치 작동중지
				clearInterval(timer);
				var answer = $('#seqspan').text();
				var user_answer = $('#inputbox').val();
				

				console.log(answer.length);
				for(var i = 0; i < answer.length; i++){
					if(answer[i] == user_answer[i]){
						console.log('같음 : ' + answer[i]);	
						typing++;
					}else{
						console.log('다름 : ' + answer[i]);	
						console.log('다름 : ' + user_answer[i]);
						
						var redData = new Object();		//에러 객체 생성
						redData.index = i;
						redData.value = user_answer[i];
						
						//redArr.push(redData);
						redArr[i] = redData;
						
						red++;
					}
				}
				
				$.each(redArr, function(index, items){
					console.log(items);
				});
				
				//JSON 객체 완성
				var redJson = JSON.stringify(redArr);
				
				
				
				$.ajax({
					type : 'POST',
					url : 'answer.do',
					data : {
							'user_answer' : $('#inputbox').val(),
							'answer' : $('#seqspan').text(),
							'spd' : spd.toFixed(2),
							'err' : red,
							'typing' : typing
							},
					dataType : 'JSON',
					success : function(data) {
						console.log('최종 속도 : ' + spd.toFixed(2));
						console.log('최종 타이핑 : ' + typing);
						console.log('최종 오답 : ' + red);
						timerIsNotRunning = true;			//타이머 초기화
						alert(spd.toFixed(2));
						spd = 0;							//속도 초기화
						$('#seqspan').text(data.q_sentence);//새로운 문제 넣기
						redArr = new Array();	//오타 배열 초기화
					}
				}); 
				$('#inputbox').val('');

			}
		});
	});
</script>
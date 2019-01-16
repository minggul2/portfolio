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
		
		var inputLength = 1;	//기준 답 길이
		var inputLengthNow;		//실시간 사용자 답 길이
		
		var red = 0;	//오답카운트
		
		
		
				
		
		$(document).on('keydown', '#inputbox', function(key){	//키 입력 이벤트
			var acc;	//정확도 변수
			
			//TypingController에게 시간 정보를 보내주어야함
			
			inputLengthNow = $(this).val().length;
			console.log('기준 인덱스 : ' + inputLength);
			console.log('답변 인덱스 : ' + inputLengthNow);
			
			if((inputLength - inputLengthNow) != 1){
				if($(this).val().substr(inputLength - 1, 1) == $('#seqspan').text().substr(inputLength - 1, 1)){
					typing++;
					console.log('같음');
				}else{
					red++;	
					console.log('오답');
					console.log($(this).val().substr(inputLength - 1, 1));
					console.log($('#seqspan').text().substr(inputLength - 1, 1));
				}
				inputLength++;
			}
			
			
			
			//1. 타이핑 시 스탑워치 작동
			if(timerIsNotRunning){
				timerIsNotRunning = false;
				
				timer = setInterval(function(){
					spd += 0.1;
					//console.log(spd.toFixed(1));
				}, 100);//밀리세컨드초
			}
			
			
			if (key.keyCode == 13) {
				//2. 타이핑 완료 시 스탑워치 작동중지
				clearInterval(timer);
				
				
				$.ajax({
					type : 'POST',
					url : 'answer.do',
					data : {
							'user_answer' : $('#inputbox').val(),
							'answer' : $('#seqspan').text(),
							'spd' : spd.toFixed(1)
							},
					dataType : 'JSON',
					success : function(data) {
						console.log('최종 속도 : ' + spd.toFixed(1));
						console.log('최종 타이핑 : ' + typing);
						console.log('최종 오답 : ' + red);
						timerIsNotRunning = true;
						spd = 0;
						$('#seqspan').text(data.q_sentence);
					}
				}); 
				$('#inputbox').val('');

			}
		});
	});
</script>
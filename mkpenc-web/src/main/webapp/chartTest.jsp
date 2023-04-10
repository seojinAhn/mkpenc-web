<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>SBChart2.0</title>
	<link rel="stylesheet" href="resources/sbchart/sbchart.css">
	<script type="text/javascript" src="resources/sbchart/sbchart.js"></script>
</head>
<body>
	<div id="chartArea"></div><br/>
	<div>
		<button onclick="chart.data({json: chartData2}).render()">데이터 변경</button>
		<button onclick="chart.data({type: 'line'}).render()">차트 변경</button>
		<button onclick="chart.grid({x:{show:false},y:{show:false}}).render()">격자무늬 제거</button>
		<button onclick="chart.axis({x:{type:'category'}}).render()">X축 타입변경</button>
	</div><br/>
	<div id="chartVersion"></div>

	<script>
		document.addEventListener("DOMContentLoaded", function(){
			createChart();
			document.getElementById('chartVersion').innerHTML = sb.chart.version
		});

		var chart;

		function createChart(){
			var chartConfig = {
				global: {
					svg: {
						classname: 'customClass' // 해당 차트의 svg  태그에 커스텀 클래스 설정
					},
					size: {
						width: 500,
						height: 300
					}
				},
				data: {
					type: 'bar', // 차트의 타입을 설정
					json: chartData, // json 형태로 데이터 설정하며, chartData라는 변수의 데이터를 가져와서 그려줌
					keys: { // json 형태의 데이터를 사용 시, 필수로 keys 속성을 사용해야 함
						x: "name", // 각각의 x축 이름을 chartData의 name값으로 설정
						value: ['2015','2016','2017'] // chartData의 2015, 2016, 2017 데이터를 보여주도록 설정
					}
				},
				extend: {
					bar: {
						topRadius: 15
					}
				}
			};
			chart = new sb.chart("#chartArea", chartConfig) // 첫번째 파라미터는 div 영역의 id, 두번째 파라미터는 위에서 설정한 chart config 객체명 기입
			chart.render(); // render 메소드를 사용해야 차트가 그려짐 (동적으로 사용 시에도 마지막에 꼭 render()를 써줘야 변경한 값들이 반영되어 보여집니다.)
		}

		var chartData = [
			{name: '서울', 2015: 10, 2016: 20, 2017: 30},
			{name: '경기', 2015: 30, 2016: 10, 2017: 20},
			{name: '인천', 2015: 20, 2016: 30, 2017: 10},
		]
		var chartData2 = [
			{name: '서울', 2015: 20, 2016: 30, 2017: 10},
			{name: '경기', 2015: 30, 2016: 10, 2017: 20},
			{name: '인천', 2015: 10, 2016: 20, 2017: 30},
		]
	</script>
</body>
</html>
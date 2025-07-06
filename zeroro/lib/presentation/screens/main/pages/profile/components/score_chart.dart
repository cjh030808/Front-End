import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/theme/constant/app_color.dart';
import 'dart:math' as math;


class ScoreChart extends StatefulWidget {
  const ScoreChart({super.key});

  // 내부 점수 데이터(목업)
  static final List<Map<String, dynamic>> _scoreData = [
    { "date": "2025-06-25", "score": 318 },
    { "date": "2025-06-26", "score": 493 },
    { "date": "2025-06-27", "score": 614 },
    { "date": "2025-06-28", "score": 712 },
    { "date": "2025-06-29", "score": 814 },
    { "date": "2025-06-30", "score": 982 },
    { "date": "2025-07-01", "score": 1044 },
    { "date": "2025-07-02", "score": 1114 },
    { "date": "2025-07-03", "score": 1390 },
    { "date": "2025-07-04", "score": 1595 },
    { "date": "2025-07-05", "score": 1891 },
    { "date": "2025-07-06", "score": 2049 },
  ];

  // 외부에서 데이터 유무 확인용 getter
  static bool get hasData => _scoreData.isNotEmpty;

  @override
  State<ScoreChart> createState() => _ScoreChartState();
}

class _ScoreChartState extends State<ScoreChart> {
  late final List<ScoreData> data;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // 날짜+점수 → ScoreData 객체 리스트로 변환
    data = ScoreChart._scoreData
        .map((e) => ScoreData(DateTime.parse(e['date']), e['score'] as int))
        .toList();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Y축 간격 계산
  double getNiceInterval(double maxValue, int targetTickCount) {
    final roughInterval = maxValue / targetTickCount;
    final magnitude = math.pow(10, roughInterval.floor().toString().length - 1).toDouble();
    return (roughInterval / magnitude).ceil() * magnitude;
  }

  @override
  Widget build(BuildContext context) {
    // 점수 리스트 추출 + 최대값 계산
    final scores = data.map((e) => e.score).toList();
    final maxScore = scores.reduce((a, b) => a > b ? a : b).toDouble();

    // 보기 좋은 눈금 및 간격 및 최대값 계산
    final interval = getNiceInterval(maxScore, 5);
    final maxY = interval * 5;

    return Scrollbar(
      controller: _scrollController,
      thumbVisibility: true, // 스크롤바 항상 보이게
      trackVisibility: true,
      thickness: 4,
      radius: const Radius.circular(4),
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal, // 가로 스크롤 설정
        child: SizedBox(
          width: data.length * 60, // 데이터 개수 기준 너비 설정
          height: 200,
          child: SfCartesianChart(
            // X축 설정 (날짜 기반)
            primaryXAxis: DateTimeAxis(
              intervalType: DateTimeIntervalType.days,
              dateFormat: DateFormat('MM/dd'),
              majorGridLines: const MajorGridLines(width: 0), // X축 격자 숨김
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              enableAutoIntervalOnZooming: true,
            ),
            // Y축 설정 (점수 기반)
            primaryYAxis: NumericAxis(
              minimum: 0,
              maximum: maxY,
              interval: interval,
              labelFormat: '{value}',
              numberFormat: NumberFormat.compact(), // 1000을 1k로 표현
              majorGridLines: MajorGridLines(
                width: 0.3,                     // 격자선 살짝 보이게
                color: Colors.grey.shade400,
                dashArray: [4, 3],
              ),
              axisLine: const AxisLine(width: 1),
            ),
            // 툴팁 설정 (커서 올리면 점수 표시)
            tooltipBehavior: TooltipBehavior(enable: true, format: 'point.y점'),
            // 라인 차트 시리즈
            series: [
              LineSeries<ScoreData, DateTime>(
                name: '',
                dataSource: data,
                xValueMapper: (ScoreData score, _) => score.date,
                yValueMapper: (ScoreData score, _) => score.score,
                markerSettings: const MarkerSettings(isVisible: true),
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  textStyle: TextStyle(fontSize: 10),
                  labelAlignment: ChartDataLabelAlignment.top,
                ),
                color: AppColors.primary,
                width: 3,
                enableTooltip: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 데이터 모델
class ScoreData {
  final DateTime date;
  final int score;
  ScoreData(this.date, this.score);
}

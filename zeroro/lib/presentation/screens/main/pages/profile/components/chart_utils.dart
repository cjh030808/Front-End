import 'dart:math' as math;

double getNiceInterval(double maxValue, int targetTickCount) {
  double roughInterval = maxValue / targetTickCount;

  // 간격 자리수 계산
  double magnitude = math.pow(10, roughInterval.toString().split('.')[0].length - 1).toDouble();

  // roughInterval을 magnitude 단위로 나누고 올림 처리해서 깔끔한 수로 변환
  double niceInterval = (roughInterval / magnitude).ceil() * magnitude;

  return niceInterval;
}

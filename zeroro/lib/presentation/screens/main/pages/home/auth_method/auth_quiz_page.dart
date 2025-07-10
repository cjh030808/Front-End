import 'dart:async';
import 'package:flutter/material.dart';
import 'package:zeroro/core/theme/constant/app_color.dart';
import '../../../cubit/fade_message_box.dart';

class AuthQuizPage extends StatefulWidget {
  const AuthQuizPage({super.key});

  @override
  State<AuthQuizPage> createState() => _AuthQuizPageState();
}

class _AuthQuizPageState extends State<AuthQuizPage>
    with SingleTickerProviderStateMixin {
  // 퀴즈 문제 리스트 (서버에서 받아올 데이터 구조 모킹)
  final List<Map<String, dynamic>> _questions = [
    {'question': '테스트 지문 1: 병아리는 배꼽이 있을까요?', 'answer': false},
    {'question': '테스트 지문 2: 태양은 동쪽에서 뜬다?', 'answer': true},
  ];

  // 현재 문제 인덱스
  int _currentQuestionIndex = 0;

  // 현재 화면에 보여줄 문제 텍스트
  String _questionText = '로딩 중...';

  // 현재 문제의 정답 (true or false)
  bool? _correctAnswer;

  // 사용자가 답한 후 보여줄 결과 메시지 텍스트 ('정답!' or '땡!')
  String? _resultMessage;

  // 결과 메시지 배경색 (정답 시 연두색, 틀렸을 때 빨간색)
  Color? _resultColor;

  // 페이드 애니메이션 컨트롤러 및 애니메이션
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  // 결과 메시지 표시 후 자동 사라짐 타이머
  Timer? _resultTimer;

  // 결과 메시지 노출 시간 및 페이드 아웃 지속 시간 설정 (상수)
  static const Duration messageVisibleDuration = Duration(milliseconds: 800);
  static const Duration fadeDuration = Duration(milliseconds: 400);

  @override
  void initState() {
    super.initState();

    // 페이드 애니메이션 컨트롤러 초기화 (0.4초 동안 투명도 1->0)
    _fadeController = AnimationController(vsync: this, duration: fadeDuration);
    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(_fadeController);

    // 첫 번째 문제 로드
    _loadQuestion(_currentQuestionIndex);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _resultTimer?.cancel();
    super.dispose();
  }

  // 문제 데이터를 받아 화면에 적용하는 함수
  void _loadQuestion(int index) {
    // 인덱스 범위 벗어나면 에러 처리
    if (index < 0 || index >= _questions.length) {
      setState(() {
        _questionText = '질문 로딩 실패';
        _correctAnswer = null;
      });
      return;
    }

    final questionData = _questions[index];

    setState(() {
      _questionText = questionData['question'] as String;
      _correctAnswer = questionData['answer'] as bool;
      _resultMessage = null; // 문제 바뀌면 결과 메시지 초기화
    });
  }

  // 사용자가 O/X 답변 버튼을 눌렀을 때 호출
  void _handleAnswer(bool userAnswer) {
    if (_correctAnswer == null) return; // 정답 없으면 무시

    bool isCorrect = (userAnswer == _correctAnswer);

    setState(() {
      // 맞았으면 '정답!', 틀렸으면 '땡!' 메시지와 색상 설정
      _resultMessage = isCorrect ? '정답!' : '땡!';
      _resultColor = isCorrect ? AppColors.positive : AppColors.error;
    });

    // 페이드 애니메이션 초기화 및 타이머 세팅
    _fadeController.reset();
    _resultTimer?.cancel();

    // 메시지 보여주고 나서 페이드 아웃 시작
    _resultTimer = Timer(messageVisibleDuration, () {
      _fadeController.forward();
      // 페이드 아웃 끝나면 메시지 제거하고 자동으로 다음 문제 로드
      Timer(fadeDuration, () {
        if (mounted) {
          setState(() {
            _resultMessage = null;
          });
          _nextQuestion();
        }
      });
    });
  }

  // 다음 문제로 넘어가는 함수
  void _nextQuestion() {
    if (_currentQuestionIndex + 1 < _questions.length) {
      setState(() {
        _currentQuestionIndex++;
      });
      _loadQuestion(_currentQuestionIndex);
    } else {
      // 마지막 문제면 다시 처음 문제로 돌아감
      setState(() {
        _currentQuestionIndex = 0;
      });
      _loadQuestion(_currentQuestionIndex);
    }
  }

  // O/X 버튼을 그림자 포함해서 만드는 위젯
  Widget _shadowButton({
    required String label,
    required VoidCallback onPressed,
    required Color backgroundColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          // 버튼 외곽에 그림자 효과
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            offset: const Offset(0, 6),
            blurRadius: 8,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 32, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '퀴즈 인증',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // 상단 문제 표시 영역 (카드 스타일)
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        width: double.infinity,
                        child: Text(
                          _questionText,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // 하단 O/X 버튼 영역
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 95),
                child: Row(
                  children: [
                    Expanded(
                      child: _shadowButton(
                        label: 'O',
                        onPressed: () => _handleAnswer(true),
                        backgroundColor: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _shadowButton(
                        label: 'X',
                        onPressed: () => _handleAnswer(false),
                        backgroundColor: AppColors.error,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // 결과 메시지 Fade 애니메이션 처리 및 중앙 표시
          if (_resultMessage != null)
            Center(
              child: FadeMessageBox(
                message: _resultMessage!,
                backgroundColor:
                    _resultColor?.withValues(alpha: 0.7) ??
                    Colors.black.withValues(alpha: 0.7),
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
                animation: _fadeAnimation,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 32,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
        ],
      ),
    );
  }
}

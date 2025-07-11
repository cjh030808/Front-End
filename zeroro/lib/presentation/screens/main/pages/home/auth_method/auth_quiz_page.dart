import 'dart:async';
import 'package:flutter/material.dart';
import 'package:zeroro/core/theme/constant/app_color.dart';
import '../../../cubit/fade_message_box.dart';
import '../components/info_dialog.dart';

class AuthQuizPage extends StatefulWidget {
  const AuthQuizPage({super.key});

  @override
  State<AuthQuizPage> createState() => _AuthQuizPageState();
}

class _AuthQuizPageState extends State<AuthQuizPage>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> _questions = [
    {'question': '테스트 지문 1: 병아리는 배꼽이 있을까요?', 'answer': false},
    {'question': '테스트 지문 2: 태양은 동쪽에서 뜬다?', 'answer': true},
  ];

  int _currentQuestionIndex = 0;
  String _questionText = '로딩 중...';
  bool? _correctAnswer;
  String? _resultMessage;
  Color? _resultColor;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  Timer? _resultTimer;

  static const Duration messageVisibleDuration = Duration(milliseconds: 800);
  static const Duration fadeDuration = Duration(milliseconds: 400);

  bool _dialogShown = false;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(vsync: this, duration: fadeDuration);
    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(_fadeController);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showIntroDialog();
    });

    _loadQuestion(_currentQuestionIndex);
  }

  void _showIntroDialog() {
    if (_dialogShown) return;
    _dialogShown = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CustomInfoDialog(
        title: '퀴즈 인증이란?',
        content: '제시된 지문이 친환경 행동인지 판단하고 OX로 선택해주세요.\n\n\n\n\n\n\n\n\n\n\n\n'
            '지문 길이 테스트',
        onClose: (dontShowAgain) {
          if (dontShowAgain) {
            // 서버에 다시보지 않기 상태 저장 예정
          } else {
            // 로컬 상태 저장만
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _resultTimer?.cancel();
    super.dispose();
  }

  void _loadQuestion(int index) {
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
      _resultMessage = null;
    });
  }

  void _handleAnswer(bool userAnswer) {
    if (_correctAnswer == null) return;

    bool isCorrect = (userAnswer == _correctAnswer);

    setState(() {
      _resultMessage = isCorrect ? '정답!' : '땡!';
      _resultColor = isCorrect ? AppColors.positive : AppColors.error;
    });

    _fadeController.reset();
    _resultTimer?.cancel();

    _resultTimer = Timer(messageVisibleDuration, () {
      _fadeController.forward();
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

  void _nextQuestion() {
    if (_currentQuestionIndex + 1 < _questions.length) {
      setState(() {
        _currentQuestionIndex++;
      });
      _loadQuestion(_currentQuestionIndex);
    } else {
      setState(() {
        _currentQuestionIndex = 0;
      });
      _loadQuestion(_currentQuestionIndex);
    }
  }

  Widget _shadowButton({
    required String label,
    required VoidCallback onPressed,
    required Color backgroundColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
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
          if (_resultMessage != null)
            Center(
              child: FadeMessageBox(
                message: _resultMessage!,
                backgroundColor: _resultColor?.withOpacity(0.7) ?? Colors.black.withOpacity(0.7),
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

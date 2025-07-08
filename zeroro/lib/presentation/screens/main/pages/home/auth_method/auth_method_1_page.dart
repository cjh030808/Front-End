import 'dart:async';
import 'package:flutter/material.dart';
import 'package:zeroro/core/theme/constant/app_color.dart';
import '../../../cubit/fade_message_box.dart';

class AuthMethod1Page extends StatefulWidget {
  const AuthMethod1Page({super.key});

  @override
  State<AuthMethod1Page> createState() => _AuthMethod1PageState();
}

class _AuthMethod1PageState extends State<AuthMethod1Page>
    with SingleTickerProviderStateMixin {
  final TextEditingController _contentController = TextEditingController(); // 설명 텍스트 입력 컨트롤러
  final List<String> _selectedImages = []; // 첨부 이미지 리스트

  bool _isAnalyzing = false; // AI 분석 진행 중 여부
  String? _analysisResult; // 분석 결과 메시지
  String? _warningMessage; // 경고 메시지

  Timer? _resultTimer; // 메시지 자동 사라짐 타이머
  late AnimationController _fadeController; // 페이드 애니메이션 컨트롤러
  late Animation<double> _fadeAnimation; // 투명도 애니메이션

  // 메시지 표시 시간 및 페이드 아웃 시간 상수
  static const Duration messageVisibleDuration = Duration(seconds: 2);
  static const Duration fadeDuration = Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    // 애니메이션 컨트롤러 초기화 (페이드 아웃용)
    _fadeController = AnimationController(vsync: this, duration: fadeDuration);
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_fadeController);
  }

  @override
  void dispose() {
    _contentController.dispose();
    _resultTimer?.cancel();
    _fadeController.dispose();
    super.dispose();
  }

  // 이미지 추가 (모의 이미지 경로)
  void _addImage() {
    setState(() {
      _selectedImages.add('assets/images/mock_image.jpg');
    });
  }

  // 이미지 삭제 (리스트에서 제거)
  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  // AI 분석 요청 함수
  Future<void> _requestAIAnalysis() async {
    // 텍스트와 이미지가 모두 비어있으면 경고 메시지 띄움
    if (_contentController.text.trim().isEmpty && _selectedImages.isEmpty) {
      _showWarning('설명이나 이미지를 입력해주세요.');
      return;
    }

    setState(() {
      _isAnalyzing = true; // 분석 상태 시작
      _analysisResult = null; // 이전 결과 초기화
    });

    // 실제 AI 호출 대신 2초 지연 (모의)
    await Future.delayed(const Duration(seconds: 2));
    const fakeResult = "친환경 행동으로 확인되었습니다!";
    //TODO: ai 판별 후 친환경 행동이면 점수를, 그게 아니면 친환경 행동이 아닙니다 출력

    if (!mounted) return;

    // 분석 완료 후 결과 메시지 표시
    setState(() {
      _isAnalyzing = false;
      _analysisResult = fakeResult;
    });

    // 메시지 자동 페이드 아웃 타이머 시작
    _startFadeOutTimer(() {
      setState(() {
        _analysisResult = null;
      });
    });
  }

  // 경고 메시지 표시 함수
  void _showWarning(String message) {
    setState(() {
      _warningMessage = message;
    });

    // 경고 메시지도 자동 페이드 아웃 타이머 적용
    _startFadeOutTimer(() {
      setState(() {
        _warningMessage = null;
      });
    });
  }

  // 메시지 페이드 아웃 처리 공통 함수
  void _startFadeOutTimer(VoidCallback onComplete) {
    _fadeController.reset(); // 애니메이션 초기화
    _resultTimer?.cancel();  // 기존 타이머 취소
    _resultTimer = Timer(messageVisibleDuration, () {
      _fadeController.forward(); // 페이드 아웃 시작
      Timer(fadeDuration, () {
        if (mounted) onComplete(); // 페이드 완료 후 상태 초기화
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AI 인증',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        // 분석 요청 버튼을 앱바 우측에 배치
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ElevatedButton(
              onPressed: _isAnalyzing ? null : _requestAIAnalysis,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              // 분석 중에는 로딩 인디케이터 표시
              child: _isAnalyzing
                  ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor:
                  AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
                  : const Text('AI 분석'),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 사용자 프로필 및 이름 표시
                      Row(
                        children: const [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: AppColors.primaryContainer,
                            child: Icon(Icons.person,
                                size: 20, color: Colors.grey),
                          ),
                          SizedBox(width: 12),
                          Text(
                            '나',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // 사용자 입력 텍스트 필드
                      TextFormField(
                        controller: _contentController,
                        minLines: 8,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: '무엇을 했는지 설명해주세요',
                          hintStyle:
                          TextStyle(fontSize: 18, color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      // 첨부된 이미지가 있으면 리스트로 보여줌
                      if (_selectedImages.isNotEmpty) ...[
                        const Text(
                          '첨부된 이미지',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _selectedImages.length,
                            itemBuilder: (context, index) => Container(
                              margin: const EdgeInsets.only(right: 12),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      _selectedImages[index],
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  // 이미지 삭제 버튼
                                  Positioned(
                                    top: 4,
                                    right: 4,
                                    child: GestureDetector(
                                      onTap: () => _removeImage(index),
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                          color: Colors.black54,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.close,
                                            color: Colors.white, size: 16),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ],
                  ),
                ),
              ),
              // 하단 이미지 추가 버튼 영역
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                  Border(top: BorderSide(color: Colors.grey.shade300)),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: _addImage,
                      icon: const Icon(Icons.photo_library_outlined),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
          // AI 분석 중일 때 하단 고정 메시지 표시
          if (_isAnalyzing)
            Positioned(
              bottom: 80,
              left: 16,
              right: 16,
              child: Container(
                padding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.positive,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'AI가 분석 중입니다...',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          // 분석 완료 결과 메시지 페이드 애니메이션과 함께 중앙에 표시
          if (_analysisResult != null && !_isAnalyzing)
            Positioned.fill(
              child: Center(
                child: FadeMessageBox(
                  message: _analysisResult!,
                  animation: _fadeAnimation,
                  backgroundColor: AppColors.positive.withOpacity(0.8),
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                ),
              ),
            ),
          // 경고 메시지도 페이드 애니메이션과 함께 하단에 표시
          if (_warningMessage != null)
            Positioned(
              bottom: 80,
              left: 16,
              right: 16,
              child: FadeMessageBox(
                message: _warningMessage!,
                animation: _fadeAnimation,
                backgroundColor: AppColors.error,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

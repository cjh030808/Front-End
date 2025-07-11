import 'dart:async';
import 'package:flutter/material.dart';
import 'package:zeroro/core/theme/constant/app_color.dart';
import '../../../cubit/fade_message_box.dart';
import '../components/category_selector.dart';
import '../components/suggestion_page.dart';
import '../components/info_dialog.dart';

class AuthImagePage extends StatefulWidget {
  const AuthImagePage({super.key});

  @override
  State<AuthImagePage> createState() => _AuthImagePageState();
}

class _AuthImagePageState extends State<AuthImagePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _contentController = TextEditingController();
  final List<String> _selectedImages = [];

  bool _isAnalyzing = false;
  String? _warningMessage;
  String? _selectedSubCategory;

  bool _dialogAlreadyShown = false;
  bool _doNotShowAgain = false;

  Timer? _resultTimer;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  static const Duration messageVisibleDuration = Duration(seconds: 2);
  static const Duration fadeDuration = Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(vsync: this, duration: fadeDuration);
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_fadeController);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_doNotShowAgain && !_dialogAlreadyShown) {
        _showInfoDialog();
        _dialogAlreadyShown = true;
      }
    });
  }

  @override
  void dispose() {
    _contentController.dispose();
    _resultTimer?.cancel();
    _fadeController.dispose();
    super.dispose();
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      builder: (_) => CustomInfoDialog(
        title: '사진 인증이란?',
        content:
        '친환경 활동을 사진으로 증명하고 AI로 인증을 받는 기능입니다.\n\n사진과 설명을 함께 첨부하고\n카테고리를 선택하면 AI가 친환경 여부를 판단합니다.',
        onClose: (dontShowAgain) {
          setState(() {
            _doNotShowAgain = dontShowAgain;
          });
        },
      ),
    );
  }

  void _addImage() {
    setState(() {
      _selectedImages.add('assets/images/mock_image.jpg');
    });
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  Future<void> _requestAIAnalysis() async {
    final isImageEmpty = _selectedImages.isEmpty;
    final isCategoryNotSelected = _selectedSubCategory == null;

    if (isImageEmpty && isCategoryNotSelected) {
      _showWarning('이미지를 첨부하고 카테고리를 선택해주세요');
      return;
    }

    if (isImageEmpty) {
      _showWarning('이미지를 첨부해주세요');
      return;
    }

    if (isCategoryNotSelected) {
      _showWarning('카테고리를 선택해주세요');
      return;
    }

    setState(() => _isAnalyzing = true);

    await Future.delayed(const Duration(seconds: 2));
    const fakeResult = "친환경 행동으로 확인되었습니다!";

    if (!mounted) return;
    Navigator.pop(context, fakeResult);
  }

  void _showWarning(String message) {
    setState(() {
      _warningMessage = message;
    });

    _startFadeOutTimer(() {
      setState(() {
        _warningMessage = null;
      });
    });
  }

  void _startFadeOutTimer(VoidCallback onComplete) {
    _fadeController.reset();
    _resultTimer?.cancel();
    _resultTimer = Timer(messageVisibleDuration, () {
      _fadeController.forward();
      Timer(fadeDuration, () {
        if (mounted) onComplete();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '사진 인증',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ElevatedButton(
              onPressed: _isAnalyzing ? null : _requestAIAnalysis,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: _isAnalyzing
                  ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
                  : const Text('AI 분석'),
            ),
          ),
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
                      CategorySelector(
                        onSubCategorySelected: (value) {
                          setState(() => _selectedSubCategory = value);
                        },
                        onSuggestionTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SuggestionPage(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _contentController,
                        minLines: 8,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: 'AI 인증을 위해 사진을 설명해주세요',
                          hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      if (_selectedImages.isNotEmpty) ...[
                        const Text(
                          '첨부된 이미지',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                                        child: const Icon(Icons.close, color: Colors.white, size: 16),
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.grey.shade300)),
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
          if (_isAnalyzing)
            Positioned(
              bottom: 80,
              left: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.positive,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'AI가 분석 중입니다...',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
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

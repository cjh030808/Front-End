import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeroro/core/theme/constant/app_color.dart';
import '../../../cubit/fade_message_box.dart';
import '../components/category_selector.dart';
import '../components/suggestion_page.dart';
import '../components/info_dialog.dart';
import '../components/info_button.dart';

import '../components/camera_picker.dart';
import '../components/gallery_picker.dart';

class AuthImagePage extends StatefulWidget {
  const AuthImagePage({super.key});

  @override
  State<AuthImagePage> createState() => _AuthImagePageState();
}

class _AuthImagePageState extends State<AuthImagePage> with SingleTickerProviderStateMixin {
  final TextEditingController _contentController = TextEditingController();
  final List<String> _selectedImages = [];

  final CameraPicker _cameraPicker = CameraPicker();
  final GalleryPicker _galleryPicker = GalleryPicker();

  bool _isAnalyzing = false;
  String? _warningMessage;
  String? _selectedSubCategory;

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

    _maybeShowInfoDialog();
  }

  Future<void> _maybeShowInfoDialog() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenDialog = prefs.getBool('showAuthImageDialog') ?? false;
    if (!hasSeenDialog) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false,
          barrierColor: Colors.black54,
          builder: (_) => CustomInfoDialog(
            title: '사진 인증이란?',
            content:
            '친환경 활동을 사진으로 증명하고 AI로 인증을 받는 기능입니다.\n\n사진과 설명을 함께 첨부하고\n카테고리를 선택하면 AI가 친환경 여부를 판단합니다.',
            preferenceKey: 'showAuthImageDialog',
            onClose: (_) {},
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    _contentController.dispose();
    _resultTimer?.cancel();
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _pickFromCamera() async {
    final file = await _cameraPicker.pickImageFromCamera();
    if (file != null) {
      setState(() => _selectedImages.add(file.path));
    }
  }

  Future<void> _pickFromGallery() async {
    final file = await _galleryPicker.pickImageFromGallery();
    if (file != null) {
      setState(() => _selectedImages.add(file.path));
    }
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
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
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
                                    child: Image.file(
                                      File(_selectedImages[index]),
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
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 16,
                                        ),
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
                      onPressed: _pickFromCamera,
                      icon: const Icon(Icons.camera_alt_outlined),
                    ),
                    IconButton(
                      onPressed: _pickFromGallery,
                      icon: const Icon(Icons.photo_library_outlined),
                    ),
                    const Spacer(),
                    // 설명 버튼 추가: 유지보수용 공통 컴포넌트
                    const InfoButton(
                      title: '사진 인증이란?',
                      content:
                      '친환경 활동을 사진으로 증명하고 AI로 인증을 받는 기능입니다.\n\n사진과 설명을 함께 첨부하고\n카테고리를 선택하면 AI가 친환경 여부를 판단합니다.',
                      preferenceKey: 'showAuthImageDialog',
                    ),
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
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
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

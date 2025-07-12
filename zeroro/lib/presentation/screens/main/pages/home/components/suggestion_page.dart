import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeroro/core/theme/constant/app_color.dart';
import '../components/gallery_picker.dart';
import '../../../cubit/fade_message_box.dart';
import '../components/info_dialog.dart';
import '../components/info_button.dart';

class SuggestionPage extends StatefulWidget {
  const SuggestionPage({super.key});

  @override
  State<SuggestionPage> createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _contentController = TextEditingController();
  final List<String> _selectedImages = [];
  final GalleryPicker _galleryPicker = GalleryPicker();

  String? _warningMessage;
  String? _successMessage;

  Timer? _resultTimer;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  static const Duration messageVisibleDuration = Duration(seconds: 2);
  static const Duration fadeDuration = Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(vsync: this, duration: fadeDuration);
    _fadeAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_fadeController);

    _maybeShowInfoDialog(); // 설명문 표시 함수 호출
  }

  Future<void> _maybeShowInfoDialog() async {
    final prefs = await SharedPreferences.getInstance();
    final shouldShow = !(prefs.getBool('showSuggestionDialog') ?? false);

    if (shouldShow) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => CustomInfoDialog(
            title: '건의하기 안내',
            content:
            '앱에서 불편한 점, 추가되었으면 하는 기능, 버그 제보 등을 자유롭게 작성해주세요!\n\n사진을 첨부하면 더 좋아요!',
            preferenceKey: 'showSuggestionDialog',
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

  Future<void> _pickFromGallery() async {
    final file = await _galleryPicker.pickImageFromGallery();
    if (file != null) {
      setState(() => _selectedImages.add(file.path));
    }
  }

  void _removeImage(int index) {
    setState(() => _selectedImages.removeAt(index));
  }

  void _submitSuggestion() {
    final hasText = _contentController.text.trim().isNotEmpty;

    if (!hasText) {
      _showWarning('내용을 입력해주세요');
      return;
    }

    setState(() {
      _successMessage = '건의가 정상적으로 제출되었습니다!';
    });

    Future.delayed(messageVisibleDuration, () {
      if (mounted) {
        Navigator.pop(context, _successMessage);
      }
    });
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
          '건의하기',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ElevatedButton(
              onPressed: _submitSuggestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('제출'),
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
                      TextFormField(
                        controller: _contentController,
                        minLines: 8,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: '건의할 내용을 작성해주세요',
                          hintStyle:
                          TextStyle(fontSize: 18, color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.grey.shade300)),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: _pickFromGallery,
                      icon: const Icon(Icons.photo_library_outlined),
                    ),
                    const Spacer(),
                    const InfoButton(
                      title: '건의하기 안내',
                      content: '앱에서 불편한 점, 추가되었으면 하는 기능, 버그 제보 등을 자유롭게 작성해주세요!\n\n사진을 첨부하면 더 좋아요!',
                      preferenceKey: 'showSuggestionDialog',
                    ),
                  ],
                ),
              ),
            ],
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
          if (_successMessage != null)
            Center(
              child: Container(
                padding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                decoration: BoxDecoration(
                  color: AppColors.positive,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  _successMessage!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

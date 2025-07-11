import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zeroro/core/theme/constant/app_color.dart';
import 'package:zeroro/domain/model/post/post.model.dart';
import '../main/cubit/fade_message_box.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeroro/presentation/screens/main/pages/community/bloc/community_bloc.dart';
import 'package:zeroro/core/constants.dart';

class NewPostScreen extends StatefulWidget {
  final Post? editPost;

  const NewPostScreen({super.key, this.editPost});

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _contentController = TextEditingController();
  String? _selectedImage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  String? _warningMessage;

  Timer? _resultTimer;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  static const Duration messageVisibleDuration = Duration(seconds: 2);
  static const Duration fadeDuration = Duration(milliseconds: 500);

  bool get isEditMode => widget.editPost != null;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(vsync: this, duration: fadeDuration);
    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(_fadeController);

    // 수정 모드일 때 기존 데이터로 초기화
    if (isEditMode) {
      _contentController.text = widget.editPost!.content;
      _selectedImage = widget.editPost!.imageUrl;
    }
  }

  @override
  void dispose() {
    _contentController.dispose();
    _resultTimer?.cancel();
    _fadeController.dispose();
    super.dispose();
  }

  void _addImage() {
    setState(() {
      _selectedImage = 'assets/images/mock_image.jpg';
    });
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  void _showWarning(String message) {
    setState(() => _warningMessage = message);

    _fadeController.reset();
    _resultTimer?.cancel();
    _resultTimer = Timer(messageVisibleDuration, () {
      _fadeController.forward();
      Timer(fadeDuration, () {
        if (mounted) setState(() => _warningMessage = null);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommunityBloc, CommunityState>(
      listener: (context, state) {
        if (state.shouldRefresh) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                isEditMode ? '게시글이 성공적으로 수정되었습니다!' : '게시글이 성공적으로 작성되었습니다!',
              ),
              backgroundColor: AppColors.positive,
            ),
          );
          context.pop();
        } else if (state.status == Status.error) {
          _showWarning(state.errorResponse?.message ?? '오류가 발생했습니다.');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => context.pop(),
          ),
          title: Text(
            isEditMode ? '게시글 수정' : '새 게시글',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: TextButton(
                onPressed: _isLoading
                    ? null
                    : () {
                        if (!_formKey.currentState!.validate()) return;
                        if (_contentController.text.trim().isEmpty &&
                            _selectedImage == null) {
                          _showWarning('내용이나 이미지 중 하나는 필수입니다.');
                          return;
                        }
                        setState(() => _isLoading = true);

                        if (isEditMode) {
                          // 수정 모드
                          context.read<CommunityBloc>().add(
                            UpdatePost(
                              postId: widget.editPost!.id,
                              title: _contentController.text.substring(
                                0,
                                (_contentController.text.length > 10
                                    ? 10
                                    : _contentController.text.length),
                              ),
                              content: _contentController.text,
                              likesCount: widget.editPost!.likesCount,
                              imageUrl: _selectedImage,
                            ),
                          );
                        } else {
                          // 생성 모드
                          context.read<CommunityBloc>().add(
                            CreatePost(
                              userId: '10dcf52e-950f-4f39-98fc-b3a8fcbb320d',
                              title: _contentController.text.substring(
                                0,
                                (_contentController.text.length > 10
                                    ? 10
                                    : _contentController.text.length),
                              ),
                              content: _contentController.text,
                              imageUrl: _selectedImage,
                            ),
                          );
                        }
                      },
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.white,
                          ),
                        ),
                      )
                    : Text(
                        isEditMode ? '수정' : '게시',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: AppColors.primaryContainer,
                                child: Icon(
                                  Icons.person,
                                  size: 20,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text(
                                '나',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _contentController,
                            maxLines: null,
                            minLines: 8,
                            decoration: const InputDecoration(
                              hintText: '무엇을 생각하고 있나요?',
                              hintStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 20),
                          if (_selectedImage != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child:
                                            isEditMode &&
                                                !_selectedImage!.startsWith(
                                                  'assets/',
                                                )
                                            ? Image.network(
                                                _selectedImage!,
                                                width: 120,
                                                height: 120,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset(
                                                _selectedImage!,
                                                width: 120,
                                                height: 120,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                      Positioned(
                                        top: 4,
                                        right: 4,
                                        child: GestureDetector(
                                          onTap: _removeImage,
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
                                const SizedBox(height: 20),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: _selectedImage == null ? _addImage : null,
                          icon: const Icon(Icons.photo_library_outlined),
                        ),
                        const Spacer(),
                        Text(
                          '${_contentController.text.length}/500',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 하단 경고 문구
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
      ),
    );
  }
}

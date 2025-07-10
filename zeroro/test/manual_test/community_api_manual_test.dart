import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zeroro/data/data_source/community.api.dart';
import 'package:zeroro/domain/model/post/post.model.dart';
import 'package:zeroro/domain/model/comment/comment.model.dart';

/// 로컬 서버와 CommunityApi를 수동으로 테스트하는 스크립트
///
/// 사용법:
/// 1. 로컬 서버가 http://127.0.0.1:8000 에서 실행되고 있는지 확인
/// 2. dart run test/manual_test/community_api_manual_test.dart 실행
void main() async {
  debugPrint('🚀 CommunityApi 로컬 서버 테스트 시작');
  debugPrint('📡 서버 주소: http://127.0.0.1:8000/api/v1/community');
  debugPrint('─' * 50);

  final tester = CommunityApiTester();

  // 서버 연결 확인
  final isServerRunning = await tester.checkServerHealth();
  if (!isServerRunning) {
    debugPrint('❌ 서버에 연결할 수 없습니다. 로컬 서버가 실행 중인지 확인해주세요.');
    exit(1);
  }

  // 전체 API 테스트 실행
  await tester.runAllTests();

  debugPrint('─' * 50);
  debugPrint('✅ 모든 테스트 완료');
}

class CommunityApiTester {
  late final CommunityApi communityApi;
  late final Dio dio;

  CommunityApiTester() {
    // Dio 설정
    dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);

    // 로깅 인터셉터 추가
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: false,
        responseHeader: false,
        error: true,
        logPrint: (obj) => debugPrint('🌐 $obj'),
      ),
    );

    communityApi = CommunityApi(dio);
  }

  /// 서버 연결 상태 확인
  Future<bool> checkServerHealth() async {
    try { 
      debugPrint('🔍 서버 연결 확인 중...');
      await dio.get('http://127.0.0.1:8000/health'); // 헬스체크 엔드포인트 (서버에 있다면)
      debugPrint('✅ 서버 연결 성공');
      return true;
    } catch (e) {
      // 헬스체크 엔드포인트가 없다면 게시글 목록으로 테스트
      try {
        await communityApi.getPosts(0);
        debugPrint('✅ 서버 연결 성공 (게시글 API로 확인)');
        return true;
      } catch (e2) {
        debugPrint('❌ 서버 연결 실패: $e2');
        return false;
      }
    }
  }

  /// 모든 API 테스트 실행
  Future<void> runAllTests() async {
    await testPostsApi();
    await testCommentsApi();
  }

  /// 게시글 API 테스트
  Future<void> testPostsApi() async {
    debugPrint('\n📝 게시글 API 테스트');
    debugPrint('─' * 30);

    // 1. 게시글 목록 조회
    await _safeTest('게시글 목록 조회', () async {
      final posts = await communityApi.getPosts(0);
        debugPrint('   📋 조회된 게시글 수: ${posts.length}');
      if (posts.isNotEmpty) {
        debugPrint('   📌 첫 번째 게시글: "${posts.first.title}"');
      }
    });

    // 2. 게시글 생성
    String? createdPostId;
    await _safeTest('게시글 생성', () async {
      final testPost = _createTestPost();
      final createdPost = await communityApi.createPost(testPost);
      createdPostId = createdPost.uid;
      debugPrint('   📄 생성된 게시글 ID: $createdPostId');
      debugPrint('   📝 제목: "${createdPost.title}"');
    });

    // 3. 게시글 수정 (생성이 성공했을 때만)
    if (createdPostId != null) {
      await _safeTest('게시글 수정', () async {
        final updatedPost = _createTestPost(
          uid: createdPostId!,
          title: '수정된 테스트 게시글',
          content: '수정된 내용입니다.',
        );

        final result = await communityApi.updatePost(
          int.tryParse(createdPostId!) ?? 1,
          updatedPost,
        );
        debugPrint('   ✏️ 수정된 제목: "${result.title}"');
      });

      // 4. 게시글 삭제
      await _safeTest('게시글 삭제', () async {
        await communityApi.deletePost(int.tryParse(createdPostId!) ?? 1);
        debugPrint('   🗑️ 게시글 삭제 완료');
      });
    }
  }

  /// 댓글 API 테스트
  Future<void> testCommentsApi() async {
    debugPrint('\n💬 댓글 API 테스트');
    debugPrint('─' * 30);

    const testPostId = 1; // 기존에 존재하는 게시글 ID 가정

    // 1. 댓글 목록 조회
    await _safeTest('댓글 목록 조회', () async {
      final comments = await communityApi.getComments(testPostId);
      debugPrint('   💭 조회된 댓글 수: ${comments.length}');
      if (comments.isNotEmpty) {
        debugPrint('   💬 첫 번째 댓글: "${comments.first.content}"');
      }
    });

    // 2. 댓글 생성
    String? createdCommentId;
    await _safeTest('댓글 생성', () async {
      final testComment = _createTestComment(postId: testPostId);
      final createdComment = await communityApi.createComment(
        testPostId,
        testComment,
      );
      createdCommentId = createdComment.uid;
      debugPrint('   💬 생성된 댓글 ID: $createdCommentId');
      debugPrint('   📝 내용: "${createdComment.content}"');
    });

    // 3. 댓글 수정 (생성이 성공했을 때만)
    if (createdCommentId != null) {
      await _safeTest('댓글 수정', () async {
        final result = await communityApi.updateComment(
          testPostId,
          int.tryParse(createdCommentId!) ?? 1,
          '수정된 댓글 내용입니다.',
        );
        debugPrint('   ✏️ 수정된 내용: "${result.content}"');
      });

      // 4. 댓글 삭제
      await _safeTest('댓글 삭제', () async {
        await communityApi.deleteComment(
          testPostId,
          int.tryParse(createdCommentId!) ?? 1,
        );
        debugPrint('   🗑️ 댓글 삭제 완료');
      });
    }
  }

  /// 안전한 테스트 실행 (에러 처리 포함)
  Future<void> _safeTest(String testName, Future<void> Function() test) async {
    try {
      debugPrint('🧪 $testName...');
      await test();
      debugPrint('   ✅ 성공');
    } catch (e) {
      debugPrint('   ❌ 실패: $e');
      if (e is DioException) {
        debugPrint('   📊 상태 코드: ${e.response?.statusCode}');
        debugPrint('   📄 응답 데이터: ${e.response?.data}');
      }
    }
  }

  /// 테스트용 게시글 생성
  Post _createTestPost({String? uid, String? title, String? content}) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return Post(
      id: 0,
      uid: uid ?? 'test_post_$timestamp',
      title: title ?? '테스트 게시글 #$timestamp',
      content: content ?? '이것은 테스트용 게시글 내용입니다. 생성 시간: ${DateTime.now()}',
      likeCount: 0,
      createdAt: DateTime.now(),
      userName: '테스트사용자',
      imageUrl: null,
      userImg: null,
    );
  }

  /// 테스트용 댓글 생성
  Comment _createTestComment({required int postId}) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return Comment(
      id: 0,
      postId: postId,
      uid: 'test_comment_$timestamp',
      content: '이것은 테스트 댓글입니다. 생성 시간: ${DateTime.now()}',
      createdAt: DateTime.now(),
    );
  }
}

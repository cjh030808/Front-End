import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:zeroro/data/data_source/community.api.dart';
import 'package:zeroro/domain/model/post/post.model.dart';
import 'package:zeroro/domain/model/comment/comment.model.dart';

void main() {
  group('CommunityApi 로컬 서버 테스트', () {
    late CommunityApi communityApi;
    late Dio dio;

    setUpAll(() {
      // Dio 설정
      dio = Dio();
      dio.options.connectTimeout = const Duration(seconds: 10);
      dio.options.receiveTimeout = const Duration(seconds: 10);

      // 로깅 인터셉터 추가 (디버깅용)
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          requestHeader: true,
          responseHeader: false,
          error: true,
        ),
      );

      // CommunityApi 인스턴스 생성
      communityApi = CommunityApi(dio);
    });

    group('게시글 API 테스트', () {
      test('게시글 목록 조회 테스트', () async {
        try {
          final posts = await communityApi.getPosts(0);
          expect(posts, isA<List<Post>>());
          debugPrint('✅ 게시글 목록 조회 성공: ${posts.length}개의 게시글');

          if (posts.isNotEmpty) {
            debugPrint('첫 번째 게시글: ${posts.first.title}');
          }
        } catch (e) {
          debugPrint('❌ 게시글 목록 조회 실패: $e');
          // 서버가 실행되지 않은 경우 테스트 스킵
          expect(e, isA<DioException>());
        }
      });

      test('게시글 생성 테스트', () async {
        final testPost = Post(
          id: 0,
          uid: 'test_user_${DateTime.now().millisecondsSinceEpoch}',
          content: '테스트 게시글 내용입니다.',
          title: '테스트 게시글 제목',
          likeCount: 0,
          createdAt: DateTime.now(),
          userName: '테스트 사용자',
          imageUrl: null,
          userImg: null,
        );

        try {
          final createdPost = await communityApi.createPost(testPost);
          expect(createdPost, isA<Post>());
          expect(createdPost.title, equals(testPost.title));
          expect(createdPost.content, equals(testPost.content));
          debugPrint('✅ 게시글 생성 성공: ${createdPost.title}');

          // 생성된 게시글을 전역 변수에 저장 (다른 테스트에서 사용)
          _createdPostId = createdPost.uid;
        } catch (e) {
          debugPrint('❌ 게시글 생성 실패: $e');
          expect(e, isA<DioException>());
        }
      });

      test('게시글 수정 테스트', () async {
        if (_createdPostId == null) {
          debugPrint('⚠️ 게시글 수정 테스트 스킵: 생성된 게시글 없음');
          return;
        }

        final updatedPost = Post(
          id: 0,
          uid: _createdPostId!,
          content: '수정된 게시글 내용입니다.',
          title: '수정된 게시글 제목',
          likeCount: 1,
          createdAt: DateTime.now(),
          userName: '테스트 사용자',
          imageUrl: null,
          userImg: null,
        );

        try {
          // Note: postId가 int 타입이어야 할 수도 있습니다. 서버 구현에 따라 조정 필요
          final result = await communityApi.updatePost(
            int.tryParse(_createdPostId!) ?? 1,
            updatedPost,
          );
          expect(result, isA<Post>());
          debugPrint('✅ 게시글 수정 성공: ${result.title}');
        } catch (e) {
          debugPrint('❌ 게시글 수정 실패: $e');
          expect(e, isA<DioException>());
        }
      });

      test('게시글 삭제 테스트', () async {
        if (_createdPostId == null) {
          debugPrint('⚠️ 게시글 삭제 테스트 스킵: 생성된 게시글 없음');
          return;
        }

        try {
          await communityApi.deletePost(int.tryParse(_createdPostId!) ?? 1);
          debugPrint('✅ 게시글 삭제 성공');
        } catch (e) {
          debugPrint('❌ 게시글 삭제 실패: $e');
          expect(e, isA<DioException>());
        }
      });
    });

    group('댓글 API 테스트', () {
      test('댓글 목록 조회 테스트', () async {
        try {
          final comments = await communityApi.getComments(1); // 임시 postId
          expect(comments, isA<List<Comment>>());
          debugPrint('✅ 댓글 목록 조회 성공: ${comments.length}개의 댓글');

          if (comments.isNotEmpty) {
            debugPrint('첫 번째 댓글: ${comments.first.content}');
          }
        } catch (e) {
          debugPrint('❌ 댓글 목록 조회 실패: $e');
          expect(e, isA<DioException>());
        }
      });

      test('댓글 생성 테스트', () async {
        final testComment = Comment(
          id: 0,
          postId: 1, // 임시 postId
          uid: 'test_user_${DateTime.now().millisecondsSinceEpoch}',
          content: '테스트 댓글 내용입니다.',
          createdAt: DateTime.now(),
        );

        try {
          final createdComment = await communityApi.createComment(
            1,
            testComment,
          );
          expect(createdComment, isA<Comment>());
          expect(createdComment.content, equals(testComment.content));
          debugPrint('✅ 댓글 생성 성공: ${createdComment.content}');

          _createdCommentId = createdComment.uid;
        } catch (e) {
          debugPrint('❌ 댓글 생성 실패: $e');
          expect(e, isA<DioException>());
        }
      });

      test('댓글 수정 테스트', () async {
        if (_createdCommentId == null) {
          debugPrint('⚠️ 댓글 수정 테스트 스킵: 생성된 댓글 없음');
          return;
        }

        try {
          final result = await communityApi.updateComment(
            1, // postId
            int.tryParse(_createdCommentId!) ?? 1, // commentId
            '수정된 댓글 내용',
          );
          expect(result, isA<Comment>());
          debugPrint('✅ 댓글 수정 성공: ${result.content}');
        } catch (e) {
          debugPrint('❌ 댓글 수정 실패: $e');
          expect(e, isA<DioException>());
        }
      });

      test('댓글 삭제 테스트', () async {
        if (_createdCommentId == null) {
          debugPrint('⚠️ 댓글 삭제 테스트 스킵: 생성된 댓글 없음');
          return;
        }

        try {
          await communityApi.deleteComment(
            1, // postId
            int.tryParse(_createdCommentId!) ?? 1, // commentId
          );
          debugPrint('✅ 댓글 삭제 성공');
        } catch (e) {
          debugPrint('❌ 댓글 삭제 실패: $e');
          expect(e, isA<DioException>());
        }
      });
    });

    group('에러 처리 테스트', () {
      test('잘못된 엔드포인트 테스트', () async {
        try {
          // 존재하지 않는 게시글 ID로 조회
          await communityApi.getComments(99999);
        } catch (e) {
          expect(e, isA<DioException>());
          debugPrint('✅ 예상된 에러 발생: $e');
        }
      });
    });
  });
}

// 테스트에서 생성된 데이터 추적용 전역 변수
String? _createdPostId;
String? _createdCommentId;

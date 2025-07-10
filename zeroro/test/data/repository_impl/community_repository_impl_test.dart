import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:zeroro/data/data_source/community.api.dart';
import 'package:zeroro/data/repository_impl/community.repository_impl.dart';
import 'package:zeroro/domain/model/comment/comment.model.dart';
import 'package:zeroro/domain/model/post/post.model.dart';

import 'community_repository_impl_test.mocks.dart';

@GenerateMocks([CommunityApi])
void main() {
  late CommunityRepositoryImpl repository;
  late MockCommunityApi mockApi;

  setUp(() {
    mockApi = MockCommunityApi();
    repository = CommunityRepositoryImpl(mockApi);
  });

  group('CommunityRepositoryImpl', () {
    group('getPosts', () {
      test('성공적으로 게시글 목록을 가져와야 함', () async {
        // Arrange
        const offset = 0;
        final expectedPosts = [
          Post(
            uid: '1',
            content: '테스트 게시글 내용',
            title: '테스트 게시글',
            likeCount: '10',
            createdAt: DateTime(2024, 1, 1),
            userName: '테스트 유저',
          ),
        ];
        when(mockApi.getPosts(offset)).thenAnswer((_) async => expectedPosts);

        // Act
        final result = await repository.getPosts(offset);

        // Assert
        expect(result, equals(expectedPosts));
        verify(mockApi.getPosts(offset)).called(1);
      });

      test('API 호출 실패 시 예외를 발생시켜야 함', () async {
        // Arrange
        const offset = 0;
        when(mockApi.getPosts(offset)).thenThrow(Exception('네트워크 오류'));

        // Act & Assert
        expect(() => repository.getPosts(offset), throwsA(isA<Exception>()));
        verify(mockApi.getPosts(offset)).called(1);
      });
    });

    group('createPost', () {
      test('성공적으로 게시글을 생성해야 함', () async {
        // Arrange
        final newPost = Post(
          uid: '1',
          content: '새 게시글 내용',
          title: '새 게시글',
          likeCount: '0',
          createdAt: DateTime(2024, 1, 1),
          userName: '테스트 유저',
        );
        when(mockApi.createPost(newPost)).thenAnswer((_) async => newPost);

        // Act
        final result = await repository.createPost(newPost);

        // Assert
        expect(result, equals(newPost));
        verify(mockApi.createPost(newPost)).called(1);
      });

      test('게시글 생성 실패 시 예외를 발생시켜야 함', () async {
        // Arrange
        final newPost = Post(
          uid: '1',
          content: '새 게시글 내용',
          title: '새 게시글',
          likeCount: '0',
          createdAt: DateTime(2024, 1, 1),
          userName: '테스트 유저',
        );
        when(mockApi.createPost(newPost)).thenThrow(Exception('서버 오류'));

        // Act & Assert
        expect(() => repository.createPost(newPost), throwsA(isA<Exception>()));
        verify(mockApi.createPost(newPost)).called(1);
      });
    });

    group('updatePost', () {
      test('성공적으로 게시글을 수정해야 함', () async {
        // Arrange
        const postId = 1;
        final updatedPost = Post(
          uid: '1',
          content: '수정된 게시글 내용',
          title: '수정된 게시글',
          likeCount: '5',
          createdAt: DateTime(2024, 1, 1),
          userName: '테스트 유저',
        );
        when(
          mockApi.updatePost(postId, updatedPost),
        ).thenAnswer((_) async => updatedPost);

        // Act
        final result = await repository.updatePost(postId, updatedPost);

        // Assert
        expect(result, equals(updatedPost));
        verify(mockApi.updatePost(postId, updatedPost)).called(1);
      });

      test('게시글 수정 실패 시 예외를 발생시켜야 함', () async {
        // Arrange
        const postId = 1;
        final updatedPost = Post(
          uid: '1',
          content: '수정된 게시글 내용',
          title: '수정된 게시글',
          likeCount: '5',
          createdAt: DateTime(2024, 1, 1),
          userName: '테스트 유저',
        );
        when(
          mockApi.updatePost(postId, updatedPost),
        ).thenThrow(Exception('권한 없음'));

        // Act & Assert
        expect(
          () => repository.updatePost(postId, updatedPost),
          throwsA(isA<Exception>()),
        );
        verify(mockApi.updatePost(postId, updatedPost)).called(1);
      });
    });

    group('deletePost', () {
      test('성공적으로 게시글을 삭제해야 함', () async {
        // Arrange
        const postId = 1;
        when(mockApi.deletePost(postId)).thenAnswer((_) async {});

        // Act
        await repository.deletePost(postId);

        // Assert
        verify(mockApi.deletePost(postId)).called(1);
      });

      test('게시글 삭제 실패 시 예외를 발생시켜야 함', () async {
        // Arrange
        const postId = 1;
        when(mockApi.deletePost(postId)).thenThrow(Exception('삭제 권한 없음'));

        // Act & Assert
        expect(() => repository.deletePost(postId), throwsA(isA<Exception>()));
        verify(mockApi.deletePost(postId)).called(1);
      });
    });

    group('getComments', () {
      test('성공적으로 댓글 목록을 가져와야 함', () async {
        // Arrange
        const postId = 1;
        final expectedComments = [
          Comment(
            postId: postId,
            uid: '1',
            content: '테스트 댓글',
            createdAt: DateTime(2024, 1, 1),
          ),
        ];
        when(
          mockApi.getComments(postId),
        ).thenAnswer((_) async => expectedComments);

        // Act
        final result = await repository.getComments(postId);

        // Assert
        expect(result, equals(expectedComments));
        verify(mockApi.getComments(postId)).called(1);
      });

      test('댓글 목록 가져오기 실패 시 예외를 발생시켜야 함', () async {
        // Arrange
        const postId = 1;
        when(mockApi.getComments(postId)).thenThrow(Exception('네트워크 오류'));

        // Act & Assert
        expect(() => repository.getComments(postId), throwsA(isA<Exception>()));
        verify(mockApi.getComments(postId)).called(1);
      });
    });

    group('createComment', () {
      test('성공적으로 댓글을 생성해야 함', () async {
        // Arrange
        const postId = 1;
        final newComment = Comment(
          postId: postId,
          uid: '1',
          content: '새 댓글',
          createdAt: DateTime(2024, 1, 1),
        );
        when(
          mockApi.createComment(postId, newComment),
        ).thenAnswer((_) async => newComment);

        // Act
        final result = await repository.createComment(postId, newComment);

        // Assert
        expect(result, equals(newComment));
        verify(mockApi.createComment(postId, newComment)).called(1);
      });

      test('댓글 생성 실패 시 예외를 발생시켜야 함', () async {
        // Arrange
        const postId = 1;
        final newComment = Comment(
          postId: postId,
          uid: '1',
          content: '새 댓글',
          createdAt: DateTime(2024, 1, 1),
        );
        when(
          mockApi.createComment(postId, newComment),
        ).thenThrow(Exception('서버 오류'));

        // Act & Assert
        expect(
          () => repository.createComment(postId, newComment),
          throwsA(isA<Exception>()),
        );
        verify(mockApi.createComment(postId, newComment)).called(1);
      });
    });

    group('updateComment', () {
      test('성공적으로 댓글을 수정해야 함', () async {
        // Arrange
        const postId = 1;
        const commentId = 1;
        final updatedComment = Comment(
          postId: postId,
          uid: '1',
          content: '수정된 댓글',
          createdAt: DateTime(2024, 1, 1),
        );
        when(
          mockApi.updateComment(postId, commentId, updatedComment.content),
        ).thenAnswer((_) async => updatedComment);

        // Act
        final result = await repository.updateComment(
          postId,
          commentId,
          updatedComment,
        );

        // Assert
        expect(result, equals(updatedComment));
        verify(
          mockApi.updateComment(postId, commentId, updatedComment.content),
        ).called(1);
      });

      test('댓글 수정 실패 시 예외를 발생시켜야 함', () async {
        // Arrange
        const postId = 1;
        const commentId = 1;
        final updatedComment = Comment(
          postId: postId,
          uid: '1',
          content: '수정된 댓글',
          createdAt: DateTime(2024, 1, 1),
        );
        when(
          mockApi.updateComment(postId, commentId, updatedComment.content),
        ).thenThrow(Exception('권한 없음'));

        // Act & Assert
        expect(
          () => repository.updateComment(postId, commentId, updatedComment),
          throwsA(isA<Exception>()),
        );
        verify(
          mockApi.updateComment(postId, commentId, updatedComment.content),
        ).called(1);
      });
    });

    group('deleteComment', () {
      test('성공적으로 댓글을 삭제해야 함', () async {
        // Arrange
        const postId = 1;
        const commentId = 1;
        when(mockApi.deleteComment(postId, commentId)).thenAnswer((_) async {});

        // Act
        await repository.deleteComment(postId, commentId);

        // Assert
        verify(mockApi.deleteComment(postId, commentId)).called(1);
      });

      test('댓글 삭제 실패 시 예외를 발생시켜야 함', () async {
        // Arrange
        const postId = 1;
        const commentId = 1;
        when(
          mockApi.deleteComment(postId, commentId),
        ).thenThrow(Exception('삭제 권한 없음'));

        // Act & Assert
        expect(
          () => repository.deleteComment(postId, commentId),
          throwsA(isA<Exception>()),
        );
        verify(mockApi.deleteComment(postId, commentId)).called(1);
      });
    });
  });
}

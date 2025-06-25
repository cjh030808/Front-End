// TODO: Domain Layer 구현 시, Freezed 클래스로 바꿀 것
// Mock Data class
class User {
  final String name;
  final int score;

  User(this.name, this.score);
}

final List<User> mockUsers = List.generate(50, (index) => User('유저 ${index + 1}', 1000 - (index * 10)));

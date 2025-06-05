class User {
  int id;
  String name;

  User({
    required this.id,
    required this.name,
  });
}

List<User> dummyUser = [
  User(
    id: 1,
    name: "John Doe",
  ),
  User(
    id: 2,
    name: "Jesso",
  ),
];

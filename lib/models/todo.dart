class Todo {
  String id;
  String title;
  String dueDate;
  String status;
  String user;

  Todo({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.status,
    required this.user,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      dueDate: json['dueDate'],
      status: json['status'],
      user: json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'dueDate': dueDate,
      'status': status,
      'user': user,
    };
  }
}

List<Todo> initialTodo = [
  Todo(
    id: "1",
    title: "Submit Code to Taksu",
    dueDate: "21 October 2021 07:30PM",
    status: "OPEN",
    user: "John Doe",
  ),
  Todo(
    id: "2",
    title: "Interview with Taksu",
    dueDate: "21 October 2021 07:30PM",
    status: "DONE",
    user: "John Doe",
  ),
  Todo(
    id: "3",
    title: "Interview with Taksu",
    dueDate: "21 October 2021 07:30PM",
    status: "OVERDUE",
    user: "John Doe",
  ),
  Todo(
    id: "4",
    title: "Interview with Taksu",
    dueDate: "21 October 2021 07:30PM",
    status: "OVERDUE",
    user: "Jesso",
  ),
];

class Task {
  String title;
  String description;
  DateTime dueDate;
  bool isCompleted;

  Task({required this.title, required this.description, required this.dueDate, required this.isCompleted});

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'dueDate': dueDate.toIso8601String(),
    'isCompleted': isCompleted,
  };

  static Task fromJson(Map<String, dynamic> json) => Task(
    title: json['title'],
    description: json['description'],
    dueDate: DateTime.parse(json['dueDate']),
    isCompleted: json['isCompleted'],
  );
}

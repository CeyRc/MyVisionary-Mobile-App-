class TaskModel {

  final String id;
  final String title;
  final bool completed;

  TaskModel({
    required this.id,
    required this.title,
    required this.completed,
  });

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "completed": completed,
    };
  }

  factory TaskModel.fromMap(String id, Map<String, dynamic> data) {
    return TaskModel(
      id: id,
      title: data["title"] ?? "",
      completed: data["completed"] ?? false,
    );
  }
}
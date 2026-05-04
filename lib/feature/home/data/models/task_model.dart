class TaskModel {
  final int id ;
  final String taskName;
  final String? taskDescription;
  final bool isHighPriority;
   bool? isDone = false;

  TaskModel({
    required this.taskName,
    required this.taskDescription,
    required this.isHighPriority,
     this.isDone,
     required this.id ,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      taskName: json['taskName'],
      id: json['id'] ?? 0,
      taskDescription: json['taskDescription'],
      isHighPriority: json['isHighPriority'],
      isDone : json['isDone'],
       
    );
  }

Map <String , dynamic> toMap() => {
      'taskName': taskName,
      'id': id,
      'taskDescription': taskDescription,
      'isHighPriority': isHighPriority,
      'isDone' : isDone
    };
}

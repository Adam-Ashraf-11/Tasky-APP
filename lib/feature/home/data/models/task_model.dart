class TaskModel {
  final String taskName;
  final String? taskDescription;
  final bool isHighPriority;
   bool? isDone = false;

  TaskModel({
    required this.taskName,
    required this.taskDescription,
    required this.isHighPriority,
     this.isDone ,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      taskName: json['taskName'],
      taskDescription: json['taskDescription'],
      isHighPriority: json['isHighPriority'],
      isDone : json['isDone'],
       
    );
  }

Map <String , dynamic> toMap() => {
      'taskName': taskName,
      'taskDescription': taskDescription,
      'isHighPriority': isHighPriority,
      'isDone' : isDone
    };
}

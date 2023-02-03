// ignore_for_file: non_constant_identifier_names
class CreateDescribtionDto {
  String description;
  int taskId;

  // Data transfer object
  CreateDescribtionDto({required this.taskId, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'description': description,
    };
  }

  factory CreateDescribtionDto.fromMap(Map<dynamic, dynamic> data) {
    return CreateDescribtionDto(
      taskId: data["taskId"],
      description: data["description"],
    );
  }
}

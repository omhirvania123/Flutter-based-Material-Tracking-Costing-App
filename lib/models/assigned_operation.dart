class AssignedOperation {
  String operationName;
  String materialName;
  String description;
  String status; // 'Pending', 'In Progress', 'Completed'
  DateTime assignedAt;

  AssignedOperation({
    required this.operationName,
    required this.materialName,
    required this.description,
    required this.status,
    required this.assignedAt,
  });
}
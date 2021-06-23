class Plan {
  Plan(this.task, this.dueDate);
  String task;
  DateTime dueDate;

  @override
  String toString() {
    return '$task\n${dueDate.toString()}\n\n';
  }
}

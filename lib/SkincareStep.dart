class SkincareStep {
  final String? name;
  final String? subname;
  final DateTime? completionTime;
  final bool completed;

  SkincareStep({
    required this.name,
    required this.subname,
    required this.completionTime,
    this.completed = false,
  });

  SkincareStep copyWith({bool? completed, DateTime? completionTime}) {
    return SkincareStep(
      name: name ?? "",
      subname: subname ?? "",
      completionTime: completionTime ?? this.completionTime,
      completed: completed ?? this.completed,
    );
  }

  SkincareStep reset() {
    return SkincareStep(
      name: name,
      subname: subname,
      completionTime: completionTime,
      completed: false,
    );
  }
}

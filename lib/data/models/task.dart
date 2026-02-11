import 'package:isar/isar.dart';

part 'task.g.dart';

@collection
class Task {
  Id id = Isar.autoIncrement;
  late String title;
  String? description;

  @Index()
  late DateTime createdAt;

  @Index()
  DateTime? dueDate;

  String? dueTime;

  @Index()
  bool completed = false;

  DateTime? completedAt;

  @Enumerated(EnumType.name)
  TaskCategory category = TaskCategory.personal;

  bool hasReminder = false;
  int? reminderMinutesBefore;
}

enum TaskCategory { work, personal, health, spiritual, learning }

extension TaskCategoryExtension on TaskCategory {
  String get displayName {
    switch (this) {
      case TaskCategory.work: return 'Work';
      case TaskCategory.personal: return 'Personal';
      case TaskCategory.health: return 'Health';
      case TaskCategory.spiritual: return 'Spiritual';
      case TaskCategory.learning: return 'Learning';
    }
  }
}
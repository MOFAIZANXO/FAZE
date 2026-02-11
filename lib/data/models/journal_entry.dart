import 'package:isar/isar.dart';

part 'journal_entry.g.dart';

@collection
class JournalEntry {
  Id id = Isar.autoIncrement;

  @Index()
  late DateTime date;

  // Mental Win
  String? mentalActivity;
  String? mentalActivityType;
  int mentalRating = 3;

  // Physical Win
  List<String> physicalActivities = [];
  int energyLevel = 5;

  // Spiritual Win
  List<String> spiritualActivities = [];
  List<String> gratitudeList = [];
  bool prayersCompleted = false;

  // Accountability Win
  String? strengthDemonstrated;
  String? lessonLearned;
  String? tomorrowIntention;
  int dailyRating = 5;

  bool get isComplete =>
      mentalActivity != null &&
      physicalActivities.isNotEmpty &&
      gratitudeList.isNotEmpty &&
      lessonLearned != null;

  late DateTime createdAt;
  late DateTime updatedAt;
}
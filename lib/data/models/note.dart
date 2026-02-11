import 'package:isar/isar.dart';

part 'note.g.dart';

@collection
class Note {
  Id id = Isar.autoIncrement;
  late String content;

  @Index()
  late DateTime createdAt;

  DateTime? updatedAt;
  bool isPinned = false;
  List<String> tags = [];
}
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/task.dart';
import '../models/prayer_log.dart';
import '../models/journal_entry.dart';
import '../models/hydration_log.dart';
import '../models/note.dart';

class DatabaseService {
  static late Isar _isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [
        TaskSchema,
        PrayerLogSchema,
        JournalEntrySchema,
        HydrationLogSchema,
        NoteSchema,
      ],
      directory: dir.path,
    );
  }

  static Isar get instance => _isar;
}
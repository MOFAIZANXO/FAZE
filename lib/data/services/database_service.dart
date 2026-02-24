import 'dart:async';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:faze/data/models/task.dart';
import 'package:faze/data/models/prayer_log.dart';
import 'package:faze/data/models/journal_entry.dart';
import 'package:faze/data/models/hydration_log.dart';
import 'package:faze/data/models/note.dart';

class DatabaseService {
  static Isar? _isar;
  static final Completer<Isar> _completer = Completer<Isar>();

  static Future<void> initialize() async {
    if (_isar != null) return;
    
    try {
      final dir = await getApplicationDocumentsDirectory();
      final isar = await Isar.open(
        [
          TaskSchema,
          PrayerLogSchema,
          JournalEntrySchema,
          HydrationLogSchema,
          NoteSchema,
        ],
        directory: dir.path,
      );
      _isar = isar;
      if (!_completer.isCompleted) {
        _completer.complete(isar);
      }
      debugPrint('DatabaseService: Isar initialized successfully.');
    } catch (e) {
      debugPrint('DatabaseService: Initialization error: $e');
      if (!_completer.isCompleted) {
        _completer.completeError(e);
      }
      rethrow;
    }
  }

  /// Get the Isar instance, waiting for it to be ready if necessary
  static Future<Isar> getIsar() async {
    if (_isar != null) return _isar!;
    return _completer.future.timeout(
      const Duration(seconds: 5),
      onTimeout: () => throw TimeoutException('Database initialization timed out'),
    );
  }

  /// Synchronous access (will throw if not initialized)
  static Isar get instance {
    if (_isar == null) {
      throw StateError('DatabaseService accessed before initialization. Call initialize() first.');
    }
    return _isar!;
  }
}
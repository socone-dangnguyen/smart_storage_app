import 'package:smart_storage/configs/db/db_connection.dart';
import 'package:smart_storage/models/note.dart';

class NoteRepository {
  final DatabaseConnection _dbConnection = DatabaseConnection();

  // Thêm ghi chú mới
  Future<int> addNote({
    required String hashTag,
    required String url,
    required String summarize,
    required String sence,
  }) async {
    final db = await _dbConnection.database;
    Map<String, dynamic> note = {
      'hash_tag': hashTag,
      'url': url,
      'summarize': summarize,
      'sence': sence,
      'created_at': DateTime.now().toIso8601String(),
    };
    return await db.insert('notes', note);
  }

  // Lấy tất cả ghi chú
  Future<List<Note>> getNotes() async {
    final db = await _dbConnection.database;
    final List<Map<String, dynamic>> maps = await db.query('notes');

    return List.generate(maps.length, (i) {
      return Note.fromMap(maps[i]);
    });
  }

  // Lấy ghi chú theo id
  Future<Note?> getNoteById(int id) async {
    final db = await _dbConnection.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );

    return maps.isNotEmpty ? Note.fromMap(maps.first) : null;
  }

  // Xóa ghi chú theo id
  Future<int> deleteNote(int id) async {
    final db = await _dbConnection.database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  // Cập nhật ghi chú theo id
  Future<int> updateNote({
    required int id,
    String? hashTag,
    String? url,
    String? summarize,
    String? sence,
  }) async {
    final db = await _dbConnection.database;
    Map<String, dynamic> updatedNote = {
      if (hashTag != null) 'hash_tag': hashTag,
      if (url != null) 'url': url,
      if (summarize != null) 'summarize': summarize,
      if (sence != null) 'sence': sence,
      'updated_at': DateTime.now().toIso8601String(),
    };

    return await db.update(
      'notes',
      updatedNote,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Lấy ghi chú theo hash tag
  Future<List<Note>> getNotesByHashTag(String hashTag) async {
    final db = await _dbConnection.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'notes',
      where: 'hash_tag = ?',
      whereArgs: [hashTag],
    );

    return List.generate(maps.length, (i) {
      return Note.fromMap(maps[i]);
    });
  }
}

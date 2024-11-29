import 'package:flutter/material.dart';
import 'package:smart_storage/models/note.dart';
import 'package:smart_storage/repository/note_repository.dart';

class NoteProvider with ChangeNotifier {
  final NoteRepository _noteRepository = NoteRepository();
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  // Hàm tải tất cả ghi chú
  Future<void> loadNotes() async {
    _notes = await _noteRepository.getNotes();
    notifyListeners(); // Cập nhật UI khi danh sách ghi chú thay đổi
  }

  // Hàm thêm ghi chú mới
  Future<void> addNote({
    required String hashTag,
    required String url,
    required String summarize,
    required String sence,
  }) async {
    await _noteRepository.addNote(
      hashTag: hashTag,
      url: url,
      summarize: summarize,
      sence: sence,
    );
    await loadNotes(); // Tải lại ghi chú sau khi thêm mới
  }

  // Hàm xóa ghi chú
  Future<void> deleteNote(int id) async {
    await _noteRepository.deleteNote(id);
    await loadNotes(); // Tải lại ghi chú sau khi xóa
  }

  Future<void> updateNote({
    required int id,
    String? hashTag,
    String? url,
    String? summarize,
    String? sence,
  }) async {
    await _noteRepository.updateNote(
      id: id,
      hashTag: hashTag,
      url: url,
      summarize: summarize,
      sence: sence,
    );
    await loadNotes(); // Tải lại ghi chú sau khi cập nhật
  }
}

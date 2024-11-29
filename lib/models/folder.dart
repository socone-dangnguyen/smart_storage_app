import 'package:smart_storage/models/note.dart';

class Folder {
  int? id;
  String name;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Note>? notes;

  Folder({
    this.id,
    required this.name,
    this.createdAt,
    this.updatedAt,
  });

  // Chuyển đổi đối tượng Folder thành Map để lưu vào cơ sở dữ liệu
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  // Tạo một đối tượng Folder từ Map (ví dụ, từ cơ sở dữ liệu)
  factory Folder.fromMap(Map<String, dynamic> map) {
    return Folder(
      id: map['id'],
      name: map['name'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }
}

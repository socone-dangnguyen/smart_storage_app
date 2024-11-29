import 'package:smart_storage/configs/db/db_connection.dart';
import 'package:smart_storage/models/folder.dart';

class FolderRepository {
  final DatabaseConnection _dbConnection = DatabaseConnection();

  // Thêm thư mục mới
  Future<int> addFolder(String nameFolder) async {
    final db = await _dbConnection.database;
    Map<String, dynamic> folder = {
      'name': nameFolder,
      'created_at': DateTime.now().toIso8601String(),
    };
    return await db.insert('folders', folder);
  }

  // Lấy tất cả thư mục
  Future<List<Folder>> getFolders() async {
    final db = await _dbConnection.database;
    final List<Map<String, dynamic>> maps = await db.query('folders');

    return List.generate(maps.length, (i) {
      return Folder.fromMap(maps[i]);
    });
  }

  // Xóa thư mục theo id
  Future<int> deleteFolder(int id) async {
    final db = await _dbConnection.database;
    return await db.delete('folders', where: 'id = ?', whereArgs: [id]);
  }

  // Cập nhật tên thư mục theo id
  Future<int> updateFolderName(int folderId, String newName) async {
    final db = await _dbConnection.database;
    Map<String, dynamic> updatedFolder = {
      'name': newName,
      'updated_at': DateTime.now().toIso8601String(),
    };
    return await db.update(
      'folders',
      updatedFolder,
      where: 'id = ?',
      whereArgs: [folderId],
    );
  }
}

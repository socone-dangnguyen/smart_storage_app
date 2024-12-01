import 'package:flutter/material.dart';
import 'package:smart_storage/models/folder.dart';
import 'package:smart_storage/repository/folder_repository.dart';

class FolderProvider with ChangeNotifier {
  final FolderRepository _folderRepository = FolderRepository();
  List<Folder> _folders = [];

  List<Folder> get folders => _folders;

  // Hàm tải tất cả thư mục
  Future loadFolders() async {
    _folders = await _folderRepository.getFolders();
    notifyListeners(); // Cập nhật UI khi danh sách thư mục thay đổi
  }

  // Hàm thêm thư mục mới
  Future addFolder(String nameFolder) async {
    await _folderRepository.addFolder(nameFolder);
    await loadFolders(); // Tải lại thư mục sau khi thêm mới
  }

  // Hàm xóa thư mục
  Future deleteFolder(int id) async {
    await _folderRepository.deleteFolder(id);
    await loadFolders(); // Tải lại thư mục sau khi xóa
  }

  // Hàm cập nhật tên thư mục
  Future updateFolderName(int folderId, String newName) async {
    await _folderRepository.updateFolderName(folderId, newName);
    await loadFolders(); // Tải lại thư mục sau khi cập nhật
  }
}

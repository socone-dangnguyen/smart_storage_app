import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_storage/constants.dart';
import 'package:smart_storage/pages/folder_page/folderPage.dart';
import 'package:smart_storage/pages/note/note_detail.dart';
import 'package:smart_storage/provider/note_provider.dart';
import 'package:smart_storage/widgets/search_plugin.dart';

class mainPage extends StatefulWidget {
  final Function(int) onItemSelected;

  const mainPage({super.key, required this.onItemSelected});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  bool isPending = false;

  @override
  void initState() {
    super.initState();
    // Tải danh sách ghi chú khi màn hình được mở
    Provider.of<NoteProvider>(context, listen: false).loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    // Consumer để theo dõi sự thay đổi của NoteProvider
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NoteGridView(
          maxCrossAxisExtent: 250,
          childAspectRatio: 0.65,
        ),
      ),
    );
  }
}

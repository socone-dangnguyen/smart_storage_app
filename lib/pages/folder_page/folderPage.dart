import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_storage/constants.dart';
import 'package:smart_storage/models/folder.dart';
import 'package:smart_storage/pages/note/note_detail.dart';
import 'package:smart_storage/provider/note_provider.dart';
import 'package:smart_storage/provider/folder_provider.dart'; // Thêm import FolderProvider
import 'package:smart_storage/widgets/search_plugin.dart';

class FolderPage extends StatefulWidget {
  const FolderPage({super.key});

  @override
  State<FolderPage> createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  final TextEditingController _folderController = TextEditingController();
  List<Folder> folders = [];

  @override
  void initState() {
    super.initState();
    folders = [];
    _loadFolders();
  }

  Future<void> _loadFolders() async {
    // Tải dữ liệu từ FolderProvider
    List<Folder>? folderList =
        await Provider.of<FolderProvider>(context, listen: false).loadFolders();

    setState(() {
      folders = folderList != null
          ? folderList
          : []; // Nếu folderList là null, gán danh sách trống
    });
  }

  void _showInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Folder'),
          content: TextField(
            controller: _folderController,
            decoration: InputDecoration(hintText: "Enter folder name"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () async {
                String nameFolder = _folderController.text;
                await Provider.of<FolderProvider>(context, listen: false)
                    .addFolder(nameFolder);
                setState(() {
                  folders.add(Folder(name: nameFolder));
                });
                _folderController.clear();
                Navigator.pop(context);
              },
              child: Text('OK', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarPlugin(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(Constants.kPadding / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: Constants.kPadding, bottom: Constants.kPadding),
                child: Row(
                  children: [
                    Text(
                      'All Folders',
                      style: TextStyle(
                        fontSize: Constants.kSizeTitle * 1.5,
                        fontWeight: Constants.kWeightTitle,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _showInputDialog(context);
                      },
                      icon: Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              FolderGridView(),
              Padding(
                padding: const EdgeInsets.only(
                    left: Constants.kPadding, bottom: Constants.kPadding),
                child: const Text(
                  'Notes',
                  style: TextStyle(
                    fontSize: Constants.kSizeTitle * 1.5,
                    fontWeight: Constants.kWeightTitle,
                    color: Colors.black,
                  ),
                ),
              ),
              NoteGridView(
                maxCrossAxisExtent: 250,
                childAspectRatio: 0.65,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FolderGridView extends StatefulWidget {
  @override
  State<FolderGridView> createState() => _FolderGridViewState();
}

class _FolderGridViewState extends State<FolderGridView> {
  final TextEditingController _folderController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<FolderProvider>(context, listen: false).loadFolders();
  }

  void _showRenameDialog(
      BuildContext context, int folderId, String currentName) {
    _folderController.text =
        currentName; // Set the current name in the text controller

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Rename Folder'),
          content: TextField(
            controller: _folderController,
            decoration: InputDecoration(hintText: "Enter new folder name"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () async {
                String newFolderName = _folderController.text;
                if (newFolderName.isNotEmpty) {
                  await Provider.of<FolderProvider>(context, listen: false)
                      .updateFolderName(
                          folderId, newFolderName); // Update folder name
                  setState(() {
                    // Update the folder name in the UI
                    int index =
                        Provider.of<FolderProvider>(context, listen: false)
                            .folders
                            .indexWhere((folder) => folder.id == folderId);
                    if (index != -1) {
                      Provider.of<FolderProvider>(context, listen: false)
                          .folders[index]
                          .name = newFolderName;
                    }
                  });
                }
                _folderController.clear();
                Navigator.pop(context);
              },
              child: Text('OK', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Lấy danh sách thư mục từ FolderProvider

    return Consumer<FolderProvider>(builder: (context, folderProvider, child) {
      return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          crossAxisSpacing: Constants.kPadding / 2,
          mainAxisSpacing: Constants.kPadding / 2,
          childAspectRatio: 0.8,
        ),
        itemCount: folderProvider.folders.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(Constants.kPadding * 2 / 3),
            child: GestureDetector(
              onLongPressStart: (details) {
                _showPopupMenu(
                    context,
                    details.globalPosition,
                    folderProvider.folders[index].id!.toInt(),
                    folderProvider.folders[index].name);
              },
              child: InkWell(
                onTap: () {
                  print("Tapped on ${folderProvider.folders[index].name}");
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.folder,
                              size: 80,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(Constants.kPadding * 2 / 3),
                      child: Flexible(
                        child: Text(
                          folderProvider.folders[index].name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: Constants.kSizeTitle,
                            fontWeight: Constants.kWeightTitle,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  void _showPopupMenu(
      BuildContext context, Offset position, int id, String folderName) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
          position.dx, position.dy, position.dx, position.dy),
      items: [
        PopupMenuItem(
          value: 'rename',
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text('Rename Folder'),
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete Folder'),
          ),
        ),
        PopupMenuItem(
          value: 'add_file',
          child: ListTile(
            leading: Icon(Icons.add),
            title: Text('Add File'),
          ),
        ),
      ],
    ).then((value) {
      if (value != null) {
        switch (value) {
          case 'rename':
            _showRenameDialog(context, id, folderName);
            break;
          case 'delete':
            Provider.of<FolderProvider>(context, listen: false)
                .deleteFolder(id);
            break;
          // case 'add_file':
          //   _showAddFileDialog(context, folderName);
          //   break;
        }
      }
    });
  }
}

class NoteGridView extends StatefulWidget {
  final double maxCrossAxisExtent;
  final double childAspectRatio;
  NoteGridView({
    required this.maxCrossAxisExtent,
    required this.childAspectRatio,
  });

  @override
  State<NoteGridView> createState() => _NoteGridViewState();
}

class _NoteGridViewState extends State<NoteGridView> {
  final TextEditingController _hashTagController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _summarizeController = TextEditingController();
  final TextEditingController _senceController = TextEditingController();
  void _showRenameDialog(BuildContext context, int nodeId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Rename Note'),
          content: Container(
            height: 200,
            width: 300,
            child: Column(
              children: [
                TextField(
                  controller: _hashTagController,
                  decoration:
                      InputDecoration(hintText: "Enter new hashTag name"),
                ),
                TextField(
                  controller: _urlController,
                  decoration: InputDecoration(hintText: "Enter new url name"),
                ),
                TextField(
                  controller: _summarizeController,
                  decoration:
                      InputDecoration(hintText: "Enter new summarize name"),
                ),
                TextField(
                  controller: _senceController,
                  decoration: InputDecoration(hintText: "Enter new sense name"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () async {
                String hashTag = _hashTagController.text;
                String url = _urlController.text;
                String summarize = _summarizeController.text;
                String sence = _senceController.text;
                if (hashTag.isEmpty &&
                    url.isEmpty &&
                    summarize.isEmpty &&
                    sence.isEmpty) {
                  return;
                }
                await Provider.of<NoteProvider>(context, listen: false)
                    .updateNote(
                        id: nodeId,
                        hashTag: hashTag,
                        url: url,
                        summarize: summarize,
                        sence: sence);
                _hashTagController.clear();
                _urlController.clear();
                _summarizeController.clear();
                _senceController.clear();
                Navigator.pop(context);
              },
              child: Text('OK', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(builder: (context, noteProvider, child) {
      return GridView.builder(
        shrinkWrap: true,
        physics:
            NeverScrollableScrollPhysics(), // Vô hiệu hóa cuộn riêng của GridView
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: widget.maxCrossAxisExtent,
          crossAxisSpacing: Constants.kPadding / 2,
          mainAxisSpacing: Constants.kPadding,
          childAspectRatio: widget.childAspectRatio,
        ),
        itemCount:
            noteProvider.notes.length, // Dùng số lượng ghi chú trong danh sách
        itemBuilder: (context, index) {
          final note = noteProvider.notes[index]; // Lấy ghi chú tại index

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NoteDetail(note: note),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white, // Màu nền
                    borderRadius: BorderRadius.circular(Constants.kBorder),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.1),
                      width: 1,
                    ) // Bo góc
                    ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Tiêu đề
                      // Hình ảnh
                      SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: Image.network(
                          'https://picsum.photos/300/300?random=$index',
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Tóm tắt ghi chú

                      Text(
                        '#${note.hashTag}', // Hiển thị hashTag
                        style: TextStyle(
                          fontSize: Constants.kSizeTitle,
                          fontWeight: Constants.kWeightTitle,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Url: ${note.url}', // Hiển thị hashTag
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "Summarize: ${note.summarize}",
                          style: TextStyle(
                            fontSize: Constants.kSizeBody,
                            fontWeight: Constants.kWeightBody,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      // Cảm nhận ghi chú
                      Flexible(
                        child: Text(
                          "Sence: ${note.sence}",
                          style: TextStyle(
                            fontSize: Constants.kSizeBody,
                            fontWeight: Constants.kWeightBody,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      // Các biểu tượng và nút xoá
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.favorite_border,
                                    color: Colors.red),
                                onPressed: () {
                                  print('Love icon pressed for note #$index');
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.share_rounded,
                                    color: Colors.blue),
                                onPressed: () {
                                  print('Share icon pressed for note #$index');
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.drive_file_move_rounded,
                                    color: Colors.green),
                                onPressed: () {
                                  print('Move icon pressed for note #$index');
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.grey),
                                onPressed: () {
                                  _hashTagController.text = note.hashTag;
                                  _urlController.text = note.url;
                                  _summarizeController.text = note.summarize;
                                  _senceController.text = note.sence;
                                  _showRenameDialog(context, note.id!);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete_outline,
                                    color: Colors.black),
                                onPressed: () async {
                                  // Gọi phương thức xóa ghi chú từ NoteProvider
                                  await Provider.of<NoteProvider>(context,
                                          listen: false)
                                      .deleteNote(note.id!); // Xóa ghi chú
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}

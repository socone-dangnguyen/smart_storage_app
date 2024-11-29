import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_storage/constants.dart';
import 'package:smart_storage/models/folder.dart';
import 'package:smart_storage/pages/note/note_detail.dart';
import 'package:smart_storage/provider/note_provider.dart';
import 'package:smart_storage/repository/folder_repository.dart';
import 'package:smart_storage/widgets/search_plugin.dart';

class folderPage extends StatefulWidget {
  const folderPage({super.key});

  @override
  State<folderPage> createState() => _folderPageState();
}

class _folderPageState extends State<folderPage> {
  final TextEditingController _folderController = TextEditingController();
  final FolderRepository _folderRepository = FolderRepository();
  late List<Folder> folders;
  @override
  void initState() {
    super.initState();
    folders = [];
    _loadFolders();
  }

  Future<void> _loadFolders() async {
    // Tải dữ liệu từ repository
    List<Folder> loadedFolders = await _folderRepository.getFolders();
    setState(() {
      folders = loadedFolders;
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
            controller:
                _folderController, // Use the controller to get the input text
            decoration: InputDecoration(hintText: "Enter folder name"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () async {
                // Handle the text input when the "OK" button is pressed
                String nameFolder = _folderController.text;
                await _folderRepository.addFolder(nameFolder);
                setState(() {
                  folders.add(Folder(name: nameFolder));
                });
                _folderController.clear(); // You can handle it as needed
                Navigator.pop(context); // Close the dialog
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.black),
              ),
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
                    )
                  ],
                ),
              ),
              // Sử dụng widget FolderGridView riêng biệt
              FolderGridView(
                folders: folders,
              ),
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
              // GridView bên trong SingleChildScrollView
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

class FolderGridView extends StatelessWidget {
// Controller to manage text input
  final List<Folder> folders;
  const FolderGridView({required this.folders});
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
        crossAxisSpacing: Constants.kPadding / 2,
        mainAxisSpacing: Constants.kPadding / 2,
        childAspectRatio: 0.8,
      ),
      itemCount: folders.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(Constants.kPadding * 2 / 3),
          child: GestureDetector(
            onLongPressStart: (details) {
              // Hiển thị menu popup tại vị trí nhấn giữ
              _showPopupMenu(
                  context, details.globalPosition, folders[index].name);
            },
            child: InkWell(
              onTap: () {
                print("Tapped on ${folders[index].name}");
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
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                '0',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(Constants.kPadding * 2 / 3),
                    child: Flexible(
                      child: Text(
                        folders[index].name,
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
  }

  void _showPopupMenu(
      BuildContext context, Offset position, String folderName) {
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
            print('Renaming $folderName');
            break;
          case 'delete':
            print('Deleting $folderName');
            break;
          case 'add_file':
            _showAddFileDialog(context, folderName);
            break;
        }
      }
    });
  }

  void _showAddFileDialog(BuildContext context, String folderName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Lấy độ rộng của màn hình
        double screenWidth = MediaQuery.of(context).size.width;
        return AlertDialog(
          title: Text('Select File to Add to $folderName'),
          content: Container(
            width:
                screenWidth * 0.9, // Đặt độ rộng container là 90% của màn hình
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: NoteGridView(
                maxCrossAxisExtent: 300,
                childAspectRatio: 1,
              ), // Hiển thị NoteGridView
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
              },
              child: Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                // Thực hiện thêm file vào thư mục
                print('Adding selected file to $folderName');
                Navigator.of(context).pop(); // Đóng dialog sau khi thêm file
              },
              child: Text('Add File'),
            ),
          ],
        );
      },
    );
  }
}

class NoteGridView extends StatelessWidget {
  final double maxCrossAxisExtent;
  final double childAspectRatio;

  NoteGridView({
    required this.maxCrossAxisExtent,
    required this.childAspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    // Lấy danh sách ghi chú từ NoteProvider
    final notes = Provider.of<NoteProvider>(context).notes;

    return GridView.builder(
      shrinkWrap: true,
      physics:
          NeverScrollableScrollPhysics(), // Vô hiệu hóa cuộn riêng của GridView
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: maxCrossAxisExtent,
        crossAxisSpacing: Constants.kPadding / 2,
        mainAxisSpacing: Constants.kPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: notes.length, // Dùng số lượng ghi chú trong danh sách
      itemBuilder: (context, index) {
        final note = notes[index]; // Lấy ghi chú tại index

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
                borderRadius:
                    BorderRadius.circular(Constants.kBorder), // Bo góc
              ),
              child: Padding(
                padding: const EdgeInsets.all(Constants.kPadding * 2 / 3),
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
                              icon:
                                  Icon(Icons.share_rounded, color: Colors.blue),
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
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.delete_outline, color: Colors.black),
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
              ),
            ),
          ),
        );
      },
    );
  }
}

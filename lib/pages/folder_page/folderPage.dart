import 'package:flutter/material.dart';
import 'package:smart_storage/constants.dart';
import 'package:smart_storage/widgets/search_plugin.dart';

class folderPage extends StatefulWidget {
  const folderPage({super.key});

  @override
  State<folderPage> createState() => _folderPageState();
}

class _folderPageState extends State<folderPage> {
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
                      onPressed: () {},
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
  final TextEditingController _controller =
      TextEditingController(); // Controller to manage text input

  final List<String> folderNames = [
    "Documents",
    "Photos",
    "Music",
    "Videos",
    "Projects",
    "Downloads",
    "Work",
    "Personal"
  ];
  void _showInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter your text'),
          content: TextField(
            controller: _controller, // Use the controller to get the input text
            decoration: InputDecoration(hintText: "Type something"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Handle the text input when the "OK" button is pressed
                String inputText = _controller.text;
                print('User input: $inputText'); // You can handle it as needed
                Navigator.pop(context); // Close the dialog
              },
              child: Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

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
      itemCount: folderNames.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(Constants.kPadding * 2 / 3),
          child: GestureDetector(
            onLongPressStart: (details) {
              // Hiển thị menu popup tại vị trí nhấn giữ
              _showPopupMenu(
                  context, details.globalPosition, folderNames[index]);
            },
            child: InkWell(
              onTap: () {
                print("Tapped on ${folderNames[index]}");
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
                                '5',
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
                        folderNames[index],
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
  final double maxCrossAxisExtent; // Thêm thuộc tính cho maxCrossAxisExtent
  final double childAspectRatio; // Thêm thuộc tính cho maxCrossAxisExtent

  // Khởi tạo với tham số maxCrossAxisExtent
  NoteGridView(
      {required this.maxCrossAxisExtent, required this.childAspectRatio});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics:
          NeverScrollableScrollPhysics(), // Vô hiệu hóa cuộn riêng của GridView
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: maxCrossAxisExtent, // Sử dụng thuộc tính này
        crossAxisSpacing: Constants.kPadding / 2,
        mainAxisSpacing: Constants.kPadding,
        childAspectRatio:
            childAspectRatio, // Điều chỉnh chiều cao tương ứng với chiều rộng
      ),
      itemCount: 100, // Số lượng item trong grid
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(Constants.kPadding * 2 / 3),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white, // Màu nền
              borderRadius: BorderRadius.circular(Constants.kBorder), // Bo góc
            ),
            child: Padding(
              padding: const EdgeInsets.all(Constants.kPadding * 2 / 3),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Item $index',
                    style: TextStyle(
                      fontSize: Constants.kSizeTitle,
                      fontWeight: Constants.kWeightTitle,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 100, // Chiều cao cố định cho hình ảnh
                    width: double
                        .infinity, // Làm cho hình ảnh chiếm toàn bộ chiều rộng
                    child: Image.network(
                      'https://picsum.photos/300/300?random=$index',
                      fit: BoxFit.cover, // Làm cho hình ảnh bao phủ container
                    ),
                  ),
                  Flexible(
                    child: Text(
                      '#Hashtag1, #Hashtag2',
                      style: TextStyle(
                        fontSize: Constants.kSizeBody,
                        fontWeight: Constants.kWeightBody,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      'Keyword: Keyword1, Keyword2, Keyword3',
                      style: TextStyle(
                        fontSize: Constants.kSizeBody,
                        fontWeight: Constants.kWeightBody,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon:
                                Icon(Icons.favorite_border, color: Colors.red),
                            onPressed: () {
                              print('Love icon pressed for image #$index');
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.share_rounded, color: Colors.blue),
                            onPressed: () {
                              print('Share icon pressed for image #$index');
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.drive_file_move_rounded,
                                color: Colors.green),
                            onPressed: () {
                              print('Move icon pressed for image #$index');
                            },
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.delete_outline, color: Colors.black),
                        onPressed: () {
                          print('Delete icon pressed for image #$index');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

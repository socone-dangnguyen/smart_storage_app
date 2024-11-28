import 'package:flutter/material.dart';
import 'package:smart_storage/constants.dart';

class recycleBinPage extends StatefulWidget {
  const recycleBinPage({super.key});

  @override
  State<recycleBinPage> createState() => _recycleBinPageState();
}

class _recycleBinPageState extends State<recycleBinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(Constants.kPadding / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              const Padding(
                padding: EdgeInsets.only(
                    left: Constants.kPadding, bottom: Constants.kPadding),
                child: Text(
                  'All Folders',
                  style: TextStyle(
                    fontSize: Constants.kSizeTitle * 1.5,
                    fontWeight: Constants.kWeightTitle,
                    color: Colors.black,
                  ),
                ),
              ),
              // Sử dụng widget FolderGridView riêng biệt
              FolderGridView(),
              const Padding(
                padding: EdgeInsets.only(
                    left: Constants.kPadding, bottom: Constants.kPadding),
                child: Text(
                  'Notes',
                  style: TextStyle(
                    fontSize: Constants.kSizeTitle * 1.5,
                    fontWeight: Constants.kWeightTitle,
                    color: Colors.black,
                  ),
                ),
              ),
              // GridView bên trong SingleChildScrollView
              NoteGridView(),
            ],
          ),
        ),
      ),
    );
  }
}

class FolderGridView extends StatelessWidget {
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
              _showPopupMenu(context, details.globalPosition, folderNames[index]);
            },
            child: InkWell(
              onTap: (){},
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

  void _showPopupMenu(BuildContext context, Offset position, String folderName) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(position.dx, position.dy, position.dx, position.dy),
      items: [
        PopupMenuItem(
          value: 'restore',
          child: ListTile(
            leading: Icon(Icons.restore_rounded),
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
        }
      }
    });
  }
}

class NoteGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(), // Vô hiệu hóa cuộn riêng của GridView
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250, // Maximum width for each grid item
        crossAxisSpacing: Constants.kPadding / 2,
        mainAxisSpacing: Constants.kPadding,
        childAspectRatio: 0.65, // Adjusts the height relative to the width
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
                    width: double.infinity, // Làm cho hình ảnh chiếm toàn bộ chiều rộng
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.restore_page_rounded, color: Colors.black),
                        onPressed: () {
                          print('Delete icon pressed for image #$index');
                        },
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

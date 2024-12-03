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
      appBar: SearchBarPlugin(),
      body: Column(
        children: [
          FolderGridView(),
          Consumer<NoteProvider>(
            builder: (context, noteProvider, child) {
              return Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250, // Maximum width for each grid item
                    crossAxisSpacing: Constants.kPadding / 2,
                    mainAxisSpacing: Constants.kPadding,
                    childAspectRatio:
                        0.65, // Adjusts the height relative to the width
                  ),
                  itemCount:
                      noteProvider.notes.length, // Use notes from NoteProvider
                  itemBuilder: (context, index) {
                    var note = noteProvider.notes[index];
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
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(Constants.kBorder),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: double.infinity,
                                  child: InkWell(
                                    onTap: () {
                                      widget.onItemSelected(index);
                                    },
                                    child: Image.network(
                                      'https://picsum.photos/300/300?random=$index',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    "#${note.hashTag}",
                                    style: TextStyle(
                                      fontSize: Constants.kSizeBody,
                                      fontWeight: Constants.kWeightBody,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    'Url: ${note.url}',
                                    style: TextStyle(
                                      fontSize: Constants.kSizeBody,
                                      fontWeight: Constants.kWeightBody,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Text('Summarize: ${note.summarize}'),
                                Text('Sence: ${note.sence}'),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.favorite_border,
                                              color: Colors.red),
                                          onPressed: () {
                                            // Add action for love icon
                                            print(
                                                'Love icon pressed for image #$index');
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.share_rounded,
                                              color: Colors.blue),
                                          onPressed: () {
                                            // Add action for share icon
                                            print(
                                                'Share icon pressed for image #$index');
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(
                                              Icons.drive_file_move_rounded,
                                              color: Colors.green),
                                          onPressed: () {
                                            print(
                                                'Move icon pressed for image #$index');
                                          },
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete_outline,
                                          color: Colors.black),
                                      onPressed: () async {
                                        setState(() {
                                          isPending = true;
                                        });
                                        await noteProvider.deleteNote(note
                                            .id!); // Call delete from provider
                                        setState(() {
                                          isPending = false;
                                        });
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
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

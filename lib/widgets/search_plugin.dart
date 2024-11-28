import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../constants.dart';
import '../backend/storage_note_data/example.dart';

class SearchBarPlugin extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController selectedItem = TextEditingController();

  final List<String> fruits = [
    "tao",
    "chuoi",
    "cam",
    "dau tay",
    "nho",
    "thom",
    "dua hau",
    "mang cut",
    "kiwi",
    "viet quat"
  ];
  final List<Map> allDataNote = examples;

  SearchBarPlugin({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Constants.kPadding * 1.5,
        horizontal: Constants.kPadding * 2.5,
      ),
      child: Center(
        child: SizedBox(
          width: 500,
          child: TypeAheadField(
            builder: (context, controller, focusNode) {
              return TextField(
                controller: controller,
                focusNode: focusNode,
                autofocus: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(25.0), // Bo góc của TextField
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(25.0), // Bo góc khi focus
                    borderSide: BorderSide(
                        color: Colors.grey, width: 2.0), // Viền khi focus
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 15.0, // Khoảng cách theo chiều dọc
                    horizontal: 20.0, // Khoảng cách theo chiều ngang
                  ),
                  labelText:
                      'Search your save with hashtag, keyword or content...',
                  labelStyle: TextStyle(
                    color: Colors.grey, // Màu của hintText
                  ),
                  suffixIcon: Container(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {}, icon: Icon(Icons.close_rounded)),
                        Container(
                          width: 50, // Hạn chế chiều rộng của background
                          decoration: BoxDecoration(
                            color: Colors.black, // Màu nền
                            borderRadius: BorderRadius.only(
                              topRight:
                                  Radius.circular(25), // Góc trên phải bo tròn
                              bottomRight:
                                  Radius.circular(25), // Góc dưới phải bo tròn
                            ),
                          ),
                          constraints: BoxConstraints(
                            minHeight:
                                48, // Chiều cao tối thiểu bằng với TextField
                            maxHeight: 48, // Đảm bảo khớp với TextField
                          ),
                          alignment:
                              Alignment.center, // Căn giữa nội dung bên trong
                          child: Icon(
                            Icons.search,
                            color: Colors.white, // Màu biểu tượng
                            size: 20, // Kích thước biểu tượng
                          ),
                        ),
                      ],
                    ),
                  ),
                  // contentPadding: EdgeInsets.zero, // Loại bỏ padding giữa viền và nội dung
                ),
                style: TextStyle(
                  color: Colors.black, // Màu chữ nhập vào
                ),
                cursorColor: Colors.grey, // Màu con trỏ
              );
            },
            suggestionsCallback: (value) {
              return allDataNote
                  .where((element) => element['keyword']
                      .toLowerCase()
                      .contains(value.toLowerCase()))
                  .toList();
            },
            itemBuilder: (context, dataItem) {
              return ListTile(
                leading:
                    Container(width: 50, height: 50, color: Colors.blueGrey),
                title: Text(dataItem['title']),
                subtitle: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Căn theo cạnh trên
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Căn chữ về bên trái
                        children: [
                          Text(dataItem['hastag']),
                          Text(dataItem['keyword']),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            onSelected: (value) {
              selectedItem.text = value['title'];
              print(value);
            },
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100.0);
}

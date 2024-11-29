import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smart_storage/constants.dart';
import 'package:smart_storage/widgets/search_plugin.dart';

class mainPage extends StatefulWidget {
  final Function(int)
      onItemSelected; // Callback để thông báo khi một item được chọn

  const mainPage({super.key, required this.onItemSelected});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarPlugin(),
      body: Padding(
        padding: const EdgeInsets.all(Constants.kPadding / 2),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250, // Maximum width for each grid item
            crossAxisSpacing: Constants.kPadding / 2,
            mainAxisSpacing: Constants.kPadding,
            childAspectRatio: 0.65, // Adjusts the height relative to the width
          ),
          itemCount: 100, // Number of items in the grid
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(2),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Background color
                  borderRadius: BorderRadius.circular(
                      Constants.kBorder), // Optional: Rounded corners
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
                        height: 100, // Constant height for the image
                        width: double
                            .infinity, // Make image take full width of container
                        child: InkWell(
                          onTap: () {
                            widget.onItemSelected(index);
                          },
                          child: Image.network(
                            'https://picsum.photos/300/300?random=$index', // URL for a random image
                            fit: BoxFit
                                .cover, // Make the image cover the container
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          '#Hastag 1, #Hastag2',
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: Icon(Icons.favorite_border,
                                    color: Colors.red),
                                onPressed: () {
                                  // Add action for love icon
                                  print('Love icon pressed for image #$index');
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.share_rounded,
                                    color: Colors.blue),
                                onPressed: () {
                                  // Add action for love icon
                                  print('Love icon pressed for image #$index');
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.drive_file_move_rounded,
                                    color: Colors.green),
                                onPressed: () {
                                  print('Share icon pressed for image #$index');
                                },
                              ),
                            ],
                          ),
                          IconButton(
                            icon:
                                Icon(Icons.delete_outline, color: Colors.black),
                            onPressed: () {
                              // Add action for delete icon
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
        ),
      ),
    );
  }
}

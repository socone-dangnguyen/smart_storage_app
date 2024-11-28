import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_storage/constants.dart';
import '../responsive_layout.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class ButtonInfo {
  String title;
  IconData icon;

  ButtonInfo({
    required this.title,
    required this.icon,
  });
}

int _selectedIndex = 0;

List<ButtonInfo> _buttonNames = [
  ButtonInfo(title: 'Home', icon: Icons.home_rounded),
  ButtonInfo(title: 'Add New', icon: Icons.add_circle_rounded),
  ButtonInfo(title: 'Folder', icon: Icons.folder_rounded),
  ButtonInfo(title: 'Recycle Bin', icon: Icons.restore_from_trash_rounded),
  ButtonInfo(title: 'Sync & Backup', icon: Icons.cloud_rounded),
];

class drawerPage extends StatefulWidget {
  final Function(int) onMenuSelected;
  final int currentIndex;

  drawerPage({required this.onMenuSelected, required this.currentIndex});

  @override
  _drawerPageState createState() => _drawerPageState();
}

class _drawerPageState extends State<drawerPage> {
  late TextEditingController controller;
  bool isCreateButtonEnabled = false;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    _selectedIndex =
        widget.currentIndex; // Initialize with the current index from parent
  }

  @override
  void didUpdateWidget(covariant drawerPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update selected index if parent index changes
    if (oldWidget.currentIndex != widget.currentIndex) {
      setState(() {
        _selectedIndex = widget.currentIndex;
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _checkInput() {
    setState(() {
      isCreateButtonEnabled = controller.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Constants.lightGray,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.all(Constants.kPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      "User Name",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                    trailing: ResponsiveLayout.isComputer(context)
                        ? null
                        : IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.menu_open_rounded,
                              color: Colors.black,
                            )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ...List.generate(
                      _buttonNames.length,
                      (index) => Column(
                            children: [
                              Container(
                                decoration: index == _selectedIndex
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(colors: [
                                          Constants.blueDarkGray
                                              .withOpacity(0.9),
                                          Constants.white.withOpacity(0.9)
                                        ]),
                                      )
                                    : null,
                                child: ListTile(
                                  title: Text(
                                    _buttonNames[index].title,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  leading: Padding(
                                    padding: const EdgeInsets.all(
                                        Constants.kPadding),
                                    child: Icon(
                                      _buttonNames[index].icon,
                                      color: index == _selectedIndex
                                          ? Colors.white
                                          : Colors.black87,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _selectedIndex =
                                          index; // Update the internal state
                                    });
                                    widget.onMenuSelected(
                                        index); // Notify parent to change the page

                                    // Check if the tapped item should show a popup
                                    if (_buttonNames[index].title ==
                                        'Add New') {
                                      // Show the popup menu programmatically
                                      showMenu(
                                        context: context,
                                        position: RelativeRect.fromLTRB(
                                            100,
                                            210,
                                            100,
                                            0), // Adjust position as needed
                                        items: [
                                          PopupMenuItem(
                                            onTap: () {
                                              _showInputUrl();
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: Constants.kPadding),
                                              child: Text('Add File'),
                                            ),
                                          ),
                                          PopupMenuItem(
                                            onTap: () {
                                              _showInputFolder();
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: Constants.kPadding),
                                              child: Text('Add Folder'),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              Divider(
                                color: Colors.black54,
                                thickness: 0.3,
                              ),
                            ],
                          )),
                ],
              ),
            ),
            Text(
              'Des & Dev by HDT',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }

  Future<String?> _showInputUrl() => showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  15), // Circular border with a high radius
            ),
            title: Text(
              'Give me your URL',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            content: TextField(
              autocorrect: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(Constants.kPadding)), // Rounded corners
                  borderSide: BorderSide(
                    color: Constants.blueDarkGray, // Border color
                    width: 2.0, // Border width
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                    color: Colors.black87, // Border color when focused
                    width: 2.0,
                  ),
                ),
                hintText: 'https://...',
              ),
              controller: controller,
            ),
            actions: <Widget>[
              // Cancel Button with border
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pop(); // Close the dialog without returning data
                },
                style: OutlinedButton.styleFrom(
                  side:
                      BorderSide(color: Constants.blueDarkGray), // Border color
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              // Create Button with color, enabled/disabled based on input
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop(controller.text); // Return the URL
                  _showLoadingDialog(context);
                }, // Disable if text field is empty
                style: OutlinedButton.styleFrom(
                  backgroundColor: Constants.blueDarkGray,
                  // Color for the button
                  side: BorderSide(
                      color:
                          Constants.blueDarkGray), // Border for Create button
                ),
                child: Text(
                  'Create',
                  style: TextStyle(
                    color: Colors.white, // Text color
                  ),
                ),
              ),
            ],
          );
        },
      );

  Future<String?> _showInputFolder() => showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  15), // Circular border with a high radius
            ),
            title: Text(
              'Name Folder',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            content: TextField(
              autocorrect: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(Constants.kPadding)), // Rounded corners
                  borderSide: BorderSide(
                    color: Constants.blueDarkGray, // Border color
                    width: 2.0, // Border width
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                    color: Colors.black87, // Border color when focused
                    width: 2.0,
                  ),
                ),
              ),
              controller: controller,
            ),
            actions: <Widget>[
              // Cancel Button with border
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pop(); // Close the dialog without returning data
                },
                style: OutlinedButton.styleFrom(
                  side:
                      BorderSide(color: Constants.blueDarkGray), // Border color
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              // Create Button with color, enabled/disabled based on input
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop(controller.text); // Return the URL
                }, // Disable if text field is empty
                style: OutlinedButton.styleFrom(
                  backgroundColor: Constants.blueDarkGray,
                  // Color for the button
                  side: BorderSide(
                      color:
                          Constants.blueDarkGray), // Border for Create button
                ),
                child: Text(
                  'Create',
                  style: TextStyle(
                    color: Colors.white, // Text color
                  ),
                ),
              ),
            ],
          );
        },
      );
  Future<void> submitForm(
      String hashTag, String url, String summarize, String sence) async {
    final dio = Dio();

    try {
      // Collect data from text controllers
      final data = {
        "hash_tag": hashTag,
        "url": url,
        "summarize": summarize,
        "sence": sence,
      };
      // Make the POST request
      final response = await dio.post(
        'http://localhost:8000/notes', // Replace with your API endpoint
        data: data,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            // Add more headers if needed
          },
        ),
      );

      // Handle response
      if (response.statusCode == 201) {
        print('Form submitted successfully!');
        print('Response: ${response.data}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Form submitted successfully!')),
        );
      } else {
        print('Failed to submit form: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit form')),
        );
      }
    } catch (e) {
      // Handle errors
      print('Error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred while submitting the form')),
      );
    }
  }

  Future<void> _showLoadingDialog(BuildContext context) async {
    // Show the loading dialog
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SpinKitCubeGrid(
                  color: Constants.blueDarkGray,
                  size: 20,
                ),
                SizedBox(width: 20),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showInputDialog(
                      context,
                      'testing text',
                      'testing text',
                      'testing text',
                      'testing text',
                    );
                  },
                  child: Text(
                    "Processing in Gemini AI Google...",
                    style: TextStyle(color: Colors.black87),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showInputDialog(
    BuildContext context,
    String hastag,
    String URL,
    String summarize,
    String sence,
  ) async {
    final hastagController = TextEditingController(text: hastag);
    final URLController = TextEditingController(text: URL);
    final summarizeController = TextEditingController(text: summarize);
    final senceController = TextEditingController(text: sence);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Input Information'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: Constants.kPadding),
                  child: TextField(
                    controller: hastagController,
                    decoration: InputDecoration(
                      labelText: '#Hastag',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(
                            Constants.kPadding)), // Rounded corners
                        borderSide: BorderSide(
                          color: Constants.blueDarkGray, // Border color
                          width: 2.0, // Border width
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          color: Colors.black87, // Border color when focused
                          width: 2.0,
                        ),
                      ),
                    ),
                    maxLines: null, // Allow multiple lines
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: Constants.kPadding),
                  child: TextField(
                    controller: URLController,
                    decoration: InputDecoration(
                      labelText: 'URL your note',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(
                            Constants.kPadding)), // Rounded corners
                        borderSide: BorderSide(
                          color: Constants.blueDarkGray, // Border color
                          width: 2.0, // Border width
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          color: Colors.black87, // Border color when focused
                          width: 2.0,
                        ),
                      ),
                    ),
                    maxLines: null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: Constants.kPadding),
                  child: TextField(
                    controller: summarizeController,
                    decoration: InputDecoration(
                      labelText: 'Summarize your note',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(
                            Constants.kPadding)), // Rounded corners
                        borderSide: BorderSide(
                          color: Constants.blueDarkGray, // Border color
                          width: 2.0, // Border width
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          color: Colors.black87, // Border color when focused
                          width: 2.0,
                        ),
                      ),
                    ),
                    maxLines: null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: Constants.kPadding),
                  child: TextField(
                    controller: senceController,
                    decoration: InputDecoration(
                      labelText: 'Sence your note',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(
                            Constants.kPadding)), // Rounded corners
                        borderSide: BorderSide(
                          color: Constants.blueDarkGray, // Border color
                          width: 2.0, // Border width
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          color: Colors.black87, // Border color when focused
                          width: 2.0,
                        ),
                      ),
                    ),
                    maxLines: null,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            OutlinedButton(
              onPressed: () async {
                await submitForm(
                  hastagController.text,
                  URLController.text,
                  summarizeController.text,
                  senceController.text,
                ); // Close the dialog without returning data
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Constants.blueDarkGray,
                // Color for the button
                side: BorderSide(
                    color: Constants.blueDarkGray), // Border for Create button
              ),
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Close the dialog without returning data
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Constants.blueDarkGray), // Border color
              ),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.black87),
              ),
            ),
          ],
        );
      },
    );
  }
}

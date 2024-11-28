import 'package:flutter/material.dart';
import 'package:smart_storage/constants.dart';
import 'package:smart_storage/widgets/drawer/drawer_page.dart';
import 'package:smart_storage/pages/folder_page/folderPage.dart';
import 'package:smart_storage/pages/main_page/detail_page.dart';
import 'package:smart_storage/pages/main_page/main_page.dart';
import 'package:smart_storage/pages/recycle_bin_page/recycleBinPage.dart';
import 'package:smart_storage/pages/sync_backup_page/syncBackupPage.dart';
import 'responsive_layout.dart';

class tree_map_responsive extends StatefulWidget {
  const tree_map_responsive({super.key});

  @override
  State<tree_map_responsive> createState() => _tree_map_responsiveState();
}

class _tree_map_responsiveState extends State<tree_map_responsive> {
  int selectedNote = 0; // Biến lưu chi tiết mục đã chọn

  void _onItemSelected(int item) {
    setState(() {
      selectedNote = item; // Cập nhật mục đã chọn
    });
  }

  int _currentIndex = 0;

  // A list of widgets that will act as different pages
  late final List<Widget> _pages;

  // Function to change the current index
  void _onMenuSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _pages = [
      mainPage(onItemSelected: _onItemSelected), // Replace with actual pages
      mainPage(onItemSelected: _onItemSelected), // Replace with actual pages
      folderPage(), // Replace with actual pages
      recycleBinPage(), // Replace with actual pages
      syncBackupPage(), // Replace with actual pages
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 50.0),
        child: (ResponsiveLayout.isTinyLimit(context) ||
                ResponsiveLayout.isTinyHeightLimit(context)
            ? Container()
            : AppBar(
                backgroundColor: Constants.blueDarkGray,
              )),
      ),
      backgroundColor: Constants.blueDarkGray,
      body: ResponsiveLayout(
        tiny: Container(),
        phone: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        largeTablet: Row(
          children: [
            Expanded(
              flex: 7,
              child: IndexedStack(
                index: _currentIndex,
                children: _pages,
              ),
            ),
            (_currentIndex == 3 || _currentIndex == 4)
                ? Container()
                : Expanded(
                    flex: 3,
                    child: detailPage(
                      itemDetail: selectedNote,
                    )),
          ],
        ),
        computer: Row(
          children: [
            Expanded(
                flex: 2,
                child: drawerPage(
                  onMenuSelected: _onMenuSelected, // Passing callback function
                  currentIndex:
                      _currentIndex, // Pass current index for UI state
                )),
            Expanded(
              flex: 8,
              child: IndexedStack(
                index: _currentIndex,
                children: _pages,
              ),
            ),
            (_currentIndex == 3 || _currentIndex == 4)
                ? Container()
                : Expanded(
                    flex: 3,
                    child: detailPage(
                      itemDetail: selectedNote,
                    )),
          ],
        ),
      ),
      drawer: drawerPage(
        onMenuSelected: _onMenuSelected, // Passing callback function
        currentIndex: _currentIndex, // Pass current index for UI state
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:smart_storage/constants.dart';

class detailPage extends StatefulWidget {
  final int? itemDetail; // Chi tiết của item được chọn

  const detailPage({super.key, this.itemDetail});
  @override
  State<detailPage> createState() => _detailPageState();
}

class _detailPageState extends State<detailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 100),
        child:  Padding(
          padding: const EdgeInsets.only(
              top: Constants.kPadding * 7,
              right: Constants.kPadding *2
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end, // Aligns the content to the right
            children: [
              Text(
                'Detail of item ${widget.itemDetail}', // Title text
                style: TextStyle(
                  color: Colors.black, // Text color
                  fontSize: 20, // Font size
                  fontWeight: FontWeight.bold, // Font weight
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Constants.kPadding*3),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: Constants.kPadding/5),
                child: Text(
                  '#Hastag',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: Constants.kPadding*1.5),
                child: Container(
                  width: double.infinity,
                  color: Constants.lightGray,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '#Hastag1, #Hastag2',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Constants.kPadding *2,),Padding(
                padding: const EdgeInsets.only(left: Constants.kPadding/5),
                child: Text(
                  'Keyword',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: Constants.kPadding*1.5),
                child: Container(
                  width: double.infinity,
                  color: Constants.lightGray,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Keyword1, Keyword2, Keyword 3',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Constants.kPadding *2,),
              Padding(
                padding: const EdgeInsets.only(left: Constants.kPadding/5),
                child: Text(
                  'URL your note',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: Constants.kPadding*1.5),
                child: Container(
                  width: double.infinity,
                  color: Constants.lightGray,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '#Hastag1, #Hastag2',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Constants.kPadding *2,),
              Padding(
                padding: const EdgeInsets.only(left: Constants.kPadding),
                child: Text(
                  'Summarize your note',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: Constants.kPadding*1.5),
                child: Container(
                  width: double.infinity,
                  color: Constants.lightGray,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'This is a paragraph of text inside a container with a background color. '
                          'The container’s background color can be customized to any color you like. '
                          'The text will wrap automatically if it exceeds the width of the container. '
                          'You can add padding, margins, and other styling to the container as needed.',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Constants.kPadding *2,),
              Padding(
                padding: const EdgeInsets.only(left: Constants.kPadding),
                child: Text(
                  'Scrip your scene note',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: Constants.kPadding*1.5),
                child: Container(
                  width: double.infinity,
                  color: Constants.lightGray,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'This is a paragraph of text inside a container with a background color. '
                          'The container’s background color can be customized to any color you like. '
                          'The text will wrap automatically if it exceeds the width of the container. '
                          'You can add padding, margins, and other styling to the container as needed.',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              // You can add more widgets here if needed
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smart_storage/models/note.dart';
import 'package:smart_storage/provider/note_provider.dart';
import 'package:provider/provider.dart';

class NoteDetail extends StatelessWidget {
  final Note note;
  const NoteDetail({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            NoteItem(title: 'Hashtag', text: note.hashTag),
            const SizedBox(
              height: 30,
            ),
            NoteItem(title: 'URL', text: note.url),
            const SizedBox(
              height: 30,
            ),
            NoteItem(title: 'Summarize', text: note.summarize),
            const SizedBox(
              height: 30,
            ),
            NoteItem(title: 'Sence', text: note.sence),
          ],
        ),
      ),
    );
  }
}

class NoteItem extends StatelessWidget {
  final String title;
  final String text;
  const NoteItem({
    super.key,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "$title: ",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),
        ),
      ],
    );
  }
}

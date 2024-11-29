import 'package:flutter/material.dart';
import 'package:smart_storage/models/note.dart';
import 'package:smart_storage/provider/note_provider.dart';
import 'package:provider/provider.dart';

class NoteDetail extends StatefulWidget {
  final Note note;
  const NoteDetail({super.key, required this.note});

  @override
  State<NoteDetail> createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _hashTagController;
  late TextEditingController _urlController;
  late TextEditingController _summarizeController;
  late TextEditingController _senceController;

  @override
  void initState() {
    super.initState();
    // Khởi tạo controller với giá trị hiện tại của ghi chú
    _hashTagController = TextEditingController(text: widget.note.hashTag);
    _urlController = TextEditingController(text: widget.note.url);
    _summarizeController = TextEditingController(text: widget.note.summarize);
    _senceController = TextEditingController(text: widget.note.sence);
  }

  @override
  void dispose() {
    // Giải phóng controller khi không cần thiết nữa
    _hashTagController.dispose();
    _urlController.dispose();
    _summarizeController.dispose();
    _senceController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Lấy thông tin từ các trường nhập liệu
      final updatedNote = Note(
        id: widget.note.id,
        hashTag: _hashTagController.text,
        url: _urlController.text,
        summarize: _summarizeController.text,
        sence: _senceController.text,
      );

      // Cập nhật ghi chú thông qua NoteProvider
      Provider.of<NoteProvider>(context, listen: false).updateNote(
        id: widget.note.id!,
        hashTag: updatedNote.hashTag,
        url: updatedNote.url,
        summarize: updatedNote.summarize,
        sence: updatedNote.sence,
      );

      // Hiển thị thông báo cập nhật thành công
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Note updated successfully!')),
      );

      // Quay lại màn hình trước
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Input for hashTag
              TextFormField(
                controller: _hashTagController,
                decoration: InputDecoration(
                  labelText: 'HashTag',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a hashtag';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Input for URL
              TextFormField(
                controller: _urlController,
                decoration: InputDecoration(
                  labelText: 'URL',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a URL';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Input for summarize
              TextFormField(
                controller: _summarizeController,
                decoration: InputDecoration(
                  labelText: 'Summarize',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a summary';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Input for sence
              TextFormField(
                controller: _senceController,
                decoration: InputDecoration(
                  labelText: 'Sence',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a sense';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Update Note'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

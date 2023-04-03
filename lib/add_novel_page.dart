import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'database_helper.dart';
import 'novelmodel.dart';

class AddNovelPage extends StatefulWidget {
  const AddNovelPage({Key? key}) : super(key: key);

  @override
  _AddNovelPageState createState() => _AddNovelPageState();
}

class _AddNovelPageState extends State<AddNovelPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _sourceController = TextEditingController();
  final dbHelper = DatabaseHelper.instance;

  Future<void> _onSaveButtonPressed(BuildContext context) async {
    String title = _titleController.text;
    String imageUrl = _imageUrlController.text;
    String source = _sourceController.text;

    if (title.isEmpty || imageUrl.isEmpty || source.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    // Insert new novel
    final novel = Novel(
      title: title,
      imageUrl: imageUrl,
      source: source,
    );

    try {
      await dbHelper.insertNovel(novel);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save novel: ${e.toString()}'),
        ),
      );
      return;
    }

    // Navigate back to home page
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Novel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _imageUrlController,
              decoration: const InputDecoration(
                labelText: 'Image URL',
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _sourceController,
              decoration: const InputDecoration(
                labelText: 'Source',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _onSaveButtonPressed(context),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

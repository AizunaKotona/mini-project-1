import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'novelmodel.dart';

class EditNovelPage extends StatefulWidget {
  final Novel novel;

  const EditNovelPage({Key? key, required this.novel}) : super(key: key);

  @override
  _EditNovelPageState createState() => _EditNovelPageState();
}

class _EditNovelPageState extends State<EditNovelPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _sourceController = TextEditingController();
  final dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.novel.title;
    _imageUrlController.text = widget.novel.imageUrl;
    _sourceController.text = widget.novel.source;
  }

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

    // Update existing novel
    final novel = Novel(
      id: widget.novel.id,
      title: title,
      imageUrl: imageUrl,
      source: source,
    );

    try {
      await dbHelper.updateNovel(novel.toMap());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update novel: ${e.toString()}'),
        ),
      );
      return;
    }

    // Return updated novel to previous page
    Navigator.pop(context, novel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Novel'),
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

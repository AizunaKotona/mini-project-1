import 'package:flutter/material.dart';
import 'package:newnovel/add_novel_page.dart';
import 'database_helper.dart';
import 'novel_edit_page.dart';
import 'novelmodel.dart';

class NovelListPage extends StatefulWidget {
  const NovelListPage({Key? key}) : super(key: key);

  @override
  _NovelListPageState createState() => _NovelListPageState();
}

class _NovelListPageState extends State<NovelListPage> {
  final dbHelper = DatabaseHelper.instance;
  late List<Map<String, dynamic>> _novels;

  @override
  void initState() {
    super.initState();
    _fetchNovels();
  }

  Future<void> _fetchNovels() async {
    final novels = await dbHelper.queryAllNovels();
    setState(() {
      _novels = novels;
    });
  }

  Future<void> _onRefresh() async {
    await _fetchNovels();
  }

  Future<void> _onDeleteNovel(int? id) async {
    if (id == null) return;

    try {
      await dbHelper.deleteNovel(id);
      await _fetchNovels();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Novel deleted')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete novel: ${e.toString()}'),
        ),
      );
    }
  }

  Future<void> _onEditNovel(Novel novel) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNovelPage(novel: novel),
      ),
    );
    if (result != null) {
      await _fetchNovels();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Novel updated')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novel List'),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: _novels.isEmpty
            ? const Center(
                child: Text('No novels found.'),
              )
            : ListView.builder(
                itemCount: _novels.length,
                itemBuilder: (context, index) {
                  final novel = Novel.fromMap(_novels[index]);
                  return ListTile(
                    title: Text(novel.title),
                    subtitle: Text(novel.source),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _onEditNovel(novel),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Novel'),
                              content: const Text(
                                  'Are you sure you want to delete this novel?'),
                              actions: [
                                TextButton(
                                  child: const Text('Cancel'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                TextButton(
                                  child: const Text('Delete'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _onDeleteNovel(novel.id);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      // TODO: Navigate to novel detail page
                    },
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddNovelPage())),
        child: const Icon(Icons.add),
      ),
    );
  }
}

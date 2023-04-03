class Novel {
  int? id;
  String title;
  String imageUrl;
  String source;

  Novel({
    this.id,
    required this.title,
    required this.imageUrl,
    required this.source,
  });

  Map<String, dynamic> toMap() {
    return {
      // Don't include id if it's null (i.e. when inserting a new row)
      if (id != null) 'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'source': source,
    };
  }

  factory Novel.fromMap(Map<String, dynamic> map) {
    return Novel(
      id: map['id'],
      title: map['title'],
      imageUrl: map['imageUrl'],
      source: map['source'],
    );
  }
}

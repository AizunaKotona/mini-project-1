import 'package:flutter/material.dart';

class NovelCard extends StatefulWidget {
  final String novelTitle;
  final String novelImage;
  final int viewCount;
  final int bookmarkCount;
  final VoidCallback onTap;
  
    const NovelCard({
    Key? key,
    required this.novelTitle,
    required this.novelImage,
    required this.viewCount,
    required this.bookmarkCount,
    required this.onTap,
  }) : super(key: key);

  @override
  _NovelCardState createState() => _NovelCardState();
}


class _NovelCardState extends State<NovelCard> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    bool isFavorite = false;

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  widget.novelImage,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: AnimatedBuilder(
                  animation: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
                    parent: AnimationController(duration: const Duration(milliseconds: 500),vsync: this,),
                    curve: Curves.easeInOut,
                  )),
                  builder: (context, child) {
                    return IconButton(
                      icon: Icon(Icons.favorite, color: isFavorite ? Colors.red : Colors.grey),
                      onPressed: () {
                        isFavorite = !isFavorite;
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.novelTitle,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Icon(Icons.remove_red_eye_outlined, size: 16),
                SizedBox(width: 4),
                Text(
                  '$widget.viewCount',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(width: 16),
                Icon(Icons.bookmark_border_outlined, size: 16),
                SizedBox(width: 4),
                Text(
                  '$widget.bookmarkCount',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

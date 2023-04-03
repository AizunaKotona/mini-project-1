import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicture extends StatefulWidget {
  final String imageUrl;
  final Function(File)? onImageSelected;

  const ProfilePicture({
    Key? key,
    required this.imageUrl,
    this.onImageSelected,
  }) : super(key: key);

  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  late File _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      widget.onImageSelected?.call(_imageFile);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.imageUrl.isNotEmpty) {
      _imageFile = File(widget.imageUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text('Take a photo'),
                    onTap: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.camera);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Choose from gallery'),
                    onTap: () {
                      Navigator.pop(context);
                      _pickImage(ImageSource.gallery);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      child: CircleAvatar(
        radius: 70,
        backgroundImage: _imageFile.existsSync() ? FileImage(_imageFile) : null,
        child: _imageFile.existsSync() ? null : const Icon(Icons.person),
      ),
    );
  }
}

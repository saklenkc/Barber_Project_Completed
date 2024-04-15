import 'dart:io';

import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:updated_barber_project/userPanel.dart';

class AdminPanel extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> _uploadImage(BuildContext context) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    File file = File(image.path);
    String imageName = image.path.split('/').last;

    try {
      await _storage.ref('images/$imageName').putFile(file);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Image uploaded successfully.'),
        ),
      );
    } catch (e) {
      print('Error uploading image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to upload image.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: () => _uploadImage(context),
              child: Text('Upload Image'),
            ),
            GestureDetector(
              onTap: () => UserPanel(),
            ),
          ],
        ),
      ),
    );
  }
}

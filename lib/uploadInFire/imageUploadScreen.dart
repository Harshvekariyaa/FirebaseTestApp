import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? _imageFile;
  final picker = ImagePicker();
  bool _isUploading = false;

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadImage() async {
    setState(() {
      _isUploading = true;
    });

    if (_imageFile == null) {
      print('No image selected.');
      return;
    }

    Reference storageReference =
    FirebaseStorage.instance.ref().child('images/${DateTime.now()}.png');

    UploadTask uploadTask = storageReference.putFile(_imageFile!);
    await uploadTask.whenComplete(() => setState(() => _isUploading = false));

    print('Image uploaded to Firebase Storage.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload to Firebase'),
      ),
      body: Center(
        child: _imageFile == null
            ? Text('No image selected.')
            : Image.file(_imageFile!),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: getImage,
            tooltip: 'Pick Image',
            child: Icon(Icons.photo_library),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: uploadImage,
            tooltip: 'Upload Image',
            child: _isUploading ? CircularProgressIndicator() : Icon(Icons.cloud_upload),
          ),
        ],
      ),
    );
  }
}
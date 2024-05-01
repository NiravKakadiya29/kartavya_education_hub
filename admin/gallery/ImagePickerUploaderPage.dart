import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';

class ImageGalleryPage extends StatefulWidget {
  @override
  _ImageGalleryPageState createState() => _ImageGalleryPageState();
}

class _ImageGalleryPageState extends State<ImageGalleryPage> {
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    // Fetch image URLs from Firestore when widget is initialized
    fetchImageUrls();
  }

  Future<void> fetchImageUrls() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firestore
        .collection('users')
        .doc('gallery')
        .collection('images')
        .get();

    List<String> urls = [];
    snapshot.docs.forEach((doc) {
      final data = doc.data() as Map<String,
          dynamic>?; // Explicit cast to Map<String, dynamic> or null
      if (data != null && data['urls'] != null) {
        urls.addAll(
            List<String>.from(data['urls']!)); // Ensure 'urls' is not null
      }
    });

    setState(() {
      imageUrls = urls;
    });
  }

  Future<void> uploadImages(List<File> images) async {
    for (var imageFile in images) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("images/$fileName");
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      String url = await taskSnapshot.ref.getDownloadURL();
      print(url);
      imageUrls.add(url);
    }
    // Once all images are uploaded, save the list to Firestore
    await saveUrlsToFirestore(imageUrls);
  }

  Future<void> saveUrlsToFirestore(List<String> urls) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('users')
        .doc('gallery')
        .collection('images')
        .doc(DateTime.now().toString())
        .set({'urls': urls});
  }

  Future<void> _pickImages() async {
    List<File> pickedImages = [];
    final picker = ImagePicker();
    final pickedFileList = await picker.pickMultiImage();
    if (pickedFileList != null) {
      pickedImages =
          pickedFileList.map((pickedFile) => File(pickedFile.path)).toList();
    }
    setState(() {
      imageUrls.clear(); // Clear existing URLs
    });
    await uploadImages(pickedImages);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Gallery'),
      ),
      body: MasonryGridView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ImageDetailPage(imageUrls[index]),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Hero(
              tag: imageUrls[index], // Unique tag for each image
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  imageUrls[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        gridDelegate:
            SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Choose from gallery'),
                      onTap: () {
                        _pickImages();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ImageDetailPage extends StatelessWidget {
  final String imageUrl;

  ImageDetailPage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image'),
      ),
      body: Center(
        child: Hero(
          tag: imageUrl,
          child: Image.network(imageUrl),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../admin/gallery/ImagePickerUploaderPage.dart';
import '/const/consts.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
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
    );
  }
}

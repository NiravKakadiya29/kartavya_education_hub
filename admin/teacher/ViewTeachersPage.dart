import 'package:cloud_firestore/cloud_firestore.dart';

import '../../const/consts.dart';
import 'TeacherForm.dart';

class ViewTeachersPage extends StatefulWidget {
  const ViewTeachersPage({super.key});

  @override
  State<ViewTeachersPage> createState() => _ViewTeachersPageState();
}

class _ViewTeachersPageState extends State<ViewTeachersPage> {
  // List<String> teachers = [];
  //
  // Future<List<String>> getTeacher() async {
  //   try {
  //     QuerySnapshot snapshot = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc("teachers")
  //         .collection("teachers")
  //         .get();
  //     snapshot.docs.forEach((doc) {
  //       print("the id is ${doc.id}");
  //       teachers.add(doc['name']);
  //     });
  //   } catch (e) {
  //     print('Error fetching document IDs: $e');
  //   }
  //   return teachers;
  // }
  //
  // Future<void> initializeData() async {
  //   await getTeacher();
  // }
  //
  // @override
  // void initState() {
  //   initializeData();
  //   print(teachers.length);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Teachers'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc('teachers')
                    .collection('teachers')
                    // for filter use
                    .orderBy('subject')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        // Access the document snapshot at this index
                        DocumentSnapshot document = snapshot.data!.docs[index];
                        // Extract data from document snapshot
                        String Teacher_name = document['name'];
                        String subject = document?['subject'];
                        // Return a list tile for the item
                        return ListTile(
                          title: Text('${Teacher_name}'),
                          subtitle: Text('Subject: $subject'),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        decoration: BoxDecoration(color: Colors.brown),
        child: Center(
            child: Text(
          'Add New Teacher',
          style: TextStyle(color: Colors.white, fontSize: 18),
        )),
      ).onTap(() {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return TeacherForm();
          },
        );
      }),
    );
  }
}

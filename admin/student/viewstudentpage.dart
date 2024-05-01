import 'package:cloud_firestore/cloud_firestore.dart';

import '../../const/consts.dart';
import 'StudentList.dart';
import '../AddStudentPage.dart';
import '../AdminPage.dart';

class ViewStudentsPage extends StatefulWidget {
  @override
  _ViewStudentsPageState createState() => _ViewStudentsPageState();
}

class _ViewStudentsPageState extends State<ViewStudentsPage> {
  List<String> standardClass = [];

  Future<List<String>> getClass() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc("students")
          .collection("students")
          .orderBy('class')
          .get();
      snapshot.docs.forEach((doc) {
        print("the id is ${doc.id}");
        standardClass.add(doc['class']);
      });
    } catch (e) {
      print('Error fetching document IDs: $e');
    }
    return standardClass.toSet().toList();
  }

  Future<void> initializeData() async {
    await getClass();
  }

  @override
  void initState() {
    initializeData();
    print(standardClass.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Students'),
      ),
      body: FutureBuilder<List<String>>(
        future: getClass(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(color: Colors.tealAccent),
                  child: ListTile(
                    title: Text(
                      snapshot.data![index],
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ).onTap(() {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => StudentList(
                      standard: snapshot.data![index].toString(),
                    ),
                  ));
                });
              },
            );
          }
        },
      ),
    );
  }
}

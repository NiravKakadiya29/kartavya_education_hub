import 'package:flutter/material.dart';
import 'package:kartavya_education_hub/admin/gallery/ImagePickerUploaderPage.dart';
import 'package:kartavya_education_hub/view/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const/consts.dart';
import '../teacher/teacherdrawer.dart';
import 'AddImagePage.dart';
import 'AddStudentPage.dart';
import 'AddTeacherPage.dart';
import 'admintimetable.dart';
import 'student/viewstudentpage.dart';
import 'teacher/ViewTeachersPage.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: TeacherDrawer(),
      backgroundColor: Vx.blue200,
      appBar: AppBar(
        title: Text('Admin Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Login(),
              ));
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8, left: 15, right: 15),
                child: Center(
                  child: NeuBox(
                    borderRadius: 15.0,
                    blurRadius: 0.0,
                    bgColor: 0xff288BA8,
                    bottomRight: 0xff90CAF9,
                    topLeft: 0xffd8d7d7,
                    distance: -2.0,
                    height: 130.0,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Row(
                        children: [
                          20.widthBox,
                          'View Students'
                              .text
                              .size(22)
                              .bodyText1(context)
                              .make(),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Image.asset(
                              "./lib/assets/images/student.png",
                              width: 130,
                            ),
                          )
                        ],
                      ),
                    ),
                  ).onTap(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewStudentsPage()),
                    );
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8, left: 15, right: 15),
                child: Center(
                  child: NeuBox(
                    borderRadius: 15.0,
                    blurRadius: 0.0,
                    bgColor: 0xff288BA8,
                    bottomRight: 0xff90CAF9,
                    topLeft: 0xffd8d7d7,
                    distance: -2.0,
                    height: 130.0,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Row(
                        children: [
                          20.widthBox,
                          'View Teachers'
                              .text
                              .size(22)
                              .bodyText1(context)
                              .make(),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Image.asset(
                              "./lib/assets/images/teacher.png",
                              width: 130,
                            ),
                          )
                        ],
                      ),
                    ),
                  ).onTap(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewTeachersPage()),
                    );
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8, left: 15, right: 15),
                child: Center(
                  child: NeuBox(
                    borderRadius: 15.0,
                    blurRadius: 0.0,
                    bgColor: 0xff288BA8,
                    bottomRight: 0xff90CAF9,
                    topLeft: 0xffd8d7d7,
                    distance: -2.0,
                    height: 130.0,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Row(
                        children: [
                          18.widthBox,
                          'Add Announcement'
                              .text
                              .size(22)
                              .bodyText1(context)
                              .make(),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Image.asset(
                              "./lib/assets/images/announcement.png",
                              width: 100,
                            ),
                          )
                        ],
                      ),
                    ),
                  ).onTap(() {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => AddAnnouncementPage()),
                    // );
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8, left: 15, right: 15),
                child: Center(
                  child: NeuBox(
                    borderRadius: 15.0,
                    blurRadius: 0.0,
                    bgColor: 0xff288BA8,
                    bottomRight: 0xff90CAF9,
                    topLeft: 0xffd8d7d7,
                    distance: -2.0,
                    height: 130.0,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Row(
                        children: [
                          20.widthBox,
                          'Add Image'.text.size(22).bodyText1(context).make(),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Image.asset(
                              "./lib/assets/images/image.png",
                              width: 130,
                            ),
                          )
                        ],
                      ),
                    ),
                  ).onTap(() {
                    Navigator.push(
                      context,
                      // MaterialPageRoute(builder: (context) => AddImagePage()),
                      MaterialPageRoute(
                          builder: (context) => ImageGalleryPage()),
                    );
                  }),
                ),
              ),

// add time table
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8, left: 15, right: 15),
                child: Center(
                  child: NeuBox(
                    borderRadius: 15.0,
                    blurRadius: 0.0,
                    bgColor: 0xff288BA8,
                    bottomRight: 0xff90CAF9,
                    topLeft: 0xffd8d7d7,
                    distance: -2.0,
                    height: 130.0,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Row(
                        children: [
                          20.widthBox,
                          'Time Table'.text.size(22).bodyText1(context).make(),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Image.asset(
                              "./lib/assets/images/student.png",
                              width: 130,
                            ),
                          )
                        ],
                      ),
                    ),
                  ).onTap(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TimetablePage()),
                    );
                  }),
                ),
              ),

//add class
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 8, left: 15, right: 15),
                child: Center(
                  child: NeuBox(
                    borderRadius: 15.0,
                    blurRadius: 0.0,
                    bgColor: 0xff288BA8,
                    bottomRight: 0xff90CAF9,
                    topLeft: 0xffd8d7d7,
                    distance: -2.0,
                    height: 130.0,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Row(
                        children: [
                          20.widthBox,
                          'Add Class'.text.size(22).bodyText1(context).make(),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Image.asset(
                              "./lib/assets/images/class.png",
                              width: 130,
                            ),
                          )
                        ],
                      ),
                    ),
                  ).onTap(() {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => AddClassPage()),
                    // );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

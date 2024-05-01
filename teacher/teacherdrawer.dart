import '../view/Login.dart';
import '../view/my_profile/my_profile.dart';
import '/view/HomePage.dart';

import '../const/consts.dart';
import 'TeacherHomePage.dart';

class TeacherDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFF303030),
      elevation: 16, // Add this line to set the elevation of the drawer
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            30.heightBox,
            // DrawerHeader(
            //   child: Text('My Drawer', style: TextStyle(color: Colors.white)),
            //   decoration: BoxDecoration(
            //     color: Colors.blue,
            //   ),
            // ),
            ListTile(
              leading: Icon(Icons.dashboard, color: Colors.blue),
              title: Text('Dashboard', style: TextStyle(color: Colors.white)),
              onTap: () {
                Get.back();
                Get.to(TeacherHomePage());
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.person, color: Colors.green),
            //   title: Text('Profile', style: TextStyle(color: Colors.white)),
            //   onTap: () {
            //     Get.back();
            //     Get.to(MyProfileScreen());
            //   },
            // ),
            // ListTile(
            //   leading: Icon(Icons.assessment, color: Colors.orange),
            //   title: Text('Result', style: TextStyle(color: Colors.white)),
            //   onTap: () {
            //     Get.back();
            //     Get.to(ResultPage());
            //   },
            // ),
            // ListTile(
            //   leading: Icon(Icons.assignment, color: Colors.purple),
            //   title: Text('Homework', style: TextStyle(color: Colors.white)),
            //   onTap: () {
            //     Get.back();
            //     // Get.to(HomeworkPage());
            //   },
            // ),
            // ListTile(
            //   leading: Icon(Icons.chat, color: Colors.pink),
            //   title: Text('Chat', style: TextStyle(color: Colors.white)),
            //   onTap: () {
            //     Get.back();
            //     Get.to(ChatPage());
            //   },
            // ),
            // ListTile(
            //   leading: Icon(Icons.photo_album, color: Colors.brown),
            //   title: Text('Galery', style: TextStyle(color: Colors.white)),
            //   onTap: () {
            //     Get.back();
            //     Get.to(GaleryPage());
            //   },
            // ),
            // ListTile(
            //   leading: Icon(Icons.schedule, color: Colors.teal),
            //   title: Text('Time table', style: TextStyle(color: Colors.white)),
            //   onTap: () {
            //     Get.back();
            //     Get.to(TimeTablePage());
            //   },
            // ),
            ListTile(
              leading: Icon(Icons.policy, color: Colors.blueGrey),
              title: Text('Terms and conditions',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Get.back();
                Get.to(TermsAndConditionsPage());
              },
            ),
            ListTile(
              leading: Icon(Icons.help, color: Colors.yellow),
              title: Text('Support', style: TextStyle(color: Colors.white)),
              onTap: () {
                Get.back();
                Get.to(SupportPage());
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: Colors.deepOrange),
              title: Text('About', style: TextStyle(color: Colors.white)),
              onTap: () {
                Get.back();
                Get.to(AboutPage());
              },
            ),
            ListTile(
              leading: Icon(Icons.lock, color: Colors.indigo),
              title:
                  Text('Privacy policy', style: TextStyle(color: Colors.white)),
              onTap: () {
                Get.back();
                Get.to(PrivacyPolicyPage());
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.red),
              title: Text('Log out', style: TextStyle(color: Colors.white)),
              onTap: () {
                Get.back();
                Get.to(Login());
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartavya_education_hub/firebase_options.dart';
import 'package:kartavya_education_hub/student/Graph/marksprediction.dart';
import 'package:kartavya_education_hub/view/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'admin/AdminPage.dart';

// import 'student/studentdashboard.dart';
import 'student/studentdashboard.dart';
import 'teacher/TeacherHomePage.dart';
import 'try.dart';
import 'view/IntroPage.dart';
import 'view/my_profile/my_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

String? mobile_number;
String? password;
String? role;

Future<String?> getMobileNumber() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('mobile_number');
}

Future<String?> getPassword() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('password');
}

Future<String?> getRole() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('role');
}

class _MyAppState extends State<MyApp> {
  Future<void> retrieveData() async {
    role = await getRole();
    print(role);
    password = await getPassword();
    print(password);
    mobile_number = await getMobileNumber();
    print(mobile_number);
  }

  Future<void> initializeData() async {
    await retrieveData();
    print("Role is $role");
    print("password is $password");
    print("mobile number is $mobile_number");
  }

  @override
  void initState() {
    initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'kartavya_education_hub',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blueGrey,
        ),
        useMaterial3: true,
      ),
      // home: Login(),
      home: (mobile_number == null || password == null || role == null)
          ? IntroPage()
          : (role == "admin")
              ? AdminPage()
              : (role == 'teacher')
                  ? TeacherHomePage()
                  : HomePage(),
      // home: StudentDashboard(),
      // home: OtpPage(),
    );
  }
}

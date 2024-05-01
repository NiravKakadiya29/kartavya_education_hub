import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../admin/AdminPage.dart';
import '../teacher/TeacherHomePage.dart';
import 'HomePage.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  List<String> studentsIds = [];
  List<String> teachersIds = [];
  List<String> adminIds = [];
  String? _selectedRole;
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _mobiledcontroller = TextEditingController();

  final _mobileNumberFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  Future<void> checkCredentialsAndNavigate(
    String collection,
    String mobileNumber,
    String password,
    void Function() onSuccess,
    void Function() onFailure,
  ) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(collection)
          .collection(collection)
          .where('mobile_number', isEqualTo: mobileNumber)
          .where('password', isEqualTo: password)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        onSuccess();
      } else {
        onFailure();
      }
    } catch (e) {
      print('Error checking credentials: $e');
    }
  }

  Future<List<String>> getStudentsIds() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc("students")
          .collection("students")
          .get();
      snapshot.docs.forEach((doc) {
        print("the id is ${doc.id}");
        studentsIds.add(doc.id);
      });
    } catch (e) {
      print('Error fetching document IDs: $e');
    }
    return studentsIds;
  }

  Future<List<String>> getAdminIds() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc("admin")
          .collection("admin")
          .get();
      snapshot.docs.forEach((doc) {
        print("the id is ${doc.id}");
        adminIds.add(doc.id);
      });
    } catch (e) {
      print('Error fetching document IDs: $e');
    }
    return adminIds;
  }

  Future<List<String>> getTeachersIds() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc("teachers")
          .collection("teachers")
          .get();
      snapshot.docs.forEach((doc) {
        print("the id is ${doc.id}");
        teachersIds.add(doc.id);
      });
    } catch (e) {
      print('Error fetching document IDs: $e');
    }
    return teachersIds;
  }

  static Future<void> saveCredentials(
      String mobileNumber, String password, String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("mobile_number", mobileNumber);
    await prefs.setString("password", password);
    await prefs.setString("role", role);
  }

  Future<void> initializeData() async {
    await getStudentsIds();
    await getAdminIds();
    await getTeachersIds();
  }

  final _formKey = GlobalKey<FormState>();
  String? _mobileNumber;
  String? _password;

  @override
  void initState() {
    initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(255, 255, 255, 0.5),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const SizedBox(height: 150),
              Text(
                "Welcome",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Text(
                "Continue to your account",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 60),
              DropdownButton<String>(
                hint: Text('Select your role'),
                value: _selectedRole,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRole = newValue;
                  });
                },
                items: <String>['Admin', 'Teacher', 'Student']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              TextFormField(
                controller: _mobiledcontroller,
                focusNode: _mobileNumberFocusNode,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Mobile Number",
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onFieldSubmitted: (_) {
                  _mobileNumberFocusNode.unfocus();
                  FocusScope.of(context).requestFocus(_passwordFocusNode);
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Mobile Number.";
                  }
                  _mobileNumber = value;
                  return null;
                },
                onSaved: (value) {
                  _mobileNumber = value;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordcontroller,
                focusNode: _passwordFocusNode,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.password),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Password.";
                  }
                  _password = value;
                  return null;
                },
                onSaved: (value) {
                  _password = value;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () async {
                  if (_selectedRole == "Admin") {
                    if (adminIds.contains(_mobiledcontroller.text.trim())) {
                      await checkCredentialsAndNavigate(
                          "admin",
                          _mobiledcontroller.text.trim(),
                          _passwordcontroller.text.trim(), () {
                        saveCredentials(_mobiledcontroller.text.trim(),
                            _passwordcontroller.text.trim(), 'admin');
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AdminPage(),
                        ));
                      }, () {
                        Get.snackbar(
                          'Wrong password',
                          'Please enter the correct password',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.black87,
                          colorText: Colors.white,
                          duration: Duration(seconds: 3),
                        );
                      });
                    } else {
                      print("Mobile number is not exist");
                      Get.snackbar(
                        'Admin is not authorized',
                        'Please check your mobile number',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.black87,
                        colorText: Colors.white,
                        duration: Duration(seconds: 3),
                      );
                    }
                  } else if (_selectedRole == "Teacher") {
                    if (teachersIds.contains(_mobiledcontroller.text.trim())) {
                      await checkCredentialsAndNavigate(
                          "teachers",
                          _mobiledcontroller.text.trim(),
                          _passwordcontroller.text.trim(), () {
                        saveCredentials(_mobiledcontroller.text.trim(),
                            _passwordcontroller.text.trim(), 'teacher');

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TeacherHomePage(),
                        ));
                      }, () {
                        Get.snackbar(
                          'Wrong password',
                          'Please enter the correct password',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.black87,
                          colorText: Colors.white,
                          duration: Duration(seconds: 3),
                        );
                      });
                    } else {
                      print("Mobile number is not exist");
                      Get.snackbar(
                        'Teacher is not authorized',
                        'Please connect the admin',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.black87,
                        colorText: Colors.white,
                        duration: Duration(seconds: 3),
                      );
                    }
                  } else if (_selectedRole == "Student") {
                    if (studentsIds.contains(_mobiledcontroller.text.trim())) {
                      await checkCredentialsAndNavigate(
                          "students",
                          _mobiledcontroller.text.trim(),
                          _passwordcontroller.text.trim(), () {
                        saveCredentials(_mobiledcontroller.text.trim(),
                            _passwordcontroller.text.trim(), 'student');

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ));
                      }, () {
                        Get.snackbar(
                          'Wrong password',
                          'Please enter the correct password',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.black87,
                          colorText: Colors.white,
                          duration: Duration(seconds: 3),
                        );
                      });
                    } else {
                      print("Mobile number is not exist");
                      Get.snackbar(
                        'Student is not authorized',
                        'Please connect the admin',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.black87,
                        colorText: Colors.white,
                        duration: Duration(seconds: 3),
                      );
                    }
                  } else {}
                  // if (_formKey.currentState!.validate()) {
                  //   _formKey.currentState!.save();
                  //   User? user = await authenticateUser(_mobileNumber!, _password!);
                  //   if (user == null) {
                  //     // If the user is not authenticated, display an error message
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(content: Text("Invalid mobile number or password")),
                  //     );
                  //   } else {
                  //     // If the user is authenticated, navigate to the appropriate screen
                  //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage(),));
                  //   }
                  // }
                },
                child: const Text("Validate"),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Future<User?> authenticateUser(String mobileNumber, String password) async {
//   // Check if the mobile number and password match an admin user in Firestore
//   QuerySnapshot adminSnapshot = await FirebaseFirestore.instance
//       .collection('users')
//       .where('mobileNumber', isEqualTo: mobileNumber)
//       .where('role', isEqualTo: 'admin')
//       .get();
//   if (adminSnapshot.docs.isNotEmpty &&
//       adminSnapshot.docs[0]['password'] == password) {
//     // If the admin user is authenticated, return the User object
//     return FirebaseAuth.instance.currentUser;
//   }
//
//   // Check if the mobile number and password match a student or teacher user in Firestore
//   QuerySnapshot userSnapshot = await FirebaseFirestore.instance
//       .collection('users')
//       .where('mobileNumber', isEqualTo: mobileNumber)
//       .where('password', isEqualTo: password)
//       .get();
//   if (userSnapshot.docs.isNotEmpty) {
//     // If the studentor teacher user is authenticated, return the User object
//     return FirebaseAuth.instance.currentUser;
//   }
//
//   // If the user is not authenticated, return null
//   return null;
// }

// void navigateUser(User user) {
//   if (user.uid.startsWith('admin')) {
//     // If the user is an admin, navigate to the admin screen
//     Get.offAll(() => AdminPage());
//   } else if (user.uid.startsWith('student')) {
//     // If the user is a student, navigate to the home screen
//     Get.offAll(() => const HomePage());
//   } else if (user.uid.startsWith('teacher')) {
//     // If the user is a teacher, navigate to the teacher panel
//     Get.offAll(() => const TeacherPage());
//   }
// }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile {
  String name;
  String email;
  String phoneNumber;
  String address;
  DateTime dateOfBirth;
  String gender;
  String occupation;

  UserProfile({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.dateOfBirth,
    required this.gender,
    required this.occupation,
  });
}

class EditProfileScreen extends StatefulWidget {
  final UserProfile userProfile;

  const EditProfileScreen({Key? key, required this.userProfile})
      : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.userProfile.dateOfBirth;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name:'),
            TextField(
              controller: TextEditingController(text: widget.userProfile.name),
              onChanged: (value) {
                // Update name
                widget.userProfile.name = value;
              },
            ),
            SizedBox(height: 20),
            Text('Email:'),
            TextField(
              controller: TextEditingController(text: widget.userProfile.email),
              onChanged: (value) {
                // Update email
                widget.userProfile.email = value;
              },
            ),
            SizedBox(height: 20),
            Text('Phone Number:'),
            TextField(
              controller:
                  TextEditingController(text: widget.userProfile.phoneNumber),
              onChanged: (value) {
                // Update phone number
                widget.userProfile.phoneNumber = value;
              },
            ),
            SizedBox(height: 20),
            Text('Address:'),
            TextField(
              controller:
                  TextEditingController(text: widget.userProfile.address),
              onChanged: (value) {
                // Update address
                widget.userProfile.address = value;
              },
            ),
            SizedBox(height: 20),
            Text('Date of Birth:'),
            InkWell(
              onTap: () {
                _selectDate(context);
              },
              child: Row(
                children: [
                  Text(
                    "${_selectedDate.toLocal()}".split(' ')[0],
                    style: TextStyle(fontSize: 16),
                  ),
                  Icon(Icons.calendar_today),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text('Gender:'),
            TextField(
              controller:
                  TextEditingController(text: widget.userProfile.gender),
              onChanged: (value) {
                // Update gender
                widget.userProfile.gender = value;
              },
            ),
            SizedBox(height: 20),
            Text('Occupation:'),
            TextField(
              controller:
                  TextEditingController(text: widget.userProfile.occupation),
              onChanged: (value) {
                // Update occupation
                widget.userProfile.occupation = value;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate back to profile screen and pass updated profile data
                Navigator.pop(context, widget.userProfile);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  // Initialize user profile with some default values
  UserProfile userProfile = UserProfile(
    name: 'Nirav Kakadiya',
    email: 'nirav.doe@example.com',
    phoneNumber: '+91-9265479767',
    address: '123 Main St, City, Country',
    dateOfBirth: DateTime(2003, 10, 29),
    gender: 'Male',
    occupation: 'Software Engineer',
  );

  // Controller for editing profile fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();

  String? mobile_number;

  Future<String?> getMobileNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('mobile_number');
  }

  Future<void> retrieveData() async {
    mobile_number = await getMobileNumber();
    print(mobile_number);
  }

  Future<void> initializeData() async {
    await retrieveData();
    print("mobile number is $mobile_number");
  }

  Future<DocumentSnapshot> getDocument() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc('students')
        .collection("students")
        .doc(mobile_number)
        .get();

    return documentSnapshot;
  }

  @override
  void initState() {
    initializeData();
    getDocument();
    super.initState();
    // Set initial values of text controllers to user profile data
    nameController.text = userProfile.name;
    emailController.text = userProfile.email;
    phoneNumberController.text = userProfile.phoneNumber;
    addressController.text = userProfile.address;
    dateOfBirthController.text = userProfile.dateOfBirth.toString();
    genderController.text = userProfile.gender;
    occupationController.text = userProfile.occupation;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: getDocument(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                  child:
                      CircularProgressIndicator())); // Show loading indicator
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return Text('Document does not exist');
        }

        var data = snapshot.data!;

// Display the data
        return Scaffold(
          appBar: AppBar(
            title: Text('My Profile'),
            actions: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  _navigateToEditProfileScreen(context);
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CircleAvatar(
                //     radius: 50,
                //     backgroundImage: NetworkImage(data['profile_photo'])),
                SizedBox(height: 20),
                Text(
                  'Name:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  data!['name']?.toString() ?? 'Default Name',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  'Email:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  data!['email']?.toString() ?? 'Default Name',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  'Phone Number:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  data!['mobile_number']?.toString() ?? 'Default Name',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  'Address:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  data!['address']?.toString() ?? 'Default Name',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  'Date of Birth:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  data!['dob']?.toString() ?? 'Default Name',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  'Gender:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  data!['gender']?.toString() ?? 'Default Name',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  'Occupation:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  data!['role']?.toString() ?? 'Default Name',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _navigateToEditProfileScreen(BuildContext context) async {
    final updatedProfile = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(userProfile: userProfile),
      ),
    );

    if (updatedProfile != null) {
      setState(() {
        userProfile = updatedProfile;
      });
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: MyProfileScreen(),
  ));
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class StudentForm extends StatefulWidget {
  final String standard;

  const StudentForm({Key? key, required this.standard}) : super(key: key);

  @override
  _StudentFormState createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  // Define focus nodes for each text field
  final _nameFocusNode = FocusNode();
  final _mobileNumberFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _rollNumberFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _selectedGender = 'Male'; // Default gender selection

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobile_numberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _roll_numberController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(20.0),
            height: MediaQuery.of(context).size.height *
                0.80, // Set the height to 75% of the screen height
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Add Information',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                    focusNode: _nameFocusNode,
                    decoration: InputDecoration(labelText: 'Name'),
                    onFieldSubmitted: (_) {
                      _nameFocusNode.unfocus();
                      FocusScope.of(context)
                          .requestFocus(_mobileNumberFocusNode);
                    },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: _mobile_numberController,
                    focusNode: _mobileNumberFocusNode,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mobile number is required';
                      } else if (value.length != 10) {
                        return 'Mobile number must be 10 digits';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'mobile_number', counterText: ''),
                    onFieldSubmitted: (_) {
                      _nameFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(_emailFocusNode);
                    },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Email is required';
                    //   }
                    //   return null;
                    // },
                    decoration: InputDecoration(labelText: 'email'),
                    onFieldSubmitted: (_) {
                      _nameFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'password is required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'password'),
                    onFieldSubmitted: (_) {
                      _nameFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(_rollNumberFocusNode);
                    },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: _roll_numberController,
                    focusNode: _rollNumberFocusNode,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'roll_number is required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'roll_number'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Date of Birth:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () async {
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
                    },
                    child: Text(
                      _selectedDate == null
                          ? 'Select Date'
                          : DateFormat('dd MMMM yyyy').format(_selectedDate),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Gender:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 'Male',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value.toString();
                          });
                        },
                      ),
                      Text('Male'),
                      Radio(
                        value: 'Female',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value.toString();
                          });
                        },
                      ),
                      Text('Female'),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: _addressController,
                    focusNode: _addressFocusNode,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'address is required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'address'),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Store data into Firestore
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc('students')
                            .collection('students')
                            .doc(_mobile_numberController.text)
                            .set({
                          'name': _nameController.text,
                          'mobile_number': _mobile_numberController.text,
                          'address': _addressController.text,
                          'email': _emailController.text,
                          'gender': _selectedGender,
                          'password': _passwordController.text,
                          'role': 'student',
                          'roll_number': _roll_numberController.text,
                          'class': widget.standard,
                          'dob':
                              DateFormat('dd MMMM yyyy').format(_selectedDate!),
                        }).then((_) {
                          print('Data added successfully!');
                          // Clear the text fields
                          _nameController.clear();
                          _mobile_numberController.clear();
                          _emailController.clear();
                          _passwordController.clear();
                          _roll_numberController.clear();
                          _addressController.clear();
                          // Close the bottom sheet
                          Navigator.pop(context);
                        }).catchError((error) {
                          print('Failed to add data: $error');
                          // Handle error if needed
                        });
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

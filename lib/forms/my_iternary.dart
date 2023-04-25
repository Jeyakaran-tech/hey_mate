import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';



class MyIternary extends StatefulWidget {
  const MyIternary({Key? key}) : super(key: key);

  @override
  _MyIternaryState createState() => _MyIternaryState();
}

class _MyIternaryState extends State<MyIternary> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  void _saveData(
    String firstName, 
    String lastName,
    String email,
    String flightNumber
  ) {
    _firestore.collection('myIternary').add({
      'FirstName': firstName,
      'LastName': lastName,
      'Email': email,
      'FlightNumber': flightNumber,
    });
  }

  final _myiternaryKey = GlobalKey<FormState>();

  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _flightNumber = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child:  Form(
        key: _myiternaryKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'First Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your First name';
                }
                return null;
              },
              onSaved: (value) {
                _firstName = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Last Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Last name';
                }
                return null;
              },
              onSaved: (value) {
                _lastName = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!EmailValidator.validate(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
              onSaved: (value) {
                _email = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Flight Number'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Flight Number';
                }
                return null;
              },
              onSaved: (value) {
                _lastName = value!;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_myiternaryKey.currentState!.validate()) {
                  _myiternaryKey.currentState!.save();
                  _saveData(_firstName, _lastName, _email, _flightNumber);
                  Navigator.pop(context);
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

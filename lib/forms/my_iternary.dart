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


  void _saveData(String name, String email) {
  _firestore.collection('users').add({
    'name': name,
    'email': email,
  });
}

  final _myiternaryKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _myiternaryKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
            onSaved: (value) {
              _name = value!;
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
          ElevatedButton(
            onPressed: () {
              if (_myiternaryKey.currentState!.validate()) {
                _myiternaryKey.currentState!.save();
                _saveData(_name, _email);
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}

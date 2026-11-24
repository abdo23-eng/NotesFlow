import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:notes/users.dart';

class Gender extends StatefulWidget {
  final String email;
  final String name;
  final String id;

  const Gender({
    super.key,
    required this.email,
    required this.name,
    required this.id,
  });
  @override
  State<StatefulWidget> createState() {
    return Sgender();
  }
}

class Sgender extends State<Gender> {
  bool male = true;
  bool fmale = false;
  bool login = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 243, 224, 195),
        padding: EdgeInsets.all(20),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Notes',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 124, 62, 58),
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Flow',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 241, 143, 142),
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              'choose your gender :',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 124, 62, 58),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                setState(() {
                  male = true;
                  fmale = false;
                });
              },
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                    color: male
                        ? const Color.fromARGB(255, 124, 62, 58)
                        : const Color.fromARGB(255, 246, 121, 118),
                  ),
                  borderRadius: BorderRadius.circular(30),
                  color: male
                      ? const Color.fromARGB(255, 233, 213, 182)
                      : const Color.fromARGB(255, 243, 224, 195),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/boy.png', width: 160),
                    SizedBox(height: 20),
                    Text(
                      'Male',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: male
                            ? const Color.fromARGB(255, 124, 62, 58)
                            : const Color.fromARGB(255, 246, 121, 118),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                setState(() {
                  male = false;
                  fmale = true;
                });
              },
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                    color: fmale
                        ? const Color.fromARGB(255, 124, 62, 58)
                        : const Color.fromARGB(255, 246, 121, 118),
                  ),
                  borderRadius: BorderRadius.circular(30),
                  color: fmale
                      ? const Color.fromARGB(255, 233, 213, 182)
                      : const Color.fromARGB(255, 243, 224, 195),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/woman.png', width: 160),
                    SizedBox(height: 20),
                    Text(
                      'Female',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: fmale
                            ? const Color.fromARGB(255, 124, 62, 58)
                            : const Color.fromARGB(255, 246, 121, 118),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(20),
              child: MaterialButton(
                onPressed: () async {
                  int? gen;
                  if (male) {
                    gen = 0;
                  }
                  if (fmale) {
                    gen = 1;
                  }
                  Users u1 = Users(
                    username: widget.name,
                    email: widget.email,
                    id: widget.id,
                    selctedProfile: gen,
                  );
                  setState(() {
                    login = true;
                  });
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('UserData') 
                      .add(u1.toFirestore());
                  Navigator.of(context).pushReplacementNamed("sign_in");
                },
                color: const Color.fromARGB(255, 124, 62, 58),
                height: 60,
                child: login 
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: const Color.fromARGB(255, 243, 224, 195),
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Continuing...',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 243, 224, 195),
                              fontSize: 20,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        'Continue',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 243, 224, 195),
                          fontSize: 20,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

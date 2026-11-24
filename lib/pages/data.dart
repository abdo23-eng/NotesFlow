import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Data extends StatefulWidget {
  final String title;
  final String note;
  final String date;
  final String id;
  Data({
    super.key,
    required this.title,
    required this.note,
    required this.date,
    required this.id,
  });
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DatState();
  }
}

class DatState extends State<Data> {
  TextEditingController ti = TextEditingController();
  TextEditingController conten = TextEditingController();
  bool don = false;
  bool edit = false;
  String? uid;
  @override
  void initState() {
    ti.text = widget.title;
    conten.text = widget.note;
    uid = FirebaseAuth.instance.currentUser!.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        color: const Color.fromARGB(255, 243, 224, 195),
        child: ListView(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.only(left: 9),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 241, 143, 142),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: const Color.fromARGB(255, 124, 62, 58),
                    ),
                  ),
                ),
                SizedBox(width: 50),
                Text(
                  'Notes',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                    color: const Color.fromARGB(255, 124, 62, 58),
                  ),
                ),
                Text(
                  'Flow',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    height: 1.0,
                    color: const Color.fromARGB(255, 241, 143, 142),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Container(
              height: 500,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 233, 213, 182),
                border: Border.all(
                  width: 2.5,
                  color: const Color.fromARGB(255, 241, 143, 142),
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListView(
                children: [
                  SizedBox(height: 10),
                  TextField(
                    controller: ti,
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,

                      enabled: edit,
                    ),
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: const Color.fromARGB(255, 124, 62, 58),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: conten,
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabled: edit,
                    ),
                    style: TextStyle(
                      fontWeight: FontWeight(450),
                      fontSize: 18,
                      color: const Color.fromARGB(255, 124, 62, 58),
                    ),
                    textAlign: TextAlign.left,
                    maxLines: 15,
                    minLines: 1,
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.date,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: const Color.fromARGB(255, 124, 62, 58),
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 70),
            edit
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () async {
                          setState(() {
                            don = true;
                          });
                          try {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(uid)
                                .collection('notes')
                                .doc(widget.id)
                                .update({
                                  'title': ti.text,
                                  'content': conten.text,
                                });

                            setState(() {
                              edit = false;
                              don = false;
                            });
                          } catch (e) {
                            don = false;
                            print(
                              '=============================================error',
                            );
                          }
                        },
                        color: Color.fromARGB(255, 241, 143, 142),
                        height: 60,
                        minWidth: 250,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: don
                            ? Row(
                                children: [
                                  CircularProgressIndicator(
                                    color: const Color.fromARGB(
                                      255,
                                      124,
                                      62,
                                      58,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    'Saving...',
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                        255,
                                        124,
                                        62,
                                        58,
                                      ),
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                'Save',
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 124, 62, 58),
                                  fontSize: 20,
                                ),
                              ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              actionsAlignment: MainAxisAlignment.spaceBetween,
                              shape: Border.all(
                                width: 2.5,
                                color: const Color.fromARGB(255, 243, 224, 195),
                              ),
                              title: Text('Sure!'),
                              titleTextStyle: TextStyle(
                                color: const Color.fromARGB(255, 124, 62, 58),
                                fontSize: 25,
                                fontWeight: FontWeight(700),
                              ),
                              backgroundColor: const Color.fromARGB(
                                255,
                                239,
                                161,
                                160,
                              ),
                              contentTextStyle: TextStyle(
                                color: const Color.fromARGB(255, 124, 62, 58),
                                fontSize: 16,
                              ),
                              
                              content: Text('Do you wanaa delete this note.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                        255,
                                        243,
                                        224,
                                        195,
                                      ),
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                  await  FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(uid)
                                        .collection('notes')
                                        .doc(widget.id)
                                        .delete();
                                    Navigator.pop(context);
                                    Navigator.pop(context);

                                  },
                                  child: Text(
                                    'OK',
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                        255,
                                        243,
                                        224,
                                        195,
                                      ),
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        color: Color.fromARGB(255, 241, 143, 142),
                        height: 60,
                        minWidth: 110,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Delete',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 124, 62, 58),
                            fontSize: 20,
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            edit = true;
                          });
                        },
                        color: Color.fromARGB(255, 241, 143, 142),
                        height: 60,
                        minWidth: 110,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Edit',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 124, 62, 58),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

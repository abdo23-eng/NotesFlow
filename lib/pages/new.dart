import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/Note.dart';
import 'package:intl/intl.dart';

class Create extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CreateState();
  }
}

class CreateState extends State<Create> {
  bool home = false;
  bool user = false;
  bool work = false;
  bool ideas = false;
  bool shope = false;
  bool meeting = false;
  
  String formate = DateFormat('yyyy-mm-dd').format(DateTime.now());
  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();
  Future<void> addNewNote(
    List<String> coll,
    String ti,
    String note,
    String form,
  ) async {
   

    NoteModel newNote = NoteModel(
      title: ti,
      content: note,
      categories: coll, 
      dateTime: form,
    );
    final User? user1 = FirebaseAuth.instance.currentUser;
    if(user1 != null){
       String uid = user1.uid ; 
    
    await FirebaseFirestore.instance.collection('users').doc(uid)
        .collection('notes')
        .add(newNote.toFirestore());
    }
  }

  List<String> collection = [];
  bool down = false; 

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: down
          ? Container( 
            width: double.infinity, 
            color: const Color.fromARGB(255, 243, 224, 195),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator( 
                    color: const Color.fromARGB(255, 241, 143, 142),
                  ),
                  SizedBox(height: 10,), 
                  Text('Saving...' , style: TextStyle(
                    fontSize: 15 , 
                    color: const Color.fromARGB(255, 124, 62, 58),
                    fontWeight: FontWeight(400),

                  ),)
              ],
            ),
          )
          : Container(
              color: const Color.fromARGB(255, 243, 224, 195),
              padding: EdgeInsets.all(20),
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
                                offset: Offset(
                                  0,
                                  3,
                                ), // changes position of shadow
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
                  SizedBox(height: 50),
                  TextField(
                    controller: title,
                    style: TextStyle(
                      fontSize: 17,
                      color: const Color.fromARGB(255, 124, 62, 58),
                      fontWeight: FontWeight(700),
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 233, 213, 182),
                      hintText: 'Enter the Title',
                      hintStyle: TextStyle(
                        color: const Color.fromARGB(255, 182, 158, 123),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    minLines: 1,
                    maxLines: 1,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: note,
                    style: TextStyle(
                      fontSize: 17,
                      color: const Color.fromARGB(255, 124, 62, 58),
                      fontWeight: FontWeight(700),
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 233, 213, 182),
                      hintText: 'your note...',
                      hintStyle: TextStyle(
                        color: const Color.fromARGB(255, 182, 158, 123),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    minLines: 5,
                    maxLines: 5,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Choose :',
                        style: TextStyle(
                          fontSize: 17,
                          color: const Color.fromARGB(255, 193, 112, 117),
                          fontWeight: FontWeight(500),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(width: 60),
                      InkWell(
                        onTap: () {
                          setState(() {
                            home ? home = false : home = true;
                          });
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 40,
                          width: 100,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 241, 143, 142),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: home
                                  ? Color.fromARGB(255, 124, 62, 58)
                                  : const Color.fromARGB(255, 243, 224, 195),
                              width: 1.7,
                            ),
                          ),
                          child: home
                              ? Image.asset(
                                  'images/home.png',
                                  color: const Color.fromARGB(
                                    255,
                                    243,
                                    224,
                                    195,
                                  ),
                                )
                              : Image.asset(
                                  'images/home (1).png',
                                  color: const Color.fromARGB(
                                    255,
                                    243,
                                    224,
                                    195,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(width: 50),
                      InkWell(
                        onTap: () {
                          setState(() {
                            user ? user = false : user = true;
                          });
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 40,
                          width: 100,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 241, 143, 142),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: user
                                  ? Color.fromARGB(255, 124, 62, 58)
                                  : const Color.fromARGB(255, 243, 224, 195),
                              width: 1.7,
                            ),
                          ),
                          child: user
                              ? Image.asset(
                                  'images/user (1).png',
                                  color: const Color.fromARGB(
                                    255,
                                    243,
                                    224,
                                    195,
                                  ),
                                )
                              : Image.asset(
                                  'images/user.png',
                                  color: const Color.fromARGB(
                                    255,
                                    243,
                                    224,
                                    195,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      SizedBox(width: 60),
                      InkWell(
                        onTap: () {
                          setState(() {
                            work ? work = false : work = true;
                          });
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 40,
                          width: 100,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 241, 143, 142),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: work
                                  ? Color.fromARGB(255, 124, 62, 58)
                                  : const Color.fromARGB(255, 243, 224, 195),
                              width: 1.7,
                            ),
                          ),
                          child: work
                              ? Image.asset(
                                  'images/briefcase (3).png',
                                  color: const Color.fromARGB(
                                    255,
                                    243,
                                    224,
                                    195,
                                  ),
                                )
                              : Image.asset(
                                  'images/briefcase (1).png',
                                  color: const Color.fromARGB(
                                    255,
                                    243,
                                    224,
                                    195,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(width: 50),
                      InkWell(
                        onTap: () {
                          setState(() {
                            ideas ? ideas = false : ideas = true;
                          });
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 40,
                          width: 100,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 241, 143, 142),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: ideas
                                  ? Color.fromARGB(255, 124, 62, 58)
                                  : const Color.fromARGB(255, 243, 224, 195),
                              width: 1.7,
                            ),
                          ),
                          child: ideas
                              ? Image.asset(
                                  'images/bulb (1).png',
                                  color: const Color.fromARGB(
                                    255,
                                    243,
                                    224,
                                    195,
                                  ),
                                )
                              : Image.asset(
                                  'images/bulb.png',
                                  color: const Color.fromARGB(
                                    255,
                                    243,
                                    224,
                                    195,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            shope ? shope = false : shope = true;
                          });
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 40,
                          width: 100,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 241, 143, 142),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: shope
                                  ? Color.fromARGB(255, 124, 62, 58)
                                  : const Color.fromARGB(255, 243, 224, 195),
                              width: 1.7,
                            ),
                          ),
                          child: shope
                              ? Image.asset(
                                  'images/shopping-cart (1).png',
                                  color: const Color.fromARGB(
                                    255,
                                    243,
                                    224,
                                    195,
                                  ),
                                )
                              : Image.asset(
                                  'images/shopping-cart.png',
                                  color: const Color.fromARGB(
                                    255,
                                    243,
                                    224,
                                    195,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 80),

                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: const Color.fromARGB(255, 241, 143, 142),
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      width: 200,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(30),
                        child: MaterialButton(
                          onPressed: () async {
                            if (work) {
                              collection.add('Work');
                            }
                            if (ideas) {
                              collection.add('Ideas');
                            }
                            if (shope) {
                              collection.add('Shopping');
                            }
                            if (user) {
                              collection.add('Personal');
                            }
                            String formate = DateFormat(
                              'dd MMM yyy',
                            ).format(DateTime.now());
                            down = true ; 
                            setState(() {
                              
                            });
                            await addNewNote(
                              collection,
                              title.text,
                              note.text,
                              formate,
                            );
                            down = false;
                            
                            Navigator.pushReplacementNamed(context, 'home');
                          },
                          color: const Color.fromARGB(255, 243, 224, 195),
                          child: Text(
                            'Save',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 124, 62, 58),
                              fontSize: 20,
                              fontWeight: FontWeight(600),
                            ),
                          ),
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

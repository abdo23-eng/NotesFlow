import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/users.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  bool home = true;
  bool settings = false;

  Stream<QuerySnapshot> getUser() {
    User? user1 = FirebaseAuth.instance.currentUser;
    String uid = user1!.uid;
    var fireStoreRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('UserData');
    return fireStoreRef.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color.fromARGB(255, 243, 224, 195),
        child: StreamBuilder(
          stream: getUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: const Color.fromARGB(255, 241, 143, 142),
                ),
              );
            }
            List<Users> allNotes = snapshot.data!.docs.map((doc) {
              return Users.fromFirestore(
                doc.data() as Map<String, dynamic>,
                doc.id,
              );
            }).toList();
            return ListView.builder(
              itemCount: allNotes.length,
              itemBuilder: (context, index) {
                final user = allNotes[index];
                return Container(
                  height: 400,
                  color: const Color.fromARGB(255, 243, 224, 195),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          UserAccountsDrawerHeader(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 224, 199, 162),
                            ),
                            accountName: Text(
                              user.username!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 124, 62, 58),
                              ),
                            ),
                            accountEmail: Text(
                              user.email!,
                              style: TextStyle(
                                fontSize: 12,
                                color: const Color.fromARGB(255, 124, 62, 58),
                              ),
                            ),
                            currentAccountPicture: CircleAvatar(
                              backgroundColor: const Color.fromARGB(
                                255,
                                228,
                                205,
                                169,
                              ),
                              backgroundImage: AssetImage(
                                user.selctedProfile == 0
                                    ? 'assets/boy.png'
                                    : 'assets/girl.png',
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: home
                                  ? const Color.fromARGB(255, 227, 174, 173)
                                  : const Color.fromARGB(255, 243, 224, 195),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 6),
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            child: ListTile(
                              leading: Icon(
                                Icons.home,
                                color: const Color.fromARGB(255, 124, 62, 58),
                              ),
                              title: Text(
                                'Home',
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 124, 62, 58),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  home = true;
                                  settings = false;
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ),

                          ListTile(
                            leading: Icon(
                              Icons.logout,
                              color: const Color.fromARGB(255, 124, 62, 58),
                            ),
                            title: Text(
                              'Logout',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 124, 62, 58),
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  shape: Border.all(
                                    width: 2.5,
                                    color: const Color.fromARGB(
                                      255,
                                      243,
                                      224,
                                      195,
                                    ),
                                  ),
                                  title: Text('Warning'),
                                  titleTextStyle: TextStyle(
                                    color: const Color.fromARGB(
                                      255,
                                      124,
                                      62,
                                      58,
                                    ),
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
                                    color: const Color.fromARGB(
                                      255,
                                      124,
                                      62,
                                      58,
                                    ),
                                    fontSize: 16,
                                  ),
                                  content: Text('Sure you want to logout?'),
                                  actions: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                          TextButton(
                                      onPressed: () {
                                       Navigator.pop(context);
                                      },
                                      child: Text(
                                        'cancel',
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
                                          onPressed: () {
                                            FirebaseAuth.instance.signOut().then((
                                              value,
                                            ) {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                'sign_in',
                                              );
                                            });
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

                                  ],
                                ),
                              );
                              // Handle logout tap
                            },
                          ),
                        ],
                      ),
                      Positioned(
                        right: 5,
                        child: Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Notes',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  height: 1.0,
                                  color: const Color.fromARGB(255, 124, 62, 58),
                                ),
                              ),
                              Text(
                                'Flow',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  height: 1.0,
                                  color: const Color.fromARGB(
                                    255,
                                    241,
                                    143,
                                    142,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

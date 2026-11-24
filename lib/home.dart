import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/pages/drawer.dart';
import 'pages/all.dart';
import 'pages/personal.dart';
import 'pages/work.dart';
import 'pages/ideas.dart';
import 'pages/shope.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'All';
  int selecte = 0;
  bool home = true;
  bool user = false;
  bool work = false;
  bool ideas = false;
  bool shope = false;
  bool meeting = false;
  bool search = false;
  TextEditingController sea = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: const Color.fromARGB(255, 124, 62, 58),
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: const Color.fromARGB(255, 190, 186, 186),
              offset: Offset(2, 3),
              spreadRadius: 0.5,
            ),
          ],
        ),
        width: 150,
        height: 50,
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(30),
          child: MaterialButton(
            onPressed: () {
              Navigator.pushNamed(context, 'Add');
            },
            color: const Color.fromARGB(255, 241, 143, 142),
            child: Row(
              children: [
                Icon(
                  Icons.add,
                  color: const Color.fromARGB(255, 124, 62, 58),
                  size: 30,
                ),
                Text(
                  'New note',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 124, 62, 58),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      drawer: Drawer(child: DrawerPage()),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: const Color.fromARGB(255, 243, 224, 195),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Builder(
                  builder: (context) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.menu,
                            size: 35.0,
                            color: const Color.fromARGB(255, 241, 143, 142),
                          ),
                          Text(
                            'Menu',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 124, 62, 58),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
            Text(
              'Hello, User',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 23,
                height: 1.0,
                color: const Color.fromARGB(255, 124, 62, 58),
              ),
            ),

            Row(
              children: [
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

            SizedBox(height: 15),
            Form(
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(20),
                child: TextFormField(
                  controller: sea,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    filled: true,
                    fillColor: const Color.fromARGB(255, 233, 213, 182),
                    hintText: 'Search your notes...',
                    hintStyle: TextStyle(
                      color: const Color.fromARGB(255, 182, 158, 123),
                      fontSize: 18,
                    ),
                    focusedBorder: InputBorder.none,
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(12),
                      child: SizedBox(
                        width: 10,
                        height: 10,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (sea.text != "") {
                                search == true;
                              }
                            });
                          },
                          child: Image.asset(
                            'images/search.png',
                            width: 15,
                            height: 15,
                            color: const Color.fromARGB(255, 182, 158, 123),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 500,
              height: 100,
              padding: EdgeInsets.symmetric(vertical: 10),
              margin: EdgeInsets.only(top: 10),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      setState(() {
                        home = true;
                        user = false;
                        work = false;
                        ideas = false;
                        shope = false;
                        meeting = false;
                        selecte = 0;
                      });
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: 70,
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
                        Text(
                          'All',
                          style: TextStyle(
                            fontSize: 15,
                            color: const Color.fromARGB(255, 124, 62, 58),
                            fontWeight: FontWeight(500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      setState(() {
                        home = false;
                        user = true;
                        work = false;
                        ideas = false;
                        shope = false;
                        meeting = false;
                        selecte = 1;
                      });
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: 70,
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
                        Text(
                          'Personal',
                          style: TextStyle(
                            fontSize: 15,
                            color: const Color.fromARGB(255, 124, 62, 58),
                            fontWeight: FontWeight(500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      setState(() {
                        home = false;
                        user = false;
                        work = true;
                        ideas = false;
                        shope = false;
                        meeting = false;
                        selecte = 2;
                      });
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: 70,
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
                        Text(
                          'Work',
                          style: TextStyle(
                            fontSize: 15,
                            color: const Color.fromARGB(255, 124, 62, 58),
                            fontWeight: FontWeight(500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      setState(() {
                        home = false;
                        user = false;
                        work = false;
                        ideas = true;
                        shope = false;
                        meeting = false;
                        selecte = 3;
                      });
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: 70,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 241, 143, 142),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: ideas
                                  ? const Color.fromARGB(255, 124, 62, 58)
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
                        Text(
                          'Ideas',
                          style: TextStyle(
                            fontSize: 15,
                            color: const Color.fromARGB(255, 124, 62, 58),
                            fontWeight: FontWeight(500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 15),
                  InkWell(
                    onTap: () {
                      setState(() {
                        home = false;
                        user = false;
                        work = false;
                        ideas = false;
                        shope = true;
                        meeting = false;
                        selecte = 4;
                      });
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          width: 70,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 241, 143, 142),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: shope
                                  ? const Color.fromARGB(255, 124, 62, 58)
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
                        Text(
                          'Shopping',
                          style: TextStyle(
                            fontSize: 15,
                            color: const Color.fromARGB(255, 124, 62, 58),
                            fontWeight: FontWeight(500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 550,
              child: switch (selecte) {
                0 => All(state: search, query: sea.text),
                1 => Personal(state: search, query: sea.text),
                2 => Work(state: search, query: sea.text),
                3 => Ideas(state: search, query: sea.text),
                4 => Shope(state: search, query: sea.text),
                _ => All(state: search, query: sea.text),
              },
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        color: const Color.fromARGB(255, 243, 224, 195),
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
            SizedBox(height: 20),
            Image.asset( 
              'images/1.png',
              width: 350,
              height: 350,
              fit: BoxFit.cover, 
            ),
            SizedBox(height: 50), 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Start your smart blogging ',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 124, 62, 58),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'journey with us',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 124, 62, 58),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Discover the power of words and ideas',
                  style: TextStyle(
                    fontSize: 17,
                    color: const Color.fromARGB(255, 202, 121, 119),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row( 
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '.',
                  style: TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 124, 62, 58),
                  ),
                ),
                Text(
                  '.',
                  style: TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.withOpacity(0.2),
                  ),
                ),
                Text(
                  '.',
                  style: TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.withOpacity(0.2),
                  ),
                ),
              ],
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'second');
              },
              color: const Color.fromARGB(255, 241, 143, 142),
              height: 60,
              minWidth: double.infinity,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Next',
                style: TextStyle(
                  color: const Color.fromARGB(255, 124, 62, 58),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

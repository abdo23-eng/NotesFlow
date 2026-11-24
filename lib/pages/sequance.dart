import 'package:flutter/material.dart';

class SequancePage extends StatefulWidget {
  const SequancePage({super.key});

  @override
  State<SequancePage> createState() => SequancePageState();
}

class SequancePageState extends State<SequancePage> {
  initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, 'home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 243, 224, 195),
        padding: EdgeInsets.all(20),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            SizedBox(height: 300),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'N',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 124, 62, 58),
                    fontSize: 55,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'F',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 241, 143, 142),
                    fontSize: 55,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Notes ',
                  style: TextStyle(
                    color: Color.fromARGB(255, 124, 62, 58),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Flow',
                  style: TextStyle(
                    color: Color.fromARGB(255, 241, 143, 142),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,), 
            Row(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                SizedBox(
                  height: 25,
                  width: 25,  
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 241, 143, 142),
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

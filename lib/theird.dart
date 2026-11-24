import 'package:flutter/material.dart';
import 'sign_in.dart';
class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}
class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 243, 224, 195),
        padding: EdgeInsets.all(20),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children:[
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
            SizedBox(height: 40,), 
                  Image.asset('images/3.png', width: 350,
                     height: 350, fit: BoxFit.cover),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Open your mind to new ideas', 
                style: TextStyle(
                  fontSize: 25,
                   fontWeight: FontWeight.bold ,
                   color: const Color.fromARGB(255, 124, 62, 58)
                   )),
              ],
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(' and perspectives', 
                style: TextStyle(
                  fontSize: 25,
                   fontWeight: FontWeight.bold ,
                   color: const Color.fromARGB(255, 124, 62, 58)
                   ),),
              ],
             
            ),
            SizedBox(height: 10,),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Your journey to knowledge starts here', 
                style: TextStyle(
                  fontSize: 17,
                   
                   color: Color.fromARGB(255, 202, 121, 119)),),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('.' , 
                style:TextStyle(
                  fontSize: 80,
                   fontWeight: FontWeight.bold ,
                   color: Colors.grey.withOpacity(0.2)
                  ),),
                    Text('.' , 
                style:TextStyle(
                  fontSize: 80,
                   fontWeight: FontWeight.bold ,
                   color: Colors.grey.withOpacity(0.2)),),
                    Text('.' , 
                style:TextStyle(
                  fontSize: 80,
                   fontWeight: FontWeight.bold ,
                    color: const Color.fromARGB(255, 124, 62, 58)
                   ),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'second');
                  },
                  color: Color.fromARGB(255, 241, 143, 142),
                  height: 60,
                  minWidth: 160,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Back',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 124, 62, 58),
                      fontSize: 20,
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'sign_in');
                  },
                  color: Color.fromARGB(255, 241, 143, 142),
                  height: 60,
                  minWidth: 160, 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Get Started', 
                    style: TextStyle(
                      color: const Color.fromARGB(255, 124, 62, 58),
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ]
      )
      ),
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/pages/gender.dart';
import 'sign_in.dart';

class RejesterPage extends StatefulWidget {
  const RejesterPage({super.key});

  @override
  State<RejesterPage> createState() => _RejesterPageState();
}

class _RejesterPageState extends State<RejesterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController comfirm = TextEditingController();
  TextEditingController username = TextEditingController();
  GlobalKey<FormState> fstate = GlobalKey();
  String? com;
  String? pass;
  bool login = false;
  // 3. إرسال رسالة التوثيق للإيميل
  Future<void> sendEmailVerification() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      print("تم إرسال رابط التوثيق إلى بريدك الإلكتروني.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: fstate,
        child: Container(
          color: const Color.fromARGB(255, 243, 224, 195),
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 0,
                  left: 0,
                  right: 310, 
                  bottom: 20,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, 'third');
                  },
                  child: Container(
                    height: 40,
                    width: 30,
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
              ),
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
              SizedBox(height: 15),
              Text(
                'Register',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 124, 62, 58),
                ),
              ),
              SizedBox(height: 1),
              Text(
                'Enter your personal information',
                style: TextStyle(
                  fontSize: 15,
                  color: const Color.fromARGB(255, 193, 112, 117),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Username',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 124, 62, 58),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: username,
                decoration: InputDecoration( 
                  filled: true,
                  fillColor: const Color.fromARGB(255, 233, 213, 182),
                  hintText: 'Enter your name',
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(255, 182, 158, 123),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      width: 2.5,
                      color: const Color.fromARGB(255, 241, 143, 142),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 124, 62, 58),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 233, 213, 182),
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(255, 182, 158, 123),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      width: 2.5,
                      color: const Color.fromARGB(255, 241, 143, 142),
                    ),
                  ),
                  errorText: com,
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      width: 2.5,
                      color: const Color.fromARGB(255, 124, 62, 58),
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      width: 2.5,
                      color: const Color.fromARGB(255, 124, 62, 58),
                    ),
                  ),
                ),
                controller: emailController,
              ),
              SizedBox(height: 20),
              Text(
                'Password',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 124, 62, 58),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 233, 213, 182),
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(255, 182, 158, 123),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      width: 2.5,
                      color: const Color.fromARGB(255, 241, 143, 142),
                    ),
                  ),
                  errorText: pass,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      width: 2.5,
                      color: const Color.fromARGB(255, 124, 62, 58),
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      width: 2.5,
                      color: const Color.fromARGB(255, 124, 62, 58),
                    ),
                  ),
                ),
                validator: (value) {
                  if (value != comfirm.text) {
                    return 'Not Matches';
                  }
                  return null;
                },
                controller: passwordController,
              ),
              SizedBox(height: 20),
              Text(
                'Confirm Password',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 124, 62, 58),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 233, 213, 182),
                  hintText: 'Enter confirm password',
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(255, 182, 158, 123),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      width: 2.5,
                      color: const Color.fromARGB(255, 241, 143, 142),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      width: 2.5,
                      color: const Color.fromARGB(255, 124, 62, 58),
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      width: 2.5,
                      color: const Color.fromARGB(255, 124, 62, 58),
                    ),
                  ),
                ),
                controller: comfirm,
                validator: (value) {
                  if (value != passwordController.text) {
                    return 'Not Matches';
                  }
                  return null;
                },
              ),
              SizedBox(height: 35),
              MaterialButton(
                onPressed: () async {
                  if (fstate.currentState!.validate()) {
                    try {
                      setState(() {
                        login = true;
                        pass = null;
                        com = null;
                      });
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Gender(
                            email: emailController.text,
                            name: username.text,
                            id: FirebaseAuth.instance.currentUser!.uid,
                          ),
                        ),
                      );
                    } on FirebaseAuthException catch (e) {
                      setState(() {
                        login = false;
                        if (e.code == 'weak-password') {
                          pass = 'The password provided is too weak';
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          com = 'The account already exists for that email';
                          print('The account already exists for that email.');
                        }
                      });
                    } catch (e) {
                      print(e);
                    }
                  }
                },
                color: const Color.fromARGB(255, 241, 143, 142),
                height: 60,
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: login
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: const Color.fromARGB(255, 124, 62, 58),
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Registerring...',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 124, 62, 58),
                              fontSize: 20,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        'Register',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 124, 62, 58),
                          fontSize: 20,
                        ),
                      ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Do you have an account?',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight(500)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'sign_in');
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 15,
                        color: const Color.fromARGB(255, 241, 143, 142),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

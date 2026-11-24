import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String? emailVailed;
  String? passlVailed;
  bool login = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> fstate = GlobalKey();
  Future signInWithGoogle() async {
    await GoogleSignIn.instance.initialize(
      serverClientId:
          '88918448557-op8v2od1j805qchie973os6okmgu19nq.apps.googleusercontent.com',
    );
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn.instance
        .authenticate();
    if (googleUser == null) {
      return;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = googleUser!.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

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
          padding: EdgeInsets.all(20),
          color: const Color.fromARGB(255, 243, 224, 195),
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
                'Login',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 124, 62, 58),
                ),
              ),
              SizedBox(height: 1),
              Text(
                'Login to continue using the app',
                style: TextStyle(
                  fontSize: 15,
                  color: const Color.fromARGB(255, 193, 112, 117),
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
              TextFormField(
                controller: email,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter your email';
                  }

                  return null;
                },

                keyboardType: TextInputType.emailAddress,

                decoration: InputDecoration(
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      width: 2.5,
                      color: const Color.fromARGB(255, 124, 62, 58),
                    ),
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 233, 213, 182),
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(255, 182, 158, 123),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      width: 2.5,
                      color: const Color.fromARGB(255, 124, 62, 58),
                    ),
                  ),
                  errorText: emailVailed,
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

                style: TextStyle(
                  fontSize: 17,

                  color: const Color.fromARGB(255, 124, 62, 58),
                ),
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
                controller: password,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter your Password';
                  }

                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 233, 213, 182),
                  hintText: 'Enter your password',
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
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      width: 2.5,
                      color: const Color.fromARGB(255, 124, 62, 58),
                    ),
                  ),
                  errorText: passlVailed,
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      width: 2.5,
                      color: const Color.fromARGB(255, 124, 62, 58),
                    ),
                  ),
                ),

                style: TextStyle(
                  fontSize: 17,

                  color: const Color.fromARGB(255, 124, 62, 58),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.sendPasswordResetEmail(
                          email: email.text,
                        );
                        String mail = email.text;
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: Border.all(
                              width: 2.5,
                              color: const Color.fromARGB(255, 243, 224, 195),
                            ),
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
                            title: Text('Reset Password'),
                            content: Text(
                              'W\'ve sent an Email to $mail, now you can reset your password.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
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
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: Border.all(
                              width: 2.5,
                              color: const Color.fromARGB(255, 243, 224, 195),
                            ),
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

                            title: Text('User not found'),
                            content: Text('There is no user for this email.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
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
                      }
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 15,
                        color: const Color.fromARGB(255, 124, 62, 58),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 15),
              MaterialButton(
                onPressed: () async {
                  if (fstate.currentState!.validate()) {
                    try {
                      setState(() {
                        login = true;
                      });
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                            email: email.text,
                            password: password.text,
                          );
                      if (credential.user!.emailVerified) {
                        Navigator.pushReplacementNamed(context, 'home');
                      } else {
                        await sendEmailVerification();
                        login = false;
                        setState(() {});
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: Border.all(
                              width: 2.5,
                              color: const Color.fromARGB(255, 243, 224, 195),
                            ),
                            title: Text('Email not verified'),
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
                            content: Text(
                              'Please verify your email before logging in.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
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
                      }
                    } on FirebaseAuthException catch (e) {
                      setState(() {
                        if (e.code == 'user-not-found' ||
                            e.code == 'invalid-email') {
                          login = false;
                          emailVailed = 'Incorrect Email or User not found';
                          passlVailed = null;
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                          passlVailed = 'Wrong password';
                          emailVailed = null;
                          login = false;
                        } else if (e.code == 'invalid-credential') {
                          login = false;
                          passlVailed = 'There must be somethig wrong';
                          emailVailed = 'There must be somethig wrong';
                        }
                      });
                    }
                  }
                },
                color: const Color.fromARGB(255, 241, 143, 142),
                height: 70,
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
                            'Loging...',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 124, 62, 58),
                              fontSize: 20,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        'Login',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 124, 62, 58),
                          fontSize: 20,
                        ),
                      ),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Or login with',
                    style: TextStyle(
                      fontSize: 15,
                      color: const Color.fromARGB(255, 193, 112, 117),
                      fontWeight: FontWeight(500),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () async {
                      login = true;
                      setState(() {});
                      await signInWithGoogle();
                      Navigator.pushReplacementNamed(context, 'home');
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: const Color.fromARGB(255, 124, 62, 58),
                          width: 1.2,
                        ),
                      ),
                      child: Image.asset(
                        'images/google.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 50,
                      width: 100,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: const Color.fromARGB(255, 124, 62, 58),
                          width: 1.2,
                        ),
                      ),
                      child: Image.asset(
                        'images/apple.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: const Color.fromARGB(255, 124, 62, 58),
                          width: 1.2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'images/facebook.jpg',
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight(500),
                      color: const Color.fromARGB(255, 124, 62, 58),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'rejester');
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 15,
                        color: const Color.fromARGB(255, 241, 143, 142),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

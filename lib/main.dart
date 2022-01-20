import 'package:cs4750app/bottomNav.dart';
import 'package:cs4750app/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    future: Firebase.initializeApp();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Elite Book Club'),
      ),
      body:
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blueAccent,
              Colors.orangeAccent,
            ]
          )
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
              margin: EdgeInsets.only(top:10),
              child:
              Icon(Icons.menu_book_rounded, size: 100,color: Colors.orange,)
            ),
            Container(
              width: 300,
              margin: EdgeInsets.only(top:20),
              child:
              Text(
                'Please Login Below',
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: 300,
              margin: EdgeInsets.all(20),
              child:
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)
                  ),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.black)
                ),
              ),
            ),
            Container(
                width: 300,
                margin: EdgeInsets.only(bottom: 10),
                child:
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.black)
                  ),
                ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top:20, left: 20,right: 20),
                  child:
                  ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                      );
                      setState(() {});
                    },
                    child: Text('Sign Up'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top:20, left: 20,right: 20),
                  child:
                  ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BottomNav()),
                      );
                    },
                    child: Text('Login'),
                  ),

                ),
              ],
            )
          ],
        ),
    ),
    );
  }
}

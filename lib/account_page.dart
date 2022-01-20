import 'package:cs4750app/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser!;
    final uemail = user.email.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
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
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child:
              Icon(Icons.account_circle_rounded, size: 200,),
            ),
            Container(
              alignment: Alignment.center,
              child:
              Text(uemail, textScaleFactor: 2,),
            ),
            Container(
              child:
              ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage(title: 'Elite Book Club',)),
                  );
                },
                child: Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

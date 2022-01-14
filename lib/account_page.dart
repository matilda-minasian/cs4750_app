import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  @override
  Widget build(BuildContext context) {
    future: Firebase.initializeApp();
    var user = FirebaseAuth.instance.currentUser!;
    final uemail = user.email.toString();
    print(uemail);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
      ),
      body:
      Column(
        children: [
          Container(
             child:
             Icon(Icons.account_box_rounded,size: 300,),
              alignment: Alignment.center,
          ),
          Container(
            child:
            Text(uemail,style: Theme.of(context).textTheme.headline5,),
          ),
        ],
      ),

    );
  }
}

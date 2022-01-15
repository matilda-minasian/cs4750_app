import 'package:cs4750app/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  @override
  Widget build(BuildContext context) {
    final Storage storage= Storage();
    future: Firebase.initializeApp();
    var user = FirebaseAuth.instance.currentUser!;
    final uemail = user.email.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
      ),
      body:
          Column(
            children: [
              ElevatedButton(
                child: Text("Upload Image"),
                onPressed: () async {
                  final results = await FilePicker.platform.pickFiles(
                    allowMultiple: false,

                    type: FileType.custom,
                    allowedExtensions: ['png', 'jpg']
                  );
                  if(results == null)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('No File Selected.')
                        ),
                      );
                      return null;
                    }
                  final path = results.files.single.path!;
                  final fileName = results.files.single.name;

                  storage.uploadFile(path, fileName).then((value) => print('done'));
                },
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

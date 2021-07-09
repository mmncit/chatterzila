import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_notes/pages/chat_page.dart';
import 'package:fire_notes/pages/login_page.dart';
import 'package:fire_notes/pages/registration_page.dart';
import 'package:fire_notes/pages/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}

class NotePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fire notes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _createBody(),
      ),
    );
  }

  Widget _createBody() {
    FirebaseFirestore.instance
        .collection('notes')
        .doc('quick')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
      } else {
        print('Document does not exist on the database');
      }
    });
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .doc('hachib')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var doc = snapshot.data as DocumentSnapshot;

          if (doc.exists) {
            return Text(doc['3']);
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

import 'package:Polls/screens/BottomNavigationScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Polls',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp(
  //   name: 'Polls',
  //   options: FirebaseOptions(
  //     appId: Platform.isIOS ? '1:938496474338:ios:3566415cee8497c3cbb2bb' : "",
  //     apiKey:
  //         'AAAA2oK_vOI:APA91bE0GPxZfxtjj6p5GP1lobLgb3lA_nef5cElD3KQzS19ho1TEAirRx0TILfUPv58Bh8IPMLyKx8EAE84wH-E3qp-omtwf3lj8FXFqO0d3WdEGIFpA4Co1P-2tJIAVPhdyJLK6O1R',
  //     projectId: 'polls-20557',
  //     databaseURL: 'https://polls-20557-default-rtdb.firebaseio.com/',
  //     messagingSenderId: '938496474338',
  //   ),
  // );

  Future<FirebaseApp> _initialization() async {
    return Firebase.apps?.length == 0
        ? await Firebase.initializeApp(
            name: 'Polls',
            options: FirebaseOptions(
              appId: Platform.isIOS
                  ? '1:938496474338:ios:3566415cee8497c3cbb2bb'
                  : "",
              apiKey:
                  'AAAA2oK_vOI:APA91bE0GPxZfxtjj6p5GP1lobLgb3lA_nef5cElD3KQzS19ho1TEAirRx0TILfUPv58Bh8IPMLyKx8EAE84wH-E3qp-omtwf3lj8FXFqO0d3WdEGIFpA4Co1P-2tJIAVPhdyJLK6O1R',
              projectId: 'polls-20557',
              databaseURL: 'https://polls-20557-default-rtdb.firebaseio.com/',
              messagingSenderId: '938496474338',
            ),
          )
        : Firebase.app('Polls');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Polls'),
            ),
            body: Center(
              child: Text('Something Went Wrong'),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return BottomNavigationScreen();
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

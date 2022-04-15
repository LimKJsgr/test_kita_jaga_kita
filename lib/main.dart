import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:test_kita_jaga_kita/more/eleos_wallet.dart';
import 'package:test_kita_jaga_kita/user_state.dart';
import 'package:test_kita_jaga_kita/more/about_us.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return MaterialApp(
              debugShowCheckedModeBanner: false,

              home: Scaffold(
                  body: Container(
                    color: Color(0xFFC6BBDC),
                    child: Center(
                      child: SpinKitChasingDots(
                        color: Color(0xFF755192),
                        size: 50.0,
                      ),
                    ),
                  )
              ),
            );
          } else if(snapshot.hasError){
            return MaterialApp(
              debugShowCheckedModeBanner: false,

              home: Scaffold(
                  body: Center(
                      child: Center(
                        child: Text('An error has been occurred!'),
                      )
                  )
              ),
            );
          }

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Kita Jaga Kita',
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.black,
              primarySwatch: Colors.blue,
            ),
            home: UserState(),
            routes: {
              '/about_us':(context) => AboutUsPage(),
              '/eleos_wallet':(context) => EleosWallet(),
            },
          );
        });
  }
}


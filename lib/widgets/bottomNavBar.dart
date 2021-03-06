import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_kita_jaga_kita/donations/donations_screen.dart';
import 'package:test_kita_jaga_kita/donations/upload_donation.dart';
import 'package:test_kita_jaga_kita/search/profile_company.dart';
import 'package:test_kita_jaga_kita/search/search_companies.dart';

import '../user_state.dart';

class BottomNavigationBarForApp extends StatelessWidget {

  int indexNum = 0;
  BottomNavigationBarForApp({required this.indexNum});

  void _logout(context){
    final FirebaseAuth _auth = FirebaseAuth.instance;

    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            backgroundColor: Colors.black,
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.logout,
                    color: Colors.white70,
                    size: 36,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    'Sign Out',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                )
              ],
            ),
            content: Text(
              'Do you want to Log Out from App?',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: Text('No', style: TextStyle(color: Colors.green, fontSize: 10),),
              ),
              TextButton(
                onPressed: (){
                  _auth.signOut();
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (contect) => UserState()));
                },
                child: Text(
                  'Yes',
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
              ),
            ],

          );

        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      color: Colors.white,
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: Colors.grey[400],
      height: 52,
      index: indexNum,
      items:<Widget>[
        Icon(Icons.list,size: 25,color: Colors.black),
        Icon(Icons.search,size: 25,color: Colors.black),
        Icon(Icons.add,size: 25,color: Colors.black),
        Icon(Icons.person_pin,size: 25,color: Colors.black),
        Icon(Icons.exit_to_app,size: 25,color: Colors.black),
      ],

      animationDuration: Duration(
        milliseconds: 300,
      ),
      animationCurve: Curves.bounceInOut,
      onTap: (index){
        if (index == 0){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DonationScreen()));
        }
        else if (index == 1){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AllDonationsScreen()));
        }
        else if(index == 2){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UploadDonationNow()));
        }
        else if(index == 3){
          final FirebaseAuth _auth = FirebaseAuth.instance;
          final User? user = _auth.currentUser;
          final String uid = user!.uid;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (contect) => ProfileScreen(
              userID: uid
          )));
        }
        else if (index == 4){
          _logout(context);
        }
      },
    );
  }
}

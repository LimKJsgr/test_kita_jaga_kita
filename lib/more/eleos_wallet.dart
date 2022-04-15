import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:test_kita_jaga_kita/services/global_variables.dart';


class EleosWallet extends StatefulWidget {
  const EleosWallet({Key? key}) : super(key: key);

  @override
  State<EleosWallet> createState() => _EleosWalletState();
}

class _EleosWalletState extends State<EleosWallet> {

  void getMyData() async{
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid).get();

    setState(() => walletBalance = userDoc.get('walletBalance'));
  }

  @override
  void initState(){
    super.initState();
    getMyData();
  }
  final _formKey = GlobalKey<FormState>();
  //Form Value
  int ? _reloadAmount;
  int ? _totalAccumulation;

  final valueHolder = TextEditingController();

  clearTextInput(){

    valueHolder.clear();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String,dynamic>>>(
          stream: FirebaseFirestore.instance.collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              int  _currentBalance = snapshot.data!['walletBalance'];
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 30,),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    image: DecorationImage (
                                      image: AssetImage('assets/icons/icon_wallet.png'),
                                    )
                                ),
                              ),
                              SizedBox(width: 5,),
                              Text("Eleos Wallet", style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'ubuntu',
                                  fontSize: 25
                              ),)
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Text("Your Wallet", style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'avenir'
                      ),),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color(0xfff1f3f6),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('${snapshot.data!['walletBalance']}', style: TextStyle( //This need to be programmed
                                    fontSize: 70,
                                    fontWeight: FontWeight.w700
                                ),),
                                SizedBox(height: 5,),
                                Text("Current Balance", style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'avenir',
                                ),),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),

                      Text("Reload", style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                      ),),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color(0xfff1f3f6),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Form (
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 300,
                                    child: Padding(
                                      padding: const EdgeInsets.all(30.0),
                                      child: TextFormField(
                                        controller: valueHolder,
                                        textAlign: TextAlign.center,
                                        validator: (val) => val!.isEmpty ? 'Please enter a value' : null,
                                        style: TextStyle(
                                            fontSize: 50,
                                            fontWeight: FontWeight.w700
                                        ),
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                          focusColor: Color(0xFFC52AD4),
                                          isCollapsed: true,
                                          hintText: '0',
                                        ),
                                        keyboardType: TextInputType.numberWithOptions(decimal: false),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                        ],
                                        autofocus: false,
                                        onChanged: (text){
                                          setState(() {
                                            _reloadAmount = int.parse(text);
                                          });
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  _totalAccumulation = (_reloadAmount! + _currentBalance!)!;
                                });
                                if(_formKey.currentState!.validate()) {
                                  print(_totalAccumulation);
                                  await FirebaseFirestore.instance.collection('users')
                                      .doc(FirebaseAuth.instance.currentUser!.uid).update({'walletBalance' : _totalAccumulation});
                                  clearTextInput();
                                }
                              },
                              child: Text(
                                'Top Up',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'avenir',
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                minimumSize: Size(190, 50),
                                primary: Color(0xFFC52AD4),
                              ),
                            ),
                          )
                      )

                    ],
                  ),
                ),
              );
            } else {
              return MaterialApp(
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
            }
          }
      ),
    );
  }
}


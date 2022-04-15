import 'package:flutter/material.dart';


class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Color(0xFFC6BBDC),
        //drawer: CustomDrawer(),
        appBar: AppBar(
          title: Text("About Us"),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),

        body: Stack(
          children: <Widget>[
            Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/eleos.jpg"),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.srcOver),
                          )
                      ),
                      child: Stack(
                        children: <Widget>[
                          SafeArea(
                            bottom: false,
                            right: false,
                            left: false,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0, right: 0, top: 35),
                              child: Column(
                                children: [
                                  ClipOval(
                                    child: Image.asset(
                                      'assets/launch_image.png',
                                      width: 150,
                                      height: 150,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 24.0),
                                    child: Text("KitaJagaKita",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 35)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 24.0, left: 42, right: 32),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.max,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                      child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 32.0, right: 32.0, top: 42.0),
                            child: Column(children: [
                              Text("About Us",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 30.0)),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 24.0, right: 24, top: 30, bottom: 24),
                                child: Text(
                                    "We are messengers sent by Eleos, the God of Athens. The aim of development of this application is to rescue all organisms with our prominent exersions.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black, fontSize: 25.0)),
                              ),
                            ]),
                          ))),
                ),
              ],
            ),
          ],
        )
    );
  }
}

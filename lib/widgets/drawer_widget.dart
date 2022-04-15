import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class CustomDrawer extends StatelessWidget {
  //const CustomDrawer({Key? key}) : super(key: key);
  static final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: CupertinoColors.black,
        child: ListView(
            children: [
              Container(
                height: 70,
                child: const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: buildMenuItem(
                        context,
                        text: 'About Us',
                        icon: FontAwesomeIcons.users,
                        textIconColor: Colors.white,
                        tileColor: Colors.grey[900],
                        //tileColor: ModalRoute.of(context)?.settings.name == '/about_us' ? Colors.deepPurple : null,
                        //textIconColor: ModalRoute.of(context)?.settings.name == '/about_us' ? Colors.white : null,
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.pushNamed(context, '/about_us');
                          //print(ModalRoute.of(context)?.settings.name);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: buildMenuItem(
                        context,
                        text: 'Eleos Wallet',
                        icon: FontAwesomeIcons.users,
                        textIconColor: Colors.white,
                        tileColor: Colors.grey[900],
                        //tileColor: ModalRoute.of(context)?.settings.name == '/about_us' ? Colors.deepPurple : null,
                        //textIconColor: ModalRoute.of(context)?.settings.name == '/about_us' ? Colors.white : null,
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.pushNamed(context, '/eleos_wallet');
                          //print(ModalRoute.of(context)?.settings.name);
                        },
                      ),
                    ),
                  ]
              )
            ]
        )
    );
  }
  Widget buildMenuItem(
      BuildContext context, {
        required String text,
        required IconData icon,
        required VoidCallback onTap,
        Color? textIconColor,
        Color? tileColor,
      }) {

    return ListTile(
      leading: FaIcon(icon, color: textIconColor,),
      title: Text(text,style: TextStyle(color: textIconColor)),
      tileColor: tileColor,
      onTap: onTap,
    );
  }

}


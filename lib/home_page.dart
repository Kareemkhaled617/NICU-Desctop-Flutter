import 'package:flutter/material.dart';
import 'package:nicu_desctop/login.dart';
import 'package:nicu_desctop/page/chat.dart';
import 'package:nicu_desctop/page/profile.dart';
import 'package:nicu_desctop/page/requests.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  Future save_data()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('status', false);
  }

  void changeDestination(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  List page=[
    const Requests(),
    const Chat(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 730) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Home'),
                centerTitle: true,
                backgroundColor: Colors.teal.shade300,
                actions: [
                  IconButton(icon: const Icon(Icons.logout_rounded,),onPressed: (){
                    save_data();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const LoginPage()));
                  },)
                ],
              ),
              body: Row(
                children: <Widget>[
                  NavigationRail(
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: changeDestination,
                    minWidth: 100,
                    labelType: NavigationRailLabelType.all,
                    selectedIconTheme: const IconThemeData(color: Colors.white),
                    selectedLabelTextStyle: TextStyle(color: Colors.lightBlue[500],fontWeight: FontWeight.w600),
                    unselectedLabelTextStyle: TextStyle(color: Colors.grey[500]),
                    elevation: 5,
                    useIndicator: true,
                    backgroundColor: Colors.grey[50],
                    indicatorColor: Colors.cyan[50],
                    // leading: const MyLeadingWidget(),
                    // trailing: const MyTrailingWidget(),
                    destinations: const <NavigationRailDestination>[
                      NavigationRailDestination(
                        icon: Icon(Icons.house_outlined),
                        selectedIcon: Icon(Icons.house),
                        label: Text('Home'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.chat_bubble_outline),
                        selectedIcon: Icon(Icons.chat),
                        label: Text('Chat'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.account_circle_outlined),
                        selectedIcon: Icon(Icons.account_circle),
                        label: Text('Profile'),
                      ),
                    ],
                  ),
                  const VerticalDivider(thickness: 1, width: 1),
                  // This is the main content.
                  Expanded(
                    child:page[_selectedIndex]
                  )
                ],
              ),
            );
          }

          return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.star),
                    label: 'Favorites',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle),
                    label: 'Profile',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.amber[800],
                onTap: changeDestination,
              ),
            appBar: AppBar(
              backgroundColor: Colors.teal.shade300,
              leading: IconButton(icon: const Icon(Icons.arrow_back_ios,),onPressed: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (conext)=>const MyHomePage()));
              },),),
              body:page[_selectedIndex] ,
              );
        });
  }
}

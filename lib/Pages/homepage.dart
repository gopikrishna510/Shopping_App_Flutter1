import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app_flutter/Pages/loginpage.dart';
import 'package:shopping_app_flutter/Pages/page1.dart';
import 'package:shopping_app_flutter/Pages/page2.dart';
import 'package:shopping_app_flutter/Pages/page3.dart';
import 'package:shopping_app_flutter/Pages/page4.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final dynamic title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //int pageIndex = 0;
  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Page4()));
  }

  final pages = [
    const HomePageList(),
    const Page2(),
    const Page3(),
    const Page4(),
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // this _selectedIndex and _onItemTapped() used for in bottomNavigationBar Widget
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                //<-- SEE HERE
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                // <-- SEE HERE
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: drawerCustom(context),
        appBar: appBarCustom(context),
        body: pages[_selectedIndex],
        bottomNavigationBar: navigationCustom(context),
      ),
    );
  }

  /// Instead of creating a separate classes for every Widget
  /// create a customwidget for that particular Widget so that makes you simple
  /// like below i return the code using customwidget

  AppBar appBarCustom(BuildContext context) {
    dynamic titleName = widget.title;
    return AppBar(
      leading: IconButton(
        onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        icon: const Icon(Icons.menu, color: Colors.black),
      ),
      actions: [
        IconButton(
          onPressed: () {
            //if u use navigation it might goto nextPage(newpage) ,instead of that i used the method _onItemTapped()
            // so that the page will be redirect to same page to display data
            // _navigateToNextScreen(context);
            _onItemTapped(3);
          },
          icon: const Icon(Icons.shopping_cart, color: Colors.black),
        ),
        Container(width: 0)
      ],
      title: Text(
        'Welcome ' + titleName,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }

  Widget navigationCustom(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 10,
      selectedIconTheme: const IconThemeData(color: Colors.indigo, size: 30),
      selectedItemColor: Colors.indigo,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      iconSize: 20,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.storefront_sharp),
          label: 'Stores',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Wishlist',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag),
          label: 'Bag',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }

  Drawer drawerCustom(BuildContext context) {
    dynamic titleName = widget.title;
    return Drawer(
        // backgroundColor: Colors.red,
        child: ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          child: Padding(
            padding: EdgeInsets.only(
                top: 0.0, bottom: 100.0, left: 0.0, right: 20.0),
            child: Text('Shopping_App',
                style: TextStyle(color: Colors.black, fontSize: 20)),
          ),
          margin: EdgeInsets.only(top: 0.0, left: 2.0, right: 0.0, bottom: 0.0),
          padding: EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage("assets/images/image4.jpg"),
                fit: BoxFit.cover),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Home'),
          onTap: () {
            // Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(title: titleName),
              ),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.account_circle),
          title: const Text('Profile'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Settings'),
          leading: const Icon(Icons.settings),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Logout'),
          leading: const Icon(Icons.logout),
          onTap: () {
            //to close the drawer before the appearing  the popup box
            Navigator.pop(context);
            //by using this we can  show popup box
            showDialog(
              context: context,
              builder: (BuildContext context) =>
                  _buildPopupDialogForLogout(context),
            );
          },
        ),
      ],
    ));
  }

  //Widget for alert for logout popup used in Drawer
  Widget _buildPopupDialogForLogout(BuildContext context) {
    return AlertDialog(
      title: const Text('Logout',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text("Do you want to logout ?"),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () async {
            // Navigator.of(context).pop();
            //used to clear the shared preferences
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            await preferences.clear();
            //used to redirect to the login page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Yes'),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('No'),
        ),
      ],
    );
  }
}

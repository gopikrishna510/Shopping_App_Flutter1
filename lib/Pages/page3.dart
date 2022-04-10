import 'package:flutter/material.dart';
import 'package:shopping_app_flutter/Classes/listitems.dart';
import 'package:shopping_app_flutter/Database/database_helper.dart';


class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  static DatabaseHelper dbHelper = DatabaseHelper.instance;
  List<ListItems> resultCart=[];
  @override
  Widget build(BuildContext context) {
    return resultCart.isNotEmpty
        ?Container():const Center(
      child: Text(
        "No_Favorite_Items",
        style: TextStyle(
          color: Colors.black,
          fontSize: 35,
        ),
      ),
    );
  }
}


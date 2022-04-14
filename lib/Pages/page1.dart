import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app_flutter/models/listitems.dart';
import 'package:shopping_app_flutter/models/utilitiy.dart';
import 'package:shopping_app_flutter/Database/database_helper.dart';
import 'package:shopping_app_flutter/Database/local_storage.dart';


class HomePageList extends StatefulWidget {
  const HomePageList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePageListState();
  }
}

class HomePageListState extends State<HomePageList> {
  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  bool booleanValuePassing = false;
  List<bool> booleanVariable_ = [];
  List<ListItems> listItems = [
    ListItems(imageURL: 'assets/images/image1.jpg', imageName: 'Zombie'),
    ListItems(imageURL: 'assets/images/image2.jpg', imageName: 'Pahua'),
    ListItems(imageURL: 'assets/images/image3.jpg', imageName: 'Amazon'),
    ListItems(imageURL: 'assets/images/image1.jpg', imageName: 'Zombie1'),
    ListItems(imageURL: 'assets/images/image2.jpg', imageName: 'Pahua1'),
    ListItems(imageURL: 'assets/images/image3.jpg', imageName: 'Amazon1'),
    ListItems(imageURL: 'assets/images/image1.jpg', imageName: 'Zombie2'),
    ListItems(imageURL: 'assets/images/image2.jpg', imageName: 'Pahua2'),
    ListItems(imageURL: 'assets/images/image3.jpg', imageName: 'Amazon2'),
    ListItems(imageURL: 'assets/images/image1.jpg', imageName: 'Zombie3'),
    ListItems(imageURL: 'assets/images/image2.jpg', imageName: 'Pahua3'),
    ListItems(imageURL: 'assets/images/image3.jpg', imageName: 'Amazon3')
  ];

  int? _favoriteSelected;

  int countValueForCrossAxis() {
    if (kIsWeb) {
      return 2;
    } else {
      return 1;
    }
  }

  double countForChildAspectRatio() {
    if (kIsWeb) {
      return 4;
    } else {
      return 2.0;
    }
  }

  List<int> indexValues = [];
  List<ListItems> newListItems = [];

  @override
  Widget build(BuildContext context) {
    print(listItems);
    return GridView.builder(
      itemCount: listItems.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: countForChildAspectRatio(),
          crossAxisCount: countValueForCrossAxis(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 2),
      itemBuilder: (BuildContext context, int index) {
        return kIsWeb
            ? scaffoldCustomWidgetForWeb(context, index)
            : _rowCustomForAndroid(context, index);
      },
      padding: const EdgeInsets.all(5),
      //childAspectRatio: 2,
      shrinkWrap: true,
    );
  }

  Widget scaffoldCustomWidgetForWeb(BuildContext context, int index) {
    booleanVariable_.add(false);
    // print(booleanVariable_);
    return Scaffold(
      body: Center(
        child: Container(
          width: 320,
          child: _rowCustomForWeb(context, index),
        ),
      ),
    );
  }

  Widget _rowCustomForAndroid(BuildContext context, int index) {
    booleanVariable_.add(false);
    var lastIndex = 0;
    bool booleanVariable = false;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(0.0),
          padding: const EdgeInsets.all(0.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.zero,
            color: Colors.black,
          ),
          child: Image.asset(listItems[index].imageURL,
              height: 140, fit: BoxFit.fill),
        ),
        Container(
          margin: const EdgeInsets.all(0.0),
          padding: const EdgeInsets.only(right: 50, bottom: 100.0),
          child: Text(listItems[index].imageName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10.0),
              // padding: const EdgeInsets.only(left:100.0),
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (booleanVariable_[index]) {
                        booleanVariable_[index] = false;
                      } else {
                        booleanVariable_[index] = true;
                      }
                    });
                  },
                  icon: const Icon(Icons.favorite),
                  color: booleanVariable_[index] ? Colors.red : Colors.black12),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              padding: const EdgeInsets.only(left: 0.0),
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: FlatButton(
                onPressed: () {
                  UtilityMethods.CARTITEM = newListItems;
                  String name = listItems[index].imageName;
                  if (indexValues.contains(index)) {
                    indexValues.remove(index);
                    newListItems.remove(listItems[index]);
                    _deleteData(DatabaseHelper.table, name);
                  } else {
                    indexValues.add(index);
                    newListItems.add(listItems[index]);
                    _insert(context, index);
                  }
                  //_query();
                  print(indexValues);
                  print(newListItems);
                },
                child: const Center(
                  child: Text("Add_to_cart",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _rowCustomForWeb(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(0.0),
          padding: const EdgeInsets.all(0.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.zero,
            color: Colors.black,
          ),
          child: Image.asset(listItems[index].imageURL,
              height: 140, fit: BoxFit.fill),
        ),
        Container(
          margin: const EdgeInsets.all(0.0),
          padding: const EdgeInsets.only(right: 50, bottom: 100.0),
          child: Text(listItems[index].imageName,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 10.0),
              // padding: const EdgeInsets.only(left:100.0),
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (booleanVariable_[index]) {
                        booleanVariable_[index] = false;
                      } else {
                        booleanVariable_[index] = true;
                      }
                    });
                  },
                  icon: Icon(Icons.favorite),
                  color: booleanVariable_[index] ? Colors.red : Colors.black12),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 0.0),
              padding: const EdgeInsets.only(left: 0.0),
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: FlatButton(
                onPressed: () {
                  List<ListItems> cartItems = [];
                  String url = listItems[index].imageURL;
                  String name = listItems[index].imageName;
                  cartItems.add(listItems[index]);

                  Object value = cartItems[0];
                  String name1 = value.toString();
                  if (LocalStorageHelper.localStorage.containsValue(name)) {
                    //LocalStorageHelper.removeData(name);
                  } else {
                    LocalStorageHelper.saveValue(name, name1);
                  }
                  print(url + '--------' + name);
                  print(LocalStorageHelper.localStorage.length);
                  print(LocalStorageHelper.localStorage.values);

                  //UtilityMethods.CARTITEM = newListItems;
                },
                child: const Center(
                  child: Text("Add_to_cart",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // insert to database
  void _insert(BuildContext context, int index) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnURL: listItems[index].imageURL,
      DatabaseHelper.columnName: listItems[index].imageName,
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  //retrive data from database
  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach(print);
  }

  //delete data using columnName
  void _deleteData(table, String imageName) async {
    final db = await dbHelper.database;
    await db!.rawDelete('delete from $table where name =?', [imageName]);
  }
}

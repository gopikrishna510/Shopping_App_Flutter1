import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app_flutter/Classes/listitems.dart';
import 'package:shopping_app_flutter/Database/database_helper.dart';
import 'package:shopping_app_flutter/Database/local_storage.dart';


class Page4 extends StatefulWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  static DatabaseHelper dbHelper = DatabaseHelper.instance;

  List<ListItems> cartItems = [];
  List test = [];
  List<ListItems> resultCart = [];
  var size, height, width;

  @override
  void initState() {
    super.initState();
    gettingDataFromLocalStorage();
    gettingDataFromDB();
    //cartItems = UtilityMethods.CARTITEM;
  }

  //fetching data from localStorage used for Web
  gettingDataFromLocalStorage() {
    Iterable<MapEntry<String, String>> testObject =
        LocalStorageHelper.localStorage.entries;
    test = [];
    cartItems = [];
    setState(() {
      var asd = testObject.map((e) {
        if (e.key == "Pahua" ||
            e.key == 'Amazon' ||
            e.key == 'Zombie' ||
            e.key == "Pahua1" ||
            e.key == 'Amazon1' ||
            e.key == 'Zombie1' ||
            e.key == "Pahua2" ||
            e.key == 'Amazon2' ||
            e.key == 'Zombie2' ||
            e.key == "Pahua3" ||
            e.key == 'Amazon3' ||
            e.key == 'Zombie3') {
          test.add(e.value);
        }
      });

      print('aaaaaaaaaaaa$asd');

      for (int i = 0; i < test.length; i++) {
        print("Total String ---------" + test[i]);

        String url =
            test[i].split(',')[0].split(':')[1].toString().replaceAll('}', '');
        String resultURL = url.trim();
        String name =
            test[i].split(',')[1].split(':')[1].toString().replaceAll('}', '');
        print(resultURL + '------' + name);
        cartItems.add(ListItems(imageURL: resultURL, imageName: name));
        print(cartItems.length);
      }
    });
  }

  //fetching data from Sqflite used for Android
  gettingDataFromDB() {
    //used to print latest data from DB after deletion operation
    resultCart = [];
    DatabaseHelper.instance.queryAllRows().then((value) {
      setState(() {
        value.forEach((element) {
          //print(value);
          //print(element['url']);
          // print(element['name']);
          resultCart.add(
              ListItems(imageURL: element['url'], imageName: element['name']));
        });
        print("HERE-----new ${resultCart.length}");
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return kIsWeb
        ? scaffoldCustomWidgetForWeb(context)
        : scaffoldCustomWidgetForAndroid(context);
  }

  Widget scaffoldCustomWidgetForWeb(BuildContext context) {
    //SingleChildScrollView
    return Scaffold(
      body: validateForWeb(context)

    );
  }

  Widget scaffoldCustomWidgetForAndroid(BuildContext context) {
    return Scaffold(
      body: Container(child: validateForAndroid(context)),
    );
  }

  Widget validateForAndroid(BuildContext context) {
    return resultCart.isNotEmpty
        ? SizedBox(
            width: 360,
            child: GridView.builder(
              itemCount: resultCart.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 2,
                  crossAxisCount: 1,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 1),
              itemBuilder: (BuildContext context, int index) {
                return _rowCustomForAndroid(context, index);
              },
              padding: const EdgeInsets.all(10),
              //childAspectRatio: 2,
              // shrinkWrap: true,
            ),
          )
        : const Center(
            child: Text(
              "No_Items_Added_Android",
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          );
  }

  Widget validateForWeb(BuildContext context) {
    print("cartitem ${cartItems.length}");
    print(cartItems);
    return cartItems.isNotEmpty
        ? GridView.builder(
            itemCount: cartItems.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 4,
                crossAxisCount: 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 2),
            itemBuilder: (BuildContext context, int index) {
              return _rowCustomForWeb(context, index);
            },
            padding: const EdgeInsets.all(10),
            //childAspectRatio: 2,
            shrinkWrap: true,
          )
        : const Center(
            child: Text(
              "No_Items_Added_Web",
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          );
  }

  Widget _rowCustomForWeb(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(0.0),
          padding: const EdgeInsets.all(0.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.zero,
            color: Colors.black,
          ),
          child: Image.asset(cartItems[index].imageURL,
              height: 200, fit: BoxFit.fill),
        ),
        Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(0.0),
          child: Text(cartItems[index].imageName,
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
              /*child: IconButton(
                  onPressed: () {},
                     icon: Icon,
                  icon: const Icon(Icons.favorite),
                  color: Colors.black12),*/
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
                  String name =cartItems[index].imageName;
                  LocalStorageHelper.removeData(name);
                  gettingDataFromLocalStorage();
                },
                child: const Center(
                  child: Text("Remove",
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

  Widget _rowCustomForAndroid(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(0.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.zero,
            color: Colors.black,
          ),
          child: Image.asset(resultCart[index].imageURL,
              height: 140, fit: BoxFit.fill),
        ),
        Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.only(right: 50, bottom: 100.0),
          child: Text(resultCart[index].imageName,
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
              /*child: IconButton(
                  onPressed: () {},
                     icon: Icon,
                  icon: const Icon(Icons.favorite),
                  color: Colors.black12),*/
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
                  String name = resultCart[index].imageName;
                  _deleteData(DatabaseHelper.table, name);
                  gettingDataFromDB();
                  _query();
                  //Navigator.pop(context);
                  /* Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Page4(),
                    ),
                  );*/
                },
                child: const Center(
                  child: Text("Remove",
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

  void _deleteData(table, String imageName) async {
    final db = await dbHelper.database;
    await db!.rawDelete('delete from $table where name =?', [imageName]);
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach(print);
  }
}




/* Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: Colors.deepOrange,
            width: width / 1.3,
            height: height / 1.3,
            margin:const EdgeInsets.only(top:20, right:10 ,left: 10 ,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                 Text(
              "Shopping Cart",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
             Text(
              "Price",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
            ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment:MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 0.0,bottom: 100),
                    color: Colors.red,
                    width: width/4.7,
                    height: height/3.2,
                  )
                ],
              )
            ],
          ),
        ],
      )*/ /*Container(
        width: width / 1.3,
        height: height / 1.3,
        decoration: BoxDecoration(
          border: Border.all(width: 10, color: Colors.black),
         // borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        margin: const EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
           Text(
              "Shopping Cart",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
           Text(
              "Price",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
            ),
        Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 0.0,bottom: 100),
                      color: Colors.red,
                      width: width/4.7,
                      height: height/3.2,
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),*/
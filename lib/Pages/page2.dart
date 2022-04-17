import 'package:flutter/material.dart';

/*class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Store_Page",
        style: TextStyle(
          color: Colors.black,
          fontSize: 35,
        ),
      ),
    );
  }
}*/
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_app_flutter/Pages/category_selected.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  //late List categoriesList = [];
  dynamic data;

  @override
  void initState() {
    // apiCall();
    super.initState();
  }

  //calling API to display JSON data in shopping APP
  Future<http.Response> apiCall() async {
    final response = await http
        .get(Uri.parse("https://fakestoreapi.com/products/categories"));
    /*if (response.statusCode == 200) {
      for (int i = 0; i < data.length; i++) {
        categoriesList.add(data[i]);
      }
    }*/
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Items_Categories"),
      ),
      body: FutureBuilder<http.Response>(
          future: apiCall(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              data = jsonDecode(snapshot.data!.body.toString());
              /*if (categoriesList.length < 4) {
                for (int i = 0; i < data.length; i++) {
                  categoriesList.add(data[i]);
                }
              }*/
              return GridView.builder(
                itemCount: data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 7),
                itemBuilder: (context, index) {
                  return container(context, index);
                  //Text(itemModel[index].description.toString());
                },
              );
            }
          }),
    );
  }

  Widget container(BuildContext context, int index) {
    return Container(
      color: Colors.red,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategorySelected(category:data[index]),
          ),),
        child: Center(
            child: Text(data[index],
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 28))),
      ),
    );
  }
/*
  Widget gettingItemsList1(BuildContext context, int index) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          child: InkWell(
            onTap: () => print("ciao"),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ListTile(
                  title: Text(itemModel[index].title.toString()),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(itemModel[index].category.toString()),
                      Text(itemModel[index].description.toString()),
                      Text("Price  :${itemModel[index].price.toString()}",
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
*/
}

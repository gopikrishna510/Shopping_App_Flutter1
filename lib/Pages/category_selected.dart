import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shopping_app_flutter/models/item_model.dart';

class CategorySelected extends StatefulWidget {
  const CategorySelected({Key? key, this.category}) : super(key: key);
  final dynamic category;
  @override
  State<CategorySelected> createState() => _CategorySelectedState();
}

class _CategorySelectedState extends State<CategorySelected> {

  dynamic categoryName;
  List<ItemModel> itemModel = [];
  //calling API to display JSON data in shopping APP
  Future<List<ItemModel>> apiCall() async {
    String url = "https://fakestoreapi.com/products/category/"+categoryName;
    final response =
    await http.get(Uri.parse(url));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        itemModel.add(ItemModel.fromJson(i));
      }
      return itemModel;
    } else {
      return itemModel;
    }
  }
  @override
  Widget build(BuildContext context) {
    categoryName = widget.category;
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: FutureBuilder(
          future: apiCall(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return GridView.builder(
                itemCount: itemModel.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2),
                itemBuilder: (context, index) {
                  return gettingItemsList1(context, index);
                  //Text(itemModel[index].description.toString());
                },
              );
            }
          }),
    );
  }
  //practice
  Widget gettingItemsList(BuildContext context, int index) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 1,
        child: ListTile(
          leading: Image.network(
            itemModel[index].image.toString(),
            fit: BoxFit.fitHeight,
            width: MediaQuery.of(context).size.width * 0.20,
            height: MediaQuery.of(context).size.height * 0.50,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(0),
                child: Text(itemModel[index].title.toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              Text(itemModel[index].price.toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          subtitle: Text(itemModel[index].category.toString()),
        ));
  }

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
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: Image.network(itemModel[index].image.toString(),
                      width: 300, height: 150, fit: BoxFit.fill),
                ),
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
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/utils/routes.dart';
import 'package:flutter_application/widgets/drawer.dart';
import 'package:flutter_application/widgets/home_widgets/catalog_header.dart';
import 'package:flutter_application/widgets/home_widgets/catalog_list.dart';
//import 'package:flutter_application/widgets/drawer.dart';
import 'dart:convert';
import 'package:velocity_x/velocity_x.dart';

import '../modals/catalog.dart';
import '../widgets/themes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  final String name = "Pawan";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 2));
    final catalogJson =
        await rootBundle.loadString("assets/files/catalog.json");
    final decodedData = jsonDecode(catalogJson);
    var productsData = decodedData["products"];
    CatalogModel.items = List.from(productsData)
        .map<Item>((item) => Item.fromMap(item))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
        ),
        backgroundColor: Colors.cyan,
         floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, MyRoutes.cartRoute),
          backgroundColor: MyTheme.darkBluishColor,
          child: Icon(CupertinoIcons.cart),
        ),
        body: SafeArea(
          child: Container(
            padding: Vx.m16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: [
                CatalogHeader(),
                if (CatalogModel.items.isNotEmpty)
                  CatalogList().expand()
                else
                 CircularProgressIndicator().centered().py16().expand(),
                  
              ],
            ),
          ),
       ),
         drawer: MyDrawer(),
        );
  }
}





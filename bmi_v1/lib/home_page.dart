import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'about_page.dart';
import 'result_page.dart';
import 'purchase_pro_page.dart';
import 'item_widget.dart';
import 'utils.dart';
import 'globals.dart';

import 'dart:math';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ItemWidget _itemHeight = ItemWidget(
    name: 'Height',
    unitCount: 3,
    units: ['cms', 'inches', 'feet'],
    starts: [30, 12, 1],
    ends: [240, 96, 8],
    unitConversionMappings: [
      1.0, 12.0/30.0, 1.0/30.0,
      30.0/12.0, 1.0, 1.0/12.0,
      30.0, 12.0, 1.0
    ],
    controller: ItemWidgetController(),
  ), _itemWeight = ItemWidget(
    name: 'Weight',
    unitCount: 2,
    units: ['kgs', 'pounds'],
    starts: [0, 0],
    ends: [250, 500],
    unitConversionMappings: [
      1.0, 2.20462,
      0.453592, 1.0
    ],
    controller: ItemWidgetController(),
  );

  _HomePageState() {
    bmiValue = 0;
  }

  @override
  void initState() {
    super.initState();

    for (String assetName in assetNames) {
      images.add(SvgPicture.asset(
        assetName,
        width: 64,
        height: 128,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculate BMI'),
        leading: ClipOval(
          child: Material(
            color: Theme.of(context).primaryColor,
            child: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(Icons.menu_rounded),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            AppBar(
              title: Text('Menu'),
              automaticallyImplyLeading: false,
            ),
            Ink(
              color: Theme.of(context).backgroundColor,
              child: ListTile(
                title: Text(
                  'About',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Comfortaa',
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => AboutPage()),
                  );
                },
              ),
            ),
            Ink(
              color: Theme.of(context).backgroundColor,
              child: ListTile(
                title: Row(
                  children: <Widget>[
                    Text(
                      'Purchase ',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Comfortaa',
                      ),
                    ),
                    Ink(
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text(
                        'PRO',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Shadows Into Light Two',
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => PurchasePROPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Wrap(
          runSpacing: 8,
          children: <Widget>[
            _itemHeight,
            _itemWeight,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 200,
        height: 48,
        child: FloatingActionButton.extended(
          onPressed: () => {
            calculateBMI(),
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => ResultPage()),
            )
          },
          label: Text(
            'Calculate',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Comfortaa',
              color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void calculateBMI() {
    bmiValue = toPrecision(_itemWeight.controller.getConvertedValue() / pow(_itemHeight.controller.getConvertedValue() / 100.0, 2), 2);
  }
}
import 'package:flutter/material.dart';

class PurchasePROPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase PRO'),
        leading: ClipOval(
          child: Material(
            color: Theme.of(context).primaryColor,
            child: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(Icons.arrow_back_rounded),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        // Show the result
        // use the BMI value in account with the color of something
        child: Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 16,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Ink(
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                padding: EdgeInsets.all(8),
                child: Text(
                  'Features :\n  1. Take notes about your diet plan\n  2. .......\n  3. .......',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Shadows Into Light Two',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
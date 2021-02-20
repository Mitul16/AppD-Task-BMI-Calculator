import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
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
            Ink(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              padding: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Created by - ',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Comfortaa',
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Text(
                            'Mitul Varshney',
                            style: TextStyle(
                              fontSize: 32,
                              color: Colors.blueAccent,
                              fontFamily: 'Shadows Into Light Two',
                            ),
                          ),
                        ),
                        onTap: () {
                          launch('https://mitul16.github.io/WebD-Task-2/');
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Contact - ',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Comfortaa',
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Text(
                            'mitul.varshney.2@gmail.com',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.blueAccent,
                              fontFamily: 'Shadows Into Light Two',
                            ),
                          ),
                        ),
                        onTap: () {
                          launch('mailto:mitul.varshney.2@gmail.com');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
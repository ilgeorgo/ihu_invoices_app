/* Εμφανίζει μια σελίδα για την  εφαρμογή.
* Η σελίδα περιλαμβάνει μια εικόνα και το
* κείμενο που εμφανίζεται μέσα από τα widgets
* TitleInfo() και TextInfo(). */

import 'package:flutter/material.dart';
import '../widgets/title_info.dart';
import '../widgets/text_info.dart';

class InfoScreen extends StatelessWidget {
  static String routeName = '/info-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Πληροφορίες για την εφαρμογή'),
      ),
      body: ListView(
        children: <Widget>[
          Image.asset(
            './assets/images/flutter-dart.jpg',
          ),
          TitleInfo(),
          TextInfo(),
        ],
      ),
    );
  }
}

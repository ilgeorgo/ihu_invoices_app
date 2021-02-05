/* Εμφανίζει το συρταρωτό μενού από αριστερά με τις επιλογές.
 * Κάθε επιλογή περιλαμβάνει ένα συμβάν onTap(), το οποίο οδηγεί
 * σε αντίστοιχη λειτουργία.  */
import 'package:flutter/material.dart';
import 'dart:io';
import '../screens/info_screen.dart';
import 'package:invoices_app/screens/invoicelist.dart';

class AppDrawer extends StatelessWidget {
  void selectInfoScreen(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(InfoScreen.routeName);
  }

  void selectInvoicesScreen(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(InvoiceList.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Επιλογές Εφαρμογής',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
            ),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Λίστα Τιμολογίων'),
            onTap: () => selectInvoicesScreen(context),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Πληροφορίες App'),
            onTap: () => selectInfoScreen(context),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Έξοδος'),
            onTap: () => exit(0),
          ),
        ],
      ),
    );
  }
}

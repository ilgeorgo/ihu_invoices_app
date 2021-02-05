//Στοιχείο κειμένου
import 'package:flutter/material.dart';

class TitleInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Η εφαρμογή δημιουργήθηκε με τη χρήση Flutter και Dart',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Μπορεί να εκτελεστεί τόσο σε Android όσο και σε ios.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          Icon(
            Icons.phone_android,
            color: Colors.green[500],
          ),
          Icon(
            Icons.phone_iphone,
            color: Colors.red,
          ),

          //Text('41'),
        ],
      ),
    );
  }
}

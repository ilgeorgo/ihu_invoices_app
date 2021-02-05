import 'package:flutter/material.dart';
import 'package:invoices_app/screens/invoicelist.dart';
import './screens/info_screen.dart';
import './widgets/app_drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final appTitle = 'Εφαρμογή Τιμολογίων';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Invoices',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepOrange,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: appTitle),
      routes: {
        InfoScreen.routeName: (ctx) => InfoScreen(),
        InvoiceList.routeName: (ctx) => InvoiceList(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //Build AppBar
    return new Scaffold(
      drawer: AppDrawer(),
      appBar: new AppBar(title: new Text(widget.title)),
      body: Container(
        decoration: BoxDecoration(
            //φόρτωση της εικόνας φόντου.
            image: DecorationImage(
                image: AssetImage('./assets/images/home_back.png'),
                fit: BoxFit.cover)),
      ),
    );
  }
}

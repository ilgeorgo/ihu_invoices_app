import 'package:flutter/material.dart';
import 'package:invoices_app/util/dbhelper.dart';
import 'package:invoices_app/model/invoice.dart';
import 'package:intl/intl.dart';

//Buttons
final List<String> choices = const <String>[
  'Save Invoice & Back',
  'Delete Invoice',
  'Back to List',
];

//In order for the menu to interact with the db we retreive the instance of the DbHelper class
DbHelper helper = DbHelper();
//Menu constants
const mnuSave = 'Save Invoice & Back';
const mnuDelete = 'Delete Invoice';
const mnuBack = 'Back to List';

class InvoiceDetail extends StatefulWidget {
  final Invoice invoice;
  InvoiceDetail(this.invoice);

  @override
  State<StatefulWidget> createState() => InvoiceDetailState(invoice);
}

class InvoiceDetailState extends State {
  Invoice invoice;
  //Constructor to pass the invoice
  InvoiceDetailState(this.invoice);
  final _priorities = ["Due", "Open", "Paid"];
  String _priority = "Open";
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    titleController.text = invoice.title;
    descriptionController.text = invoice.description;
    TextStyle textStyle = Theme.of(context).textTheme.headline5;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, title: Text(invoice.title),
          //Action to make the menu interactive
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: select,
              itemBuilder: (BuildContext context) {
                return choices.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: Padding(
            padding: EdgeInsets.only(top: 35.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    TextField(
                      controller: titleController,
                      style: textStyle,
                      onChanged: (value) => this.updateTitle(),
                      decoration: InputDecoration(
                          labelText: "Title",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: TextField(
                          controller: descriptionController,
                          style: textStyle,
                          onChanged: (value) => this.updateDescription(),
                          decoration: InputDecoration(
                              labelText: "Description",
                              labelStyle: textStyle,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        )),
                    ListTile(
                        title: DropdownButton<String>(
                      items: _priorities.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      style: textStyle,
                      value: retrievePriority(invoice.priority),
                      onChanged: (value) => updatePriority(value),
                    ))
                  ],
                )
              ],
            )));
  }

  //Menu item selected by the user
  void select(String value) async {
    int result;
    switch (value) {
      case mnuSave:
        save();
        break;
      case mnuDelete:
        Navigator.pop(context, true); //Takes you back to the previous screen
        if (invoice.id == null) {
          return;
        }
        result = await helper.deleteInvoice(invoice.id);
        if (result != 0) {
          AlertDialog alertDialog = AlertDialog(
            title: Text("Delete Invoice"),
            content: Text("The Invoice has been deleted"),
          );
          showDialog(context: context, builder: (_) => alertDialog);
        }
        break;
      case mnuBack:
        Navigator.pop(context, true); //Takes you back to the previous screen
        break;
      default:
    }
  }

  //Save method
  void save() {
    invoice.date = new DateFormat.yMd().format(DateTime.now());
    if (invoice.id != null) {
      helper.updateInvoice(invoice);
    } else {
      helper.insertInvoice(invoice);
    }
    Navigator.pop(context, true);
  }

//Below we have helping methods to format our values
  void updatePriority(String value) {
    switch (value) {
      case "Due":
        invoice.priority = 1;
        break;
      case "Open":
        invoice.priority = 2;
        break;
      case "Paid":
        invoice.priority = 3;
        break;
    }
    setState(() {
      _priority = value;
    });
  }

  String retrievePriority(int value) {
    return _priorities[value - 1];
  }

  void updateTitle() {
    invoice.title = titleController.text;
  }

  void updateDescription() {
    invoice.description = descriptionController.text;
  }
}

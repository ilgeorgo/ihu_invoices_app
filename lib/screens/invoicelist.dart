import 'package:flutter/material.dart';
import 'package:invoices_app/util/dbhelper.dart';
import 'package:invoices_app/model/invoice.dart';
//in order to start navigating between screens
import 'package:invoices_app/screens/invoicedetail.dart';

class InvoiceList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InvoiceListState();
  // TODO: implement createState

}

class InvoiceListState extends State {
  @override
  DbHelper helper = DbHelper();
  List<Invoice> invoices;
  int count = 0;
  Widget build(BuildContext context) {
    //DbHelper will retrieve the data
    if (invoices == null) {
      invoices = List<Invoice>();
      getData();
    }
    //Here we build the UI
    return Scaffold(
      body: invoiceListItems(),
      floatingActionButton: FloatingActionButton(
        //When we press the button we navigate to the second screen to add a new invoice
        onPressed: () {
          navigateToDetail(Invoice("", 3, ""));
        },
        tooltip: "Add new Invoice",
        //CHange the icon here to money or invoice
        child: new Icon(Icons.add),
      ),
    );
  }

  ListView invoiceListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getColor(this.invoices[position].priority),
              child: Text(this.invoices[position].priority.toString()),
            ),
            title: Text(this.invoices[position].title),
            subtitle: Text(this.invoices[position].date),
            onTap: () {
              debugPrint("Tapped on " + this.invoices[position].id.toString());
              navigateToDetail(this.invoices[position]);
            },
          ),
        );
      },
    );
  }

  //method to get the data from the database
  void getData() {
    final dbFuture = helper.initializeDb();
    //Then is executed only when the database is succesfully opened or created
    dbFuture.then((result) {
      //we declare another future here
      final invoicesFuture = helper.getInvoices();
      //this method retrieves all the records  from the invoices table
      invoicesFuture.then((result) {
        List<Invoice> invoiceList = List<Invoice>();
        count = result.length;
        //For loop for each item of the list
        for (int i = 0; i < count; i++) {
          //transforms a generic object to an invoice as per model
          invoiceList.add(Invoice.fromObject(result[i]));
          debugPrint(invoiceList[i].title);
        }
        setState(() {
          //Here we assign the invoices list to the invoices property and count to count
          invoices = invoiceList;
          count = count;
        });
        debugPrint("Invoices " + count.toString());
      });
    });
  }

  Color getColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.orange;
        break;
      case 3:
        return Colors.green;
        break;
      default:
        return Colors.blue;
    }
  }

//Navigation
  void navigateToDetail(Invoice invoice) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (Context) => InvoiceDetail(invoice)),
    );
    if (result == true) {
      getData();
    }
  }
}

//Here we add the properties of an Invoice
class Invoice {
  int _id;
  String _vatnumber;
  String _title;
  String _description;
  String _amount;
  String _date;
  int _priority;

//Constructor for when creating a new invoice without database id
//Above fields must be added here
  Invoice(
      this._vatnumber, this._title, this._priority, this._amount, this._date,
      [this._description]);

//Constructor for when you have the database id
  Invoice.withId(this._id, this._vatnumber, this._title, this._priority,
      this._amount, this._date,
      [this._description]);

//Getters
  int get id => _id;
  String get vatnumber => _vatnumber;
  String get title => _title;
  String get description => _description;
  int get priority => _priority;
  String get amount => _amount;
  String get date => _date;

//Setters (id will never change so we dont need it)
  set vatnumber(String newVatnumber) {
    //Check to be less than 255
    if (newVatnumber.length <= 255) {
      _vatnumber = newVatnumber;
    }
  }

  set title(String newTitle) {
    //Check to be less than 255
    if (newTitle.length <= 255) {
      _title = newTitle;
    }
  }

  set description(String newDescription) {
    //Check to be less than 255
    if (newDescription.length <= 255) {
      _description = newDescription;
    }
  }

  set priority(int newPriority) {
    //Check to be higher than 0 and smaller than 3
    if (newPriority >= 0 && newPriority <= 3) {
      _priority = newPriority;
    }
  }

  set amount(String newAmount) {
    //Check to be higher than 0 and smaller than 3
    if (newAmount.length <= 255) {
      _amount = newAmount;
    }
  }

  set date(String newDate) {
    //Sets new date
    _date = newDate;
  }

  //Map method -> Map: Collection of key value pair from which you retrieve the value using the associated key, it will be used with the sqlite
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["vatnumber"] = _vatnumber;
    map["amount"] = _amount;
    map["title"] = _title;
    map["description"] = _description;
    map["priority"] = _priority;
    map["date"] = _date;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  //Named consctructor - opposite of the map method, we take in any objects and transform it, into an invoice
  //Takes an object "o"
  Invoice.fromObject(dynamic o) {
    this._id = o["id"];
    this._vatnumber = o["vatnumber"];
    this._amount = o["amount"];
    this._title = o["title"];
    this._priority = o["priority"];
    this._date = o["date"];
    this._description = o["description"];
  }
}
//First we finish the dependency of the slq in the yaml file, then we go to the dbhelper.dart file for the db

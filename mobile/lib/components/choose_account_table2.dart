import 'dart:developer';
import 'package:cakrawala_mobile/Screens/Transfer/components/dummy_data.dart';
import 'package:cakrawala_mobile/components/search_box.dart';
import 'package:cakrawala_mobile/components/text_account_attribute.dart';
import 'package:flutter/material.dart';

import 'choose_account_table1.dart';

// global variable
User currentUser = User.fromJson(
    {
      "id": -1,
      "name": "Unknown",
      "phone": "-1",
      "exp": 0,
      "email" : "Unknown"
    }
);

// class User {
//   int id;
//   String name;
//   String phone;
//   int exp;
//   String email;
//   bool selected = false;
//
//   User(this.id, this.name, this.phone, this.exp, this.email);
//   factory User.fromJson(dynamic json) {
//     return User(
//         json['id'] as int,
//         json['Name'] as String,
//         json['Phone'] as String,
//         json['exp'] as int,
//         json['email'] as String)
//     ;
//   }
//
//   @override
//   String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
//     return '{${this.id}, ${this.name}, ${this.phone}, ${this.exp}, ${this.email}}';
//   }
//
//   static User getSelectedUser() {
//     log('selected:${currentUser.name}');
//     return currentUser;
//   }
// }

class ChooseAccountTable extends StatefulWidget {
  ChooseAccountTable({Key? key}) : super(key: key);

  @override
  State<ChooseAccountTable> createState() => _ChooseAccountTableState();
}

class _ChooseAccountTableState extends State<ChooseAccountTable> {
  List<User> users = DummyData().data.map((e) =>
      User.fromJson(e)).toList();
  List<User> usersFiltered = [];
  TextEditingController controller = TextEditingController();
  String _searchResult = '';
  
  @override
  void initState() {
    super.initState();
    usersFiltered = users;
  }

  double handleOverflow(BuildContext context) {
    var bottom = MediaQuery.of(context).viewInsets.bottom;
    if (bottom > 0) {
      return bottom - 0.42 * bottom;
    } else { return 0; }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width

    return Column(
      children: [
        Container(
          width: .8 * size.width,
          child: SearchBox(
              hintText: 'Search account',
              onChanged: (value) {
                setState(() {
                  _searchResult = value;
                  usersFiltered = users.where((user) =>
                      (user.name.toLowerCase().contains(_searchResult))||
                          user.phone.contains(_searchResult)).toList();
                });
              }
          ),
        ),
        Container(
          width: size.width,
          height: .6598 * size.height,
          padding: EdgeInsets.only (
            bottom: handleOverflow(context),
          ),
          child: SingleChildScrollView (
            child: DataTable(
                // border: TableBorder.all(color: Colors.black),
                dividerThickness: 0,
                dataRowHeight: 0.12 * size.height,
                headingRowHeight: 0,
                horizontalMargin: 0,
                columnSpacing: 0,
                showCheckboxColumn: false,
                columns: const <DataColumn> [
                  DataColumn(label: Text('p')),
                  DataColumn(label: Text('a')),
                  DataColumn(label: Text('asd')),
                  DataColumn(label: Text('asd')),
                  DataColumn(label: Text('asd')),
                  DataColumn(label: Text('p')),
                ],
                rows: List.generate(usersFiltered.length, (index) =>
                    DataRow(
                    selected: usersFiltered[index].selected,
                    onSelectChanged: (val) {
                      setState(() {
                        // hide keyboard when user selected
                        FocusScope.of(context).requestFocus(new FocusNode());

                        currentUser = usersFiltered[index];
                        log('$currentUser');

                        // reset all selected when clicked
                        for (var u in users) {
                          u.selected = false;
                        }

                        // assign new selected value
                        if (usersFiltered[index].selected == false && val == false) {
                          usersFiltered[index].selected = true;
                        } else {
                          usersFiltered[index].selected = val!;
                        }
                      });
                    },
                    color: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.selected)) {return Color(0xFF0090CE);}
                    }),
                    cells: <DataCell>[
                      DataCell(Container(width: 0.08 * size.width,)),
                      DataCell(
                            Align (
                              alignment: Alignment.centerLeft,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child:
                                Image.network(
                                  'https://picsum.photos/250?image=${usersFiltered[index].id}',
                                  height: 0.13 * size.width,
                                  width: 0.13 * size.width,
                                ),
                              ),
                            ),
                          ),
                      DataCell(TextName(text: usersFiltered[index].name)),
                      DataCell(TextPhone(text:  usersFiltered[index].phone)),
                      DataCell(TextExp(text:  usersFiltered[index].exp.toString())),
                      DataCell(Container(width: 0.08 * size.width,)),
                    ]
                  )
                )
            ),
          ),
        ),
      ],
    );
  }
}
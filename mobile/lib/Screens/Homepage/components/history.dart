import 'dart:developer';

import "package:flutter/material.dart";
import 'package:cakrawala_mobile/utils/history-api.dart';
import 'package:cakrawala_mobile/Screens/Homepage/components/history_container.dart';
import 'package:intl/intl.dart';
import '../../../components/text_account_template.dart';
import '../../../constants.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late Future<List<TransactionHistory>> _transData;
  List<TransactionHistory> transData = [];

  @override
  void initState() {
    _transData = loadState();
    super.initState();
  }

  Color whatColor(String type) {
    if (type == "Topup") {
      return Colors.lightGreen;
    } return Colors.red;
  }

  String nominal(String type, String nominal) {
    if (type == "Topup") {
      return "+$nominal";
    } return "-$nominal";
  }

  Future<List<TransactionHistory>> loadState() async {
    List<TransactionHistory> _data = [];
    await HistoryAPI.getHistoryAdmin().then((data) {
      setState(() {
        transData.addAll(data);
        transData = transData.reversed.toList();
      });
      _data = data;
    });
    return _data;
  }

  // DataTable _createDataTable() {
  //   return DataTable(
  //     headingRowColor: MaterialStateProperty.all(null),
  //     headingRowHeight: 48,
  //     dataRowColor: MaterialStateProperty.all(null),
  //     dataTextStyle: const TextStyle(color: white),
  //     headingTextStyle: const TextStyle(color: white, fontWeight: FontWeight.w600),
  //     dividerThickness: .8,
  //     horizontalMargin: 8,
  //     columnSpacing: 35,
  //     columns: _createColumns(),
  //     rows: _createRows(),
  //   );
  // }

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text('Type')),
      const DataColumn(label: Text('Dest ID')),
      const DataColumn(label: Text('Amount')),
      const DataColumn(label: Text('Time'))
    ];
  }

  // List<DataRow> _createRows() {
  //   List<DataRow> rows = [];
  //   for (var t in transData) {
  //     rows.add(_createRow(t.transactionType, t.destID, t.nominal, t.createdAt));
  //   }
  //
  //   return rows;
  // }

  DataRow _createRow(
      String type, String destID, String nominal, String createdAt) {
    return DataRow(cells: [
      DataCell(Text(type)),
      DataCell(Text(destID)),
      DataCell(Text(nominal)),
      DataCell(Text(createdAt)),
    ]);
  }

  double handleOverflow(BuildContext context) {
    var bottom = MediaQuery.of(context).viewInsets.bottom;
    if (bottom > 0) {
      return bottom - 0.42 * bottom;
    } else { return 0; }
  }

  Widget listView() {
    return FutureBuilder<List<TransactionHistory>>(
        future: _transData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.only(bottom: handleOverflow(context)),
              child: ListView.builder(
                itemCount: transData.length,
                itemBuilder: (context, index) => Card(
                  shape: RoundedRectangleBorder (borderRadius: BorderRadius.circular(10)),
                  // color: selectedIndex == index? const Color(0xFFD6D6D6): Colors.white,
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 15),
                  child: ListTile(
                    minVerticalPadding: 0,
                    horizontalTitleGap: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.all(0),
                    tileColor: const Color(0xfff0f0f0),
                    // leading: Container(width: 8, color: Colors.red,),
                    // minLeadingWidth: 16,
                    title: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 7,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)
                                  ),
                                  color: whatColor(transData[index].transactionType) // TODO
                                ),
                              ),
                              Container(
                                width: 65,
                                height: 65,
                                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.15),
                                      spreadRadius: 0.25,
                                      blurRadius: 2,
                                      offset: Offset(0, 2), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextAccountTemplate(
                                      text: DateFormat('dd').format(transData[index].createdAt),
                                      align: TextAlign.left,
                                      weight: FontWeight.w800,
                                      size: 22,
                                      color: black
                                    ),
                                    TextAccountTemplate(
                                        text: DateFormat.MMMM().format(transData[index].createdAt),
                                        align: TextAlign.left,
                                        weight: FontWeight.w700,
                                        size: 14,
                                        color: Colors.black38
                                    ),
                                    // TextAccountTemplate(
                                    //     text: "2022",
                                    //     align: TextAlign.left,
                                    //     weight: FontWeight.w600,
                                    //     size: 12,
                                    //     color: Colors.black54
                                    // ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    transData[index].transactionType,
                                    style: const TextStyle (
                                        fontSize: 17,
                                        letterSpacing: 0.1,
                                        fontWeight: FontWeight.w800
                                    ),
                                  ),
                                  const SizedBox(height: 5,),
                                  TextAccountTemplate(
                                    text: DateFormat('yyyy hh:mm:ss').format(transData[index].createdAt),
                                    align: TextAlign.left,
                                    weight: FontWeight.w500,
                                    size: 14,
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                            ]
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 12),
                            child: TextAccountTemplate(
                              text: nominal(transData[index].transactionType, transData[index].nominal),
                              align: TextAlign.left,
                              weight: FontWeight.w600,
                              size: 18,
                              color: whatColor(transData[index].transactionType),
                            )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            log('${snapshot.error}');
          }
          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Screen height and width
    return SizedBox(
      width: .9 * size.width,
      height: .36 * size.height,
      child: listView(),
    );
  }
}

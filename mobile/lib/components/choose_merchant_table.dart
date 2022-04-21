import 'dart:developer';
import 'package:cakrawala_mobile/components/search_box.dart';
import 'package:cakrawala_mobile/utils/merchant-api.dart';
import 'package:flutter/material.dart';

// global variable
MerchantAPI mAPI = MerchantAPI();
Merchant currentMerchant = Merchant.fromJson(
    {
      "id": -1,
      "Name": "Unknown",
      "Address": "Unknown",
      "AccountId": "-1",
    }
);

class Merchant {
  int id;
  String name;
  String alamat;
  String no_rek;

  Merchant(this.id, this.name, this.alamat, this.no_rek);
  factory Merchant.fromJson(dynamic json) {
    return Merchant(
      json['id'] as int,
      json['Name'] as String,
      json['Address'] as String,
      json['AccountId'] as String);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '{${this.id}, ${this.name}, ${this.no_rek}}';
  }

  static Merchant getSelectedMerchant() {
    log('selected:${currentMerchant.name}');
    return currentMerchant;
  }
}

class ChooseMerchantTable extends StatefulWidget {
  ChooseMerchantTable({Key? key}) : super(key: key);

  @override
  State<ChooseMerchantTable> createState() => _ChooseMerchantTableState();
}

class _ChooseMerchantTableState extends State<ChooseMerchantTable> {
  // TODO array of merchants taroh disini
  late Future<List<Merchant>> _merchants;
  List<Merchant> merchants = [];
  List<Merchant> merchantsFiltered = [];
  TextEditingController controller = TextEditingController();
  String _searchResult = '';
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _merchants = loadData();
    log("merchants initState $merchants");
  }

  Future<List<Merchant>> loadData() async {
    List<Merchant> data = await mAPI.fetchMerchant();
    setState(() {
      merchants = data;
      merchantsFiltered = data;
    });
    return data;
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

    return Container (
      width: .9 * size.width,
      height: .7 * size.height,
      child: Column(
        children: [
          SearchBox(
              hintText: 'Search merchant',
              onChanged: (value) {
                setState(() {
                  _searchResult = value;
                  merchantsFiltered = merchants.where((merchant) =>
                  (merchant.name.toLowerCase().contains(_searchResult))).toList();
                });
              }
          ),
          const SizedBox(
            height: 16,
          ),
          FutureBuilder<List<Merchant>>(
            future: _merchants,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: handleOverflow(context)
                      ),
                      child: ListView.builder(
                        itemCount: merchantsFiltered.length,
                        itemBuilder: (context, index) => Card(
                          shape: RoundedRectangleBorder (
                              borderRadius: BorderRadius.circular(10)
                          ),
                          color: selectedIndex == index? const Color(0xFFD6D6D6): Colors.white,
                          elevation: 3,
                          margin: const EdgeInsets.only(bottom: 15),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child:
                              Image.network(
                                // TODO penyimpanan picture-nya nanti gimana ya?
                                'https://picsum.photos/250?image=${merchantsFiltered[index].id}',
                                height: 0.095 * size.width,
                                width: 0.095 * size.width,
                              ),
                            ),
                            title: Text(
                              merchantsFiltered[index].name,
                              style: const TextStyle (
                                  fontSize: 16,
                                  letterSpacing: 0.1,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                                FocusScope.of(context).requestFocus(new FocusNode());
                                currentMerchant = merchantsFiltered[index];
                                log("selected merchant: $currentMerchant");
                              });
                            },
                          ),
                        ),
                      ),
                    )
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            }
          )

        ],
      ),
    );
  }
}
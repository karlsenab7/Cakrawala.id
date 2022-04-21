import 'dart:developer';
import 'package:cakrawala_mobile/Screens/RedeemGift/components/dummy_data.dart';
import 'package:cakrawala_mobile/components/search_box.dart';
import 'package:cakrawala_mobile/utils/gift-api.dart';
import 'package:flutter/material.dart';

// global variable
GiftAPI gAPI = GiftAPI();
Gift currentGift = Gift.fromJson(
    {
      "id": -1,
      "name": "Unknown",
      "price": -1,
      "stock" : -1,
    }
);

class Gift {
  int id;
  String name;
  int price;
  int stock;

  Gift(this.id, this.name, this.price, this.stock);
  factory Gift.fromJson(dynamic json) {
    return Gift(
      json['id'] as int,
      json['name'] as String,
      json['price'] as int,
      json['stock'] as int);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '{${this.id}, ${this.name}, ${this.price}, ${this.stock}}';
  }

  static Gift getSelectedGift() {
    log('selected:${currentGift.name}');
    return currentGift;
  }
}

class ChooseGiftTable extends StatefulWidget {
  ChooseGiftTable({Key? key}) : super(key: key);

  @override
  State<ChooseGiftTable> createState() => _ChooseGiftTableState();
}

class _ChooseGiftTableState extends State<ChooseGiftTable> {
  late Future<List<Gift>> _gifts;
  List<Gift> gifts = [];
  List<Gift> giftsFiltered = [];
  TextEditingController controller = TextEditingController();
  String _searchResult = '';
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _gifts = loadData();
    log("gifts initState $gifts");
  }

  Future<List<Gift>> loadData() async {
    List<Gift> data = await gAPI.fetchGift();
    setState(() {
      gifts = data;
      giftsFiltered = data;
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
              hintText: 'Search gifts',
              onChanged: (value) {
                setState(() {
                  _searchResult = value;
                  giftsFiltered = gifts.where((gift) =>
                  (gift.name.toLowerCase().contains(_searchResult))).toList();
                });
              }
          ),
          const SizedBox(
            height: 16,
          ),
          FutureBuilder<List<Gift>>(
            future: _gifts,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: handleOverflow(context)
                      ),
                      child: ListView.builder(
                        itemCount: giftsFiltered.length,
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
                                // TODO
                                'https://picsum.photos/250?image=${giftsFiltered[index].id}',
                                height: 0.095 * size.width,
                                width: 0.095 * size.width,
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  giftsFiltered[index].name,
                                    style: const TextStyle (
                                        fontSize: 16,
                                        letterSpacing: 0.1,
                                        fontWeight: FontWeight.w600
                                    ),
                                ),
                                Text(
                                  "${giftsFiltered[index].price.toString()} points",
                                  style: const TextStyle (
                                      fontSize: 16,
                                      letterSpacing: 0.1,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                                FocusScope.of(context).requestFocus(new FocusNode());
                                currentGift = giftsFiltered[index];
                                log("selected gift: $currentGift");
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
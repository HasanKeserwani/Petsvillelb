import 'dart:core';
import 'package:flutter/material.dart';
import 'package:petsvillelb/item.dart';

class ShopPage extends StatefulWidget {

  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  double _sum = 0; // holds total price for selected items
  bool _showSelected = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      screenWidth = screenWidth * 0.8;
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        backgroundColor: Color.fromRGBO(12, 65, 91, 1.0),
        title: Image.asset('lib/images/Pet-Me-1-ai.png', height: 140, width: 140,),
        centerTitle: true,
        actions: [
          // displays reset icon in AppBar
          Tooltip(
              message: 'Reset selection',
              child: IconButton(
                onPressed: () {
                  setState(() {
                    _sum = 0;
                    for (var e in items) {
                      e.selected = false;
                    }
                    _showSelected = false;
                  });
                },
                icon: const Icon(
                  Icons.restore,
                ),
              )),
          // displays show selected icon in AppBar
          Tooltip(
              message: 'Show/Hide Selected Items',
              child: IconButton(
                onPressed: () {
                  if (_sum != 0) {
                    setState(() {
                      _showSelected = !_showSelected;
                    });
                  }
                },
                icon: const Icon(
                  Icons.shopping_cart,
                ),
              ))
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Dog Food",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(12, 65, 91, 1.0)
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Divider(),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: _showSelected ? ShowSelectedItems(width: screenWidth) :
            ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(color: const Color.fromRGBO(215, 215, 215, 1.0), borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          Image.asset(items[index].image, height: 300, width: 300),
                          Text(items[index].name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(12, 65, 91, 1.0)),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                  value: items[index].selected,
                                  onChanged: (e) {
                                    items[index].selected = e as bool;
                                    if (items[index].selected) {
                                      // add its price to total price
                                      _sum += items[index].price;
                                    } else {
                                      // subtract its price from total price
                                      _sum -= items[index].price;
                                    }
                                    setState(() {});
                                  }),
                              Text("\$"+items[index].price.toString(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color.fromRGBO(12, 65, 91, 1.0)),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color.fromRGBO(12, 65, 91, 1.0),
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Price',
                        style: TextStyle(color: Colors.white),
                      ),

                      const SizedBox(height: 8),
                      // total price
                      Text(
                        '\$$_sum',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  // pay now
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: const Row(
                      children: [
                        Text(
                          'Pay Now',
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


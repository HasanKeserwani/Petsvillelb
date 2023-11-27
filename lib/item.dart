import 'package:flutter/material.dart';

class Item {
  final String name;
  final double price;
  final String image;
  bool selected = false;



  Item({required this.name, required this.price, required this.image});
}

List <Item> items = [
  Item(name: 'Bavaro Task', price: 15.0, image: "lib/images/bavaro-dogfood-task.png"),
  Item(name: 'Bavaro Solid', price: 16.0, image: "lib/images/bavaro-dogfood-solid.png"),
  Item(name: 'Bavaro Work', price: 17.0, image: "lib/images/bavaro-dogfood-work.png"),
  Item(name: 'Bavaro Force', price: 18.0, image: "lib/images/bavaro-dogfood-force.png")
];


class ShowSelectedItems extends StatelessWidget {
  const ShowSelectedItems({required this.width, Key? key}) : super(key: key);
  final double width;

  @override
  Widget build(BuildContext context) {
    List<Item> selectedItems = [];
    for (var e in items) {
      if (e.selected) {
        selectedItems.add(e);
      }
    }
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: selectedItems.length,
      itemBuilder: (context, index) {
        return Column(children: [
          const SizedBox(height: 10),
          SizedBox(width: width * 0.28),
          Text(
              selectedItems[index].name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 10),
          Text(
            '\$${selectedItems[index].price}',
            style: TextStyle(fontSize: 18),
          ),
          // get image from url stored in Item image field
          Image.asset(selectedItems[index].image,
              height: width * 0.5),
          const SizedBox(height: 10),
          const Divider(color: Color.fromRGBO(12, 65, 91, 1.0),),
        ]);
      },
    );
  }
}

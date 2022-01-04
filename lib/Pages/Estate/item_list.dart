import 'package:flutter/material.dart';
import 'package:flutter_secentry/Pages/Estate/item_pass.dart';
import 'package:flutter_secentry/constants/spaces.dart';

class ItemList extends StatelessWidget {
  final List<Item>? listofItems;
  const ItemList({Key? key, @required this.listofItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heightSpace(40),
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios)),
            heightSpace(20),
            Expanded(
              child: ListView.builder(
                  itemCount: listofItems!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.list),
                      title: Text(listofItems![index].itemName!),
                      subtitle: Text(listofItems![index].description!),
                      trailing: Text(listofItems![index].quantity.toString()),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

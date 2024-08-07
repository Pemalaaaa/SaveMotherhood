import 'package:flutter/material.dart';
import 'package:pema_la/models/ProductData.dart';
import 'package:pema_la/models/ProductList.dart';
import 'package:url_launcher/url_launcher.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({Key? key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
           centerTitle: true,
          title: Text("Shop Now !!!", style:TextStyle(fontWeight: FontWeight.w700), ),
          elevation: 0,
          backgroundColor: Color(0xFFFFC2CD),
        ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: Product_data.length,
        itemBuilder: (context, index) {
          return ProductlistCard(Product_data[index]);
          
        },
      ),
    );
  }

  ProductlistCard(Product product) {
    return Card(
      child: ListTile(
          contentPadding: EdgeInsets.all(10.0),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Image.asset(
                  product.image,
                  width: 100,
                  // height: 90,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 5),
              Text(product.name, style: TextStyle(fontWeight: FontWeight.bold)),
              Text("\$${product.price.toString()}"),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  launchProductLink(product.link);
                },
                child: Text(
                  "Visite Official site",
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
          onTap: () {
            print('Tapped on the card for ${product.name}');
          }),
    );
  }

  void launchProductLink(String link) async {
    final uri = Uri.parse(link);
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      print('Could not launch $link');
    }
  }
}

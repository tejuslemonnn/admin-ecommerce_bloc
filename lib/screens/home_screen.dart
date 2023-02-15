import 'package:admin_ecommerce_bloc/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeSreen extends StatelessWidget {
  const HomeSreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Ecommerce"),
        backgroundColor: Colors.black,
      ),
      body: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 150,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () {
                  Get.to(() =>  ProductScreen());
                },
                child: const Card(
                  child: Center(
                    child: Text("Go To Products"),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

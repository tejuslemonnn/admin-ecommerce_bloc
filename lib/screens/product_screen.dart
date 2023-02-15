import 'package:admin_ecommerce_bloc/components/components.dart';
import 'package:admin_ecommerce_bloc/components/header_button.dart';
import 'package:admin_ecommerce_bloc/controllers/product_controller.dart';
import 'package:admin_ecommerce_bloc/screens/new_product_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({Key? key}) : super(key: key);

  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderButton(
                onPressed: () {
                  Get.to(() => NewProductScreen());
                },
                height: 80.h,
                text: "Add a New Product"),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: productController.products.length,
                  itemBuilder: (context, index) {
                    return Obx(() {
                      return SizedBox(
                        height: 170.h,
                        child: ProductCart(
                          product: productController.products[index],
                          index: index,
                        ),
                      );
                    });
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}

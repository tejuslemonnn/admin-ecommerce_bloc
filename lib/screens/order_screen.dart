import 'package:admin_ecommerce_bloc/components/header_button.dart';
import 'package:admin_ecommerce_bloc/controllers/controllers.dart';
import 'package:admin_ecommerce_bloc/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({Key? key}) : super(key: key);

  final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: orderController.pendingOrders.length,
                itemBuilder: (context, index) {
                  return OrderCard(
                    orderModel: orderController.pendingOrders[index],
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
   OrderCard({Key? key, required this.orderModel}) : super(key: key);

  final OrderModel orderModel;
  final OrderController orderController = Get.find();

  @override
  Widget build(BuildContext context) {
    var products = Product.productsDummy
        .where((product) => orderModel.productId.contains(product.id))
        .toList();

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order ID: ${orderModel.id}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    DateFormat("dd-MM-yy").format(orderModel.createdAt),
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 70.h,
                          width: 70.w,
                          child: Image.network(
                            products[index].imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                products[index].name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                products[index].description,
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                                maxLines: 5,
                                softWrap: true,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Deliver Fee",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "\$${orderModel.deliveryFee}",
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "\$${orderModel.total}",
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Flexible(
                    child: HeaderButton(
                      onPressed: () {
                        orderController.updateOrder(orderModel, "isAccepted", !orderModel.isAccepted);
                      },
                      height: 40.h,
                      text: "Accept",
                    ),
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    child: HeaderButton(
                      onPressed: () {
                        orderController.updateOrder(orderModel, "isCancelled", !orderModel.isCancelled);
                      },
                      height: 40.h,
                      text: "Reject",
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

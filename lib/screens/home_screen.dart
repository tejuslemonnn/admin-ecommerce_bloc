import 'package:admin_ecommerce_bloc/controllers/controllers.dart';
import 'package:admin_ecommerce_bloc/models/order_stats.dart';
import 'package:admin_ecommerce_bloc/screens/order_screen.dart';
import 'package:admin_ecommerce_bloc/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HomeSreen extends StatelessWidget {
  HomeSreen({Key? key}) : super(key: key);

  final OrderStatsController orderStatsController =
      Get.put(OrderStatsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Ecommerce"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder(
              future: orderStatsController.stats.value,
              builder: (context, AsyncSnapshot<List<OrderStats>> snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    height: 225.h,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CustomBarChart(
                          orderStats: snapshot.data!,
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              },
            ),
            SizedBox(
              width: double.infinity,
              height: 150,
              child: InkWell(
                onTap: () {
                  Get.to(() => ProductScreen());
                },
                child: const Card(
                  child: Center(
                    child: Text("Go To Products"),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 150,
              child: InkWell(
                onTap: () {
                  Get.to(() => OrderScreen());
                },
                child: const Card(
                  child: Center(
                    child: Text("Go To Order Screen"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomBarChart extends StatelessWidget {
  const CustomBarChart({Key? key, required this.orderStats}) : super(key: key);

  final List<OrderStats> orderStats;

  @override
  Widget build(BuildContext context) {
    List<charts.Series<OrderStats, String>> series = [
      charts.Series(
        id: 'orders',
        data: orderStats,
        domainFn: (datum, index) => index.toString(),
        measureFn: (datum, index) => datum.orders,
        colorFn: (datum, index) => datum.barColor!,
      )
    ];
    return charts.BarChart(
      series,
      animate: true,
    );
  }
}

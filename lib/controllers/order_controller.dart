import 'package:admin_ecommerce_bloc/models/models.dart';
import 'package:admin_ecommerce_bloc/services/database_service.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final DatabaseService databaseService = DatabaseService();

  var orders = <OrderModel>[].obs;
  var pendingOrders = <OrderModel>[].obs;

  @override
  void onInit() {
    orders.bindStream(databaseService.gerOrders());
    pendingOrders.bindStream(databaseService.getPendingOrders());
    super.onInit();
  }

  void updateOrder(OrderModel order, String field, bool value){
    databaseService.updateOrder(order, field, value);
  }
}
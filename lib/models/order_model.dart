import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
  @override
  List<Object?> get props => [
        id,
        customerId,
        productId,
        deliveryFee,
        subTotal,
        total,
        isAccepted,
        isDelivered,
        isCancelled,
        createdAt,
      ];

  final int id;
  final int customerId;
  final List<int> productId;
  final double deliveryFee;
  final double subTotal;
  final double total;
  final bool isAccepted;
  final bool isDelivered;
  final bool isCancelled;
  final DateTime createdAt;

  const OrderModel({
    required this.id,
    required this. customerId,
    required this.productId,
    required this.deliveryFee,
    required this.subTotal,
    required this.total,
    required this.isAccepted,
    required this.isDelivered,
    required this.isCancelled,
    required this.createdAt,
  });

  OrderModel copyWith({
    int? id,
    int? customerId,
    List<int>? productId,
    double? deliveryFee,
    double? subTotal,
    double? total,
    bool? isAccepted,
    bool? isDelivered,
    bool? isCancelled,
    DateTime? createdAt,
  }) {
    return OrderModel(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      productId: productId ?? this.productId,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      subTotal: subTotal ?? this.subTotal,
      total: total ?? this.total,
      isAccepted: isAccepted ?? this.isAccepted,
      isDelivered: isDelivered ?? this.isDelivered,
      isCancelled: isCancelled ?? this.isCancelled,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'productId': productId,
      'deliveryFee': deliveryFee,
      'subTotal': subTotal,
      'total': total,
      'isAccepted': isAccepted,
      'isDelivered': isDelivered,
      'isCancelled': isCancelled,
      'createdAt': createdAt,
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snap) {
    return OrderModel(
      id: snap['id'],
      customerId: snap['customerId'],
      productId: List<int>.from(snap['productId']),
      deliveryFee: snap['deliveryFee'].toDouble(),
      subTotal: snap['subTotal'].toDouble(),
      total: snap['total'].toDouble(),
      isAccepted: snap['isAccepted'],
      isDelivered: snap['isDelivered'],
      isCancelled: snap['isCancelled'],
      createdAt: snap['createdAt'].toDate(),
    );
  }

  static List<OrderModel> orders = [
    OrderModel(
      id: 1,
      customerId: 2345,
      productId: const [1, 2],
      deliveryFee: 10,
      subTotal: 20,
      total: 30,
      isAccepted: false,
      isDelivered: false,
      isCancelled: false,
      createdAt: DateTime.now(),
    ),
    OrderModel(
      id: 2,
      customerId: 23,
      productId: const [1, 2, 3],
      deliveryFee: 10,
      subTotal: 30,
      total: 30,
      isAccepted: false,
      isDelivered: false,
      isCancelled: false,
      createdAt: DateTime.now(),
    ),
  ];
}

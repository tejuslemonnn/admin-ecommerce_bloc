import 'package:admin_ecommerce_bloc/components/header_button.dart';
import 'package:admin_ecommerce_bloc/controllers/controllers.dart';
import 'package:admin_ecommerce_bloc/models/models.dart';
import 'package:admin_ecommerce_bloc/services/database_service.dart';
import 'package:admin_ecommerce_bloc/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NewProductScreen extends StatelessWidget {
  NewProductScreen({Key? key}) : super(key: key);

  final ProductController productController = Get.find();
  StorageService storageService = StorageService();
  DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Product'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Obx(() {
          return SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderButton(
                  onPressed: () async {
                    ImagePicker picker = ImagePicker();
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);

                    if (image == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("No Image was Selected."),
                        ),
                      );
                    }

                    if (image != null) {
                      storageService.uploadImage(image);
                      var imageUrl =
                          await storageService.getDownloadUrl(image.name);

                      productController.newProduct.update(
                        'imageUrl',
                        (value) => imageUrl,
                        ifAbsent: () => imageUrl,
                      );

                      print(productController.newProduct['imageUrl']);
                    }
                  },
                  height: 80.h,
                  text: "Add a Image",
                ),
                const SizedBox(height: 20),
                const Text(
                  "Product Information",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildTextFormField("ID", 'id', productController),
                _buildTextFormField("Product Name", "name", productController),
                _buildTextFormField(
                    "Description", "description", productController),
                _buildTextFormField("Category", "category", productController),
                const SizedBox(height: 10),
                _buildSlider("Price", 'price', productController,
                    productController.price),
                _buildSlider("Quantity", 'quantity', productController,
                    productController.quantity),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                        child: _buildCheckBox(
                            "Recommend",
                            'isRecommended',
                            productController,
                            productController.isRecommended)),
                    Expanded(
                        child: _buildCheckBox("Popular", 'isPopular',
                            productController, productController.isPopular)),
                  ],
                ),
                Center(
                  child: TextButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.black)),
                    onPressed: () {
                      print(productController.newProduct);

                      databaseService.addProduct(Product(
                        id: int.parse(productController.newProduct['id']),
                        name: productController.newProduct['name'],
                        category: productController.newProduct['category'],
                        description:
                            productController.newProduct['description'],
                        imageUrl: productController.newProduct['imageUrl'],
                        isRecommended:
                            productController.newProduct['isRecommended'] ??
                                false,
                        isPopular:
                            productController.newProduct['isPopular'] ?? false,
                        price: productController.newProduct['price'],
                        quantity: productController.newProduct['quantity'].toInt(),
                      ));

                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  TextFormField _buildTextFormField(
    String hintText,
    String name,
    ProductController productController,
  ) {
    return TextFormField(
      decoration: InputDecoration(hintText: hintText),
      onChanged: (value) {
        productController.newProduct.update(
          name,
          (_) => value,
          ifAbsent: () => value,
        );
      },
    );
  }

  Widget _buildSlider(
    String text,
    String name,
    ProductController productController,
    double? controllerValue,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 75.w,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Slider(
            value: controllerValue ?? 0,
            min: 0,
            max: 25,
            divisions: 10,
            activeColor: Colors.black,
            inactiveColor: Colors.black12,
            onChanged: (value) {
              productController.newProduct.update(
                name,
                (_) => value,
                ifAbsent: () => value,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCheckBox(
    String text,
    String name,
    ProductController productController,
    bool? controllerValue,
  ) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Checkbox(
          value: controllerValue ?? false,
          activeColor: Colors.black12,
          checkColor: Colors.black,
          onChanged: (value) {
            productController.newProduct.update(
              name,
              (_) => value,
              ifAbsent: () => value,
            );
          },
        ),
      ],
    );
  }
}

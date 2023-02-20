import 'package:flutter/material.dart';
import 'package:proudcto_app/models/models.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ProductResponse product;
  ProductFormProvider(this.product);

  updateAvailable(bool value) {
    product.available = value;
    notifyListeners();
  }

  bool isValidForm() {
    // print(product.id);
    // print(product.price);
    // print(product.name);
    return formKey.currentState?.validate() ?? false;
  }
}

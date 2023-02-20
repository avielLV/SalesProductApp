import 'package:flutter/material.dart';
import 'package:proudcto_app/models/models.dart';
import 'package:proudcto_app/screens/screens.dart';
import 'package:proudcto_app/services/services.dart';
import 'package:proudcto_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    return productService.isloading
        ? const LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Productos'),
              actions: [
                IconButton(
                    onPressed: () {
                      authService.logout();
                      Navigator.pushReplacementNamed(context, 'login');
                    },
                    icon: const Icon(Icons.login_rounded))
              ],
            ),
            body: ListView.builder(
              itemCount: productService.products.length,
              itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    productService.selectedProduct =
                        productService.products[index].copy();

                    Navigator.pushNamed(context, 'product');
                  },
                  child: ProductCard(
                    product: productService.products[index],
                  )),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                productService.selectedProduct = ProductResponse(
                  available: false,
                  name: '',
                  price: 0,
                );
                Navigator.pushNamed(context, 'product');
              },
              child: const Icon(Icons.add_rounded),
            ),
          );
  }
}

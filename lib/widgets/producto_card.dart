import 'package:flutter/material.dart';
import 'package:proudcto_app/helpers/image_converter.dart';
import 'package:proudcto_app/models/models.dart';

class ProductCard extends StatelessWidget {
  final ProductResponse product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 20),
        width: double.infinity,
        height: 400,
        decoration: _cardBorders(),
        // color: Colors.deepPurple,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroundImage(product.picture),
            _ProductorDetails(product),
            Positioned(top: 0, right: 0, child: _PriceTag(product)),
            if (!product.available)
              Positioned(top: 0, left: 0, child: _NotAvailable(product)),
          ],
        ),
        // child: ,
      ),
    );
  }

  BoxDecoration _cardBorders() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 7),
            blurRadius: 10,
          )
        ]);
  }
}

class _NotAvailable extends StatelessWidget {
  final ProductResponse product;

  const _NotAvailable(
    this.product,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      decoration: BoxDecoration(
          color: Colors.yellow[800],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25), bottomRight: Radius.circular(25))),
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'No disponible',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {
  final ProductResponse product;

  const _PriceTag(
    this.product,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25), bottomLeft: Radius.circular(25))),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '\$${product.price}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductorDetails extends StatelessWidget {
  final ProductResponse product;

  const _ProductorDetails(this.product);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 54),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        // color: Colors.red,
        decoration: _buildBoxDecoration(),
        height: 80,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              product.id!,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
      color: Colors.deepPurple,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25), topRight: Radius.circular(25)));
}

class _BackgroundImage extends StatelessWidget {
  final String? url;
  const _BackgroundImage(this.url);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: SizedBox(
          width: double.infinity,
          height: 400,
          child: url == null
              ? const Image(
                  image: AssetImage(
                    'asset/no-image.png',
                  ),
                  fit: BoxFit.cover,
                )
              : url!.startsWith('http')
                  ? FadeInImage(
                      placeholder: const AssetImage('asset/jar-loading.gif'),
                      image: NetworkImage(url!),
                      fit: BoxFit.cover,
                    )
                  : FadeInImage(
                      placeholder: const AssetImage('asset/jar-loading.gif'),
                      image: MemoryImage(
                          ImagenConveterBase64().base64ToImage(url ?? '')),
                      fit: BoxFit.cover,
                    ),
        ));
  }
}

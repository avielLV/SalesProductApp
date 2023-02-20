import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:proudcto_app/helpers/image_converter.dart';

class ProductImage extends StatelessWidget {
  final String? url;
  const ProductImage({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    log(url.toString());
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        width: double.infinity,
        height: 450,
        decoration: _buildBoxDecoration(),
        child: Opacity(
          opacity: 0.9,
          child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(45),
                topRight: Radius.circular(45),
              ),
              child: getImage(url)),
        ),
      ),
    );
  }

  Widget getImage(String? picture) {
    if (picture == null) {
      return const Image(
        image: AssetImage(
          'asset/no-image.png',
        ),
        fit: BoxFit.cover,
      );
    }
    if (picture.startsWith('http')) {
      log('true');
      return FadeInImage(
        placeholder: const AssetImage('asset/jar-loading.gif'),
        image: NetworkImage(picture),
        fit: BoxFit.cover,
      );
    }
    if (picture.startsWith('/9j/')) {
      log('true');
      return FadeInImage(
        placeholder: const AssetImage('asset/jar-loading.gif'),
        image: MemoryImage(ImagenConveterBase64().base64ToImage(url ?? '')),
        fit: BoxFit.cover,
      );
    }
    return Image.file(
      File(picture),
      fit: BoxFit.cover,
    );
    // ? const Image(
    //     image: AssetImage(
    //       'asset/no-image.png',
    //     ),
    //     fit: BoxFit.cover,
    //   )
    // : FadeInImage(
    //     placeholder: const AssetImage('asset/jar-loading.gif'),
    //     image: NetworkImage(url!),
    //     fit: BoxFit.cover,
    //   );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.black12,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(45),
            topRight: Radius.circular(45),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5))
          ]);
}

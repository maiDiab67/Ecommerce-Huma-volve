import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareProductButton extends StatelessWidget {
  final String productId;
  const ShareProductButton({required this.productId});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final productLink =
            'https://humavolve1234567890.web.app/products/$productId';
        final String shareMsg = "Look at this Product: $productLink";
        await SharePlus.instance.share(
          ShareParams(
            text: shareMsg,
            subject: 'Check out this product on Huma volve ',
          ),
        );
      },
      icon: Icon(Icons.share),
    );
  }
}

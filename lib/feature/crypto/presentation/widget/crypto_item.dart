import 'package:crypto_test/theme/colors_app.dart';
import 'package:crypto_test/theme/text_style_app.dart';
import 'package:flutter/material.dart';

class CryptoItem extends StatelessWidget {
  final String cryptoName;
  final String cryptoPrice;
  const CryptoItem({
    super.key,
    required this.cryptoName,
    required this.cryptoPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: ColorsApp.primaryAppColor,
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              const SizedBox(width: 16),
              Text(cryptoName, style: TextStyleApp.textBody14),
            ],
          ),

          Text(cryptoPrice, style: TextStyleApp.textBody14),
        ],
      ),
    );
  }
}

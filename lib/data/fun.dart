import 'package:flutter/material.dart';
import 'package:hammies_user/model/item.dart';

extension PriceIntExtension on ItemModel {
  int getPrice() {
    if (!(this.discountPrice == null) && this.discountPrice != 0) {
      return this.discountPrice!;
    }
    if (!(this.selectedSize == null)) {
      return this.selectedSize!.price;
    }
    return this.price;
  }
}

extension PriceExtension on ItemModel {
  Widget priceText() {
    if (!(this.discountPrice == null) && this.discountPrice != 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${this.price}Ks",
            style: TextStyle(
              decoration: TextDecoration.lineThrough,
            ),
          ),
          5.v(),
          Text(
            "${this.discountPrice}Ks",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      );
    }
    if (!(this.selectedSize == null)) {
      return Text("${selectedSize?.price}Ks",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18));
    }
    if (this.sizeList?.isNotEmpty == true) {
      var text = this.sizeList!.fold(
          "",
          (String previousValue, element) =>
              previousValue +
              (previousValue.isEmpty ? "" : " - ") +
              "${element.price.toString()}Ks");
      return Text(text,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18));
    }
    return Text("${this.price.toString()}Ks",
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18));
  }
}

extension VerticalExtension on int {
  Widget v() => SizedBox(
        height: this + 0.0,
      );
}

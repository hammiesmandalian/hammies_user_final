import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hammies_user/controller/home_controller.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/constant.dart';
import '../../model/item.dart';

var notOutOfStockBox = BoxDecoration(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(10),
    bottomLeft: Radius.circular(10),
  ),
  color: Colors.grey.shade300,
);
var outOfStockBox = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10)),
  color: Colors.grey.shade300,
);

SizedBox addButton(ItemModel model) {
  HomeController controller = Get.find();
  return SizedBox(
    height: 40,
    child: Row(children: [
      Expanded(
        flex: 2,
        child: Container(
          decoration: notOutOfStockBox,
          child: TextButton(
            onPressed: null,
            child: Text("Add",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                )),
          ),
        ),
      ),
      Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            color: homeIndicatorColor,
          ),
          child: IconButton(
              onPressed: () {
                controller.addToCart(itemModel: model);
                controller.makeAdded(model);
                //Do something
              },
              icon: Icon(
                FontAwesomeIcons.plus,
                color: Colors.white,
                size: 15,
              ))),
    ]),
  );
}

SizedBox addedButton() {
  return SizedBox(
    height: 40,
    child: Row(children: [
      Expanded(
        flex: 1,
        child: Container(
          decoration: outOfStockBox,
          child: TextButton(
            onPressed: null,
            child: Text("Added",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                )),
          ),
        ),
      ),
    ]),
  );
}

SizedBox outOfStockButton() {
  return SizedBox(
    height: 40,
    child: Row(children: [
      Expanded(
        flex: 1,
        child: Container(
          decoration: outOfStockBox,
          child: TextButton(
            onPressed: null,
            child: Text("Out of Stock",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                )),
          ),
        ),
      ),
    ]),
  );
}

Widget circularNetworkImage(String url, double radius) {
  return CachedNetworkImage(
    imageBuilder: (context, imageProvider) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: imageProvider,
      );
    },
    progressIndicatorBuilder: (context, url, status) {
      return Shimmer.fromColors(
        child: CircleAvatar(
          radius: radius,
          backgroundColor: Colors.white,
        ),
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
      );
    },
    errorWidget: (context, url, whatever) {
      return const Text("Image not available");
    },
    imageUrl: url,
    fit: BoxFit.fitHeight,
  );
}

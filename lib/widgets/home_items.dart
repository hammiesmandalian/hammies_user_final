import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hammies_user/model/item.dart';
import 'package:hammies_user/utils/widget/widget.dart';

import '../controller/home_controller.dart';
import '../data/constant.dart';
import '../routes/routes.dart';

class HomeItems extends StatelessWidget {
  const HomeItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();

    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: StaggeredGridView.countBuilder(
          staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
          shrinkWrap: true,
          physics: ScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          itemCount: controller.getItems().length,
          itemBuilder: (_, i) => GestureDetector(
            onTap: controller.getItems()[i].remainQuantity == 0
                ? null
                : () {
                    controller.setSelectedItem(controller.getItems()[i]);
                    Get.toNamed(detailScreen);
                  },
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ConstrainedBox(
                constraints: BoxConstraints(),
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      border: Border.all(
                        color: homeIndicatorColor,
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: controller.getItems()[i].photo,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: CachedNetworkImage(
                            imageUrl: controller.getItems()[i].photo,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                "${controller.getItems()[i].price} Kyats",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 5,
                                right: 5,
                                bottom: 10,
                                top: 2,
                              ),
                              child: Text(
                                controller.getItems()[i].name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            //Button
                            ProductActionButton(
                              currentItem: controller.getItems()[i],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductActionButton extends StatelessWidget {
  final ItemModel currentItem;
  const ProductActionButton({
    Key? key,
    required this.currentItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    return Obx(() {
      final currentProduct = controller.items
          .where((element) => element.id == currentItem.id)
          .first;
      final isOutOfStock = currentProduct.remainQuantity == 0;
      final isAdded = currentProduct.count! > 0;
      if (isOutOfStock) {
        return outOfStockButton();
      } else if (isAdded) {
        return addedButton();
      } else {
        return addButton(currentProduct);
      }
    });
  }
}

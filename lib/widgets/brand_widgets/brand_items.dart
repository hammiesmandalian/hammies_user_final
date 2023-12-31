import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../controller/home_controller.dart';
import '../../routes/routes.dart';

class BrandItems extends StatelessWidget {
  const BrandItems({Key? key}) : super(key: key);

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
          itemCount: controller.getBrandItems().length,
          itemBuilder: (_, i) => GestureDetector(
            onTap: () {
              controller.setSelectedItem(controller.getBrandItems()[i]);
              Get.toNamed(detailScreen);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ConstrainedBox(
                constraints: BoxConstraints(),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: controller.getBrandItems()[i].photo,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: CachedNetworkImage(
                            imageUrl: controller.getBrandItems()[i].photo,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 24, right: 20),
                            child: Text(
                              controller.getBrandItems()[i].name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 5, left: 30, right: 20),
                            child: Text(
                              "${controller.getBrandItems()[i].price} Kyats",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
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

/*class AddToCart extends StatefulWidget {
  final ItemModel itemModel;
  const AddToCart({
    Key? key,
    required this.itemModel,
  }) : super(key: key);

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  String? colorValue;
  String? sizeValue;
  final HomeController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField(
          value: colorValue,
          hint: Text('Color', style: TextStyle(fontSize: 12)),
          onChanged: (String? e) {
            setState(() {
              colorValue = e;
            });
          },
          items: widget.itemModel.color
              .split(',')
              .map((e) => DropdownMenuItem(
            value: e,
            child: Text(e, style: TextStyle(fontSize: 12)),
          ))
              .toList(),
        ),
        SizedBox(
          height: 20,
        ),
        DropdownButtonFormField(
          value: sizeValue,
          hint: Text("Size", style: TextStyle(fontSize: 12)),
          onChanged: (String? e) {
            setState(() {
              sizeValue = e;
            });
          },
          items: widget.itemModel.size
              .split(',')
              .map((e) => DropdownMenuItem(
            value: e,
            child: Text(e, style: TextStyle(fontSize: 12)),
          ))
              .toList(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: ElevatedButton(
            style: buttonStyle,
            onPressed: () {
              if (colorValue != null && sizeValue != null) {
                controller.addToCart(widget.itemModel, colorValue!, sizeValue!,);
                Get.back();
              }
            },
            child: Text("၀ယ်ယူရန်"),
          ),
        )
      ],
    );
  }
}*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hammies_user/data/fun.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';
import '../data/constant.dart';
import '../expaned_widget.dart';
import '../model/hive_item.dart';
import 'home_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    final selectedItem = controller.selectedItem.value!;
    return Scaffold(
      backgroundColor: detailTextBackgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          selectedItem.name,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: ListView(
        children: [
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              child: Hero(
                tag: selectedItem.photo,
                child: PageStorage(
                  bucket: PageStorageBucket(),
                  child: CarouselSlider(
                    items: [
                      CachedNetworkImage(
                        imageUrl: selectedItem.photo,
                        // "$baseUrl$itemUrl${selectedItem.photo}/get",
                        fit: BoxFit.fitWidth,
                      ),
                      CachedNetworkImage(
                        imageUrl: selectedItem.photo2,
                        // "$baseUrl$itemUrl${selectedItem.photo}/get",
                        fit: BoxFit.fitWidth,
                      ),
                      CachedNetworkImage(
                        imageUrl: selectedItem.photo3,
                        // "$baseUrl$itemUrl${selectedItem.photo}/get",
                        fit: BoxFit.fitWidth,
                      ),
                    ],
                    options: CarouselOptions(
                      height: 300,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
              ),
            ),
            margin: EdgeInsets.only(top: 10),
            width: double.infinity,
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 10,
            ),
            decoration: BoxDecoration(
              color: detailTextBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Star
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            Icons.star,
                            size: 20,
                            color: index <= selectedItem.star
                                ? homeIndicatorColor
                                : Colors.grey,
                          ),
                        ),
                      ),
                      //Favourite Icon
                      ValueListenableBuilder(
                        valueListenable:
                            Hive.box<HiveItem>(boxName).listenable(),
                        builder: (context, Box<HiveItem> box, widget) {
                          final currentObj = box.get(selectedItem.id);

                          if (!(currentObj == null)) {
                            return IconButton(
                                onPressed: () {
                                  box.delete(currentObj.id);
                                },
                                icon: Icon(
                                  FontAwesomeIcons.solidHeart,
                                  color: Colors.red,
                                  size: 25,
                                ));
                          }
                          return IconButton(
                              onPressed: () {
                                box.put(selectedItem.id,
                                    controller.changeHiveItem(selectedItem));
                              },
                              icon: Icon(
                                Icons.favorite_outline,
                                color: Colors.red,
                                size: 25,
                              ));
                        },
                      ),
                    ]),
                SizedBox(
                  height: 10,
                ),
                /*  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "စျေးနှုန်း",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ), */
                Obx(() {
                  final item = controller.selectedItem.value!;
                  return item.priceText();
                }),
                /*  ],
                ), */
                selectedItem.colorList?.isNotEmpty == true ? 20.v() : 0.v(),
                selectedItem.colorList?.isNotEmpty == true
                    ? Text(
                        "Color",
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )
                    : 0.v(),
                10.v(),
                //Color
                Obx(() {
                  final item = controller.selectedItem.value!;
                  return Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Wrap(
                      children: (item.colorList ?? [])
                          .map((e) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.white,
                                    child: InkWell(
                                      onTap: () => controller.changeColor(e),
                                      child: Stack(
                                        children: [
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundColor:
                                                Color(int.tryParse(e) ?? 0),
                                          ),
                                          item.selectedColor == e
                                              ? CircleAvatar(
                                                  radius: 15,
                                                  backgroundColor: Colors.white
                                                      .withOpacity(0.8),
                                                  child: Icon(
                                                    FontAwesomeIcons.check,
                                                    color: Colors.black,
                                                    size: 8,
                                                  ),
                                                )
                                              : 0.v(),
                                        ],
                                      ),
                                    )),
                              ))
                          .toList(),
                    ),
                  );
                }),
                selectedItem.sizeList?.isNotEmpty == true ? 20.v() : 0.v(),
                selectedItem.sizeList?.isNotEmpty == true
                    ? Text(
                        "Size",
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )
                    : 0.v(),
                10.v(),
                //Size
                Obx(() {
                  final item = controller.selectedItem.value!;
                  return Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Wrap(
                      children: (item.sizeList ?? [])
                          .map((e) => InkWell(
                                onTap: () => controller.changeSize(e),
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 5),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: item.selectedSize?.id == e.id
                                          ? homeIndicatorColor
                                          : Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      border: item.selectedSize?.id == e.id
                                          ? null
                                          : Border.all(
                                              width: 2,
                                              color: Colors.grey.shade300,
                                            )),
                                  child: Text(
                                    e.size,
                                    style: TextStyle(
                                      color: item.selectedSize?.id == e.id
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  );
                }),
                //
                ExpandedWidget(
                  text: selectedItem.desc,
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "⏰ Delivery Time",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Within 3 Days",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "🛍️ Address",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Mandalay",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "📞 Contact Phone ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "     099 7511 4498",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: selectedItem.photo2,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: selectedItem.photo3,
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 65,
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Obx(() {
          final item = controller.selectedItem.value!;
          final canAdd = (item.discountPrice != 0 ||
              (!(item.selectedColor == null) && !(item.selectedSize == null)));
          return ElevatedButton(
            style: canAdd ? buttonStyle : disableButtonStyle,
            onPressed: canAdd
                ? () {
                    //TODO:ADD TO CART
                    controller.addToCart(itemModel: item);
                    Get.back();
                  }
                : null,
            child: Text("၀ယ်ယူရန်"),
          );
        }),
      ),
    );
  }
}

/* class AddToCart extends StatefulWidget {
  final List<int> priceList;
  final List<String> priceString;
  const AddToCart({
    Key? key,
    required this.priceList,
    required this.priceString,
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
    final HomeController controller = Get.find();
    return Column(
      children: [
        DropdownButtonFormField(
          value: colorValue,
          hint: Text(
            'Color',
            style: TextStyle(fontSize: 12),
          ),
          onChanged: (String? e) {
            colorValue = e;
          },
          items: (selectedItem.colorList ?? [])
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: TextStyle(fontSize: 12),
                    ),
                  ))
              .toList(),
        ),
        SizedBox(
          height: 10,
        ),
        //TODO:Change Size Design
        DropdownButtonFormField(
          value: sizeValue,
          hint: Text(
            "Size",
            style: TextStyle(fontSize: 12),
          ),
          onChanged: (String? e) {
            sizeValue = e;
          },
          items: (selectedItem.sizeList ?? [])
              .map((e) => DropdownMenuItem(
                    value: e.size,
                    child: Text(
                      e.size,
                      style: TextStyle(fontSize: 12),
                    ),
                  ))
              .toList(),
        ),
        //Price Wholesale (or) Retail
        SizedBox(
          height: 10,
        ),

        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: ElevatedButton(
            style: buttonStyle,
            onPressed: () {
              if (colorValue != null && sizeValue != null) {
                /* //Need to increase current product's count to 1 to know added or add
                controller.makeAdded(selectedItem);
                controller.addToCart(
                    itemModel: selectedItem,
                    color: colorValue!,
                    size: sizeValue!); */
                Get.to(HomeScreen());
              }
            },
            child: Text("၀ယ်ယူရန်"),
          ),
        ),
      ],
    );
  }
}
 */
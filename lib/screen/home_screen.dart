import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hammies_user/utils/widget/widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/home_controller.dart';
import '../data/constant.dart';
import '../routes/routes.dart';
import '../widgets/bottom_nav.dart';
import 'view/brand.dart';
import 'view/cart.dart';
import 'view/favourite.dart';
import 'view/home.dart';
import 'view/hot.dart';
import 'view/order_history.dart';

List<Widget> _template = [
  HomeView(),
  // BrandView(),
  HotView(),
  CartView(),
  FavouriteView(),
  OrderHistory(),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin? fltNotification;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notitficationPermission();
    initMessaging();
  }

  void notitficationPermission() async {
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  void initMessaging() async {
    var androiInit = AndroidInitializationSettings('@mipmap/ic_launcher');

    var iosInit = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);

    fltNotification = FlutterLocalNotificationsPlugin();

    fltNotification!.initialize(initSetting);

    if (messaging != null) {
      print('vvvvvvv');
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {});
  }

  void showNotification(RemoteMessage message) async {
    var androidDetails = AndroidNotificationDetails(
      '1',
      message.notification!.title ?? '',
      icon: '@mipmap/ic_launcher',
      color: Color(0xFF0f90f3),
    );
    var iosDetails = IOSNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    await fltNotification!.show(0, message.notification!.title ?? '',
        message.notification!.body ?? '', generalNotificationDetails,
        payload: 'Notification');
  }

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0,

        centerTitle: false,
        title: Text(
          "HMM contactlens",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: appBarTitleColor,
            letterSpacing: 1,
            wordSpacing: 1,
          ),
        ),
        // centerTitle: true,
        actions: [
          // InkWell(
          //   onTap: () {
          //     ///TODO
          //   },
          //   child: Container(
          //     margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
          //     padding: EdgeInsets.only(left: 10, right: 10),
          //     alignment: Alignment.center,
          //     decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(7),
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.grey[200]!,
          //             spreadRadius: 1,
          //             offset: Offset(0, 1),
          //           )
          //         ]),
          //     child: Icon(
          //       Icons.search,
          //       color: Colors.black,
          //     ),
          //   ),
          // )
          SizedBox(
            width: 40,
            child: ElevatedButton(
              style: ButtonStyle(
                alignment: Alignment.center,
                backgroundColor: MaterialStateProperty.all(Colors.white),
                elevation: MaterialStateProperty.resolveWith<double>(
                  // As you said you dont need elevation. I'm returning 0 in both case
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return 0;
                    }
                    return 0; // Defer to the widget's default.
                  },
                ),
              ),
              onPressed: () => Get.toNamed(searchScreen),
              child: FaIcon(
                FontAwesomeIcons.search,
                color: Colors.black,
                size: 22,
              ),
            ),
          ),

          ElevatedButton(
            style: ButtonStyle(
              alignment: Alignment.center,
              backgroundColor: MaterialStateProperty.all(Colors.white),
              elevation: MaterialStateProperty.resolveWith<double>(
                // As you said you dont need elevation. I'm returning 0 in both case
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return 0;
                  }
                  return 0; // Defer to the widget's default.
                },
              ),
            ),
            onPressed: () async {
              try {
                await launch('https://m.me/HammiesMandalian25');
              } catch (e) {
                print(e);
              }
            },
            child: FaIcon(
              FontAwesomeIcons.facebookMessenger,
              color: Colors.blue,
              size: 22,
            ),
          ),
          //User Profile
          InkWell(
            onTap: () {
              if (controller.currentUser.value == null) {
                controller.signInWithGoogle(userProfileUrl);
              } else {
                Get.toNamed(userProfileUrl);
              }
            },
            child: Obx(() {
              final authenticated = !(controller.currentUser.value == null);
              return authenticated
                  ? /* circularNetworkImage(
                      controller.currentUser.value?.image ?? defaultUserProfile,
                      12,
                    ) */
                  Container(
                      /* color: Colors.red, */
                      width: 30,
                      height: 30,
                      margin: EdgeInsets.all(12),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child: CachedNetworkImage(
                          /*  imageBuilder: (context, imageProvider) {
                            return CircleAvatar(
                              radius: 12,
                              backgroundImage: imageProvider,
                            );
                          }, */
                          progressIndicatorBuilder: (context, url, status) {
                            return Shimmer.fromColors(
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.white,
                              ),
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                            );
                          },
                          errorWidget: (context, url, whatever) {
                            return const Text("Image not available");
                          },
                          imageUrl: controller.currentUser.value?.image ??
                              defaultUserProfile,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    )
                  : const SizedBox();
            }),
          ),
          /* const SizedBox(width: 10), */
          // Container(
          //   margin: EdgeInsets.only(
          //     top: 7,
          //     bottom: 10,
          //     right: 7,
          //   ),
          //   child: ElevatedButton(
          //     style: ButtonStyle(
          //       backgroundColor: MaterialStateProperty.all(Colors.white),
          //       overlayColor: MaterialStateProperty.all(Colors.black12),
          //     ),
          //     onPressed: () async {
          //       try {
          //         await launch('https://m.me/begoniazue');
          //       } catch (e) {
          //         print(e);
          //       }
          //     },
          //     child: FaIcon(
          //       FontAwesomeIcons.facebookMessenger,
          //       color: Colors.blue,
          //     ),
          //   ),
          // )
        ],
      ),
      body: Obx(
        () => _template[controller.navIndex.value],
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}

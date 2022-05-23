import 'package:get/route_manager.dart';
import 'package:hammies_user/screen/reward_product_see_all.dart';

import '../intro_screen.dart';
import '../screen/blue_tooth_screen.dart';
import '../screen/check_out_screen.dart';
import '../screen/detail_screen.dart';
import '../screen/home_screen.dart';
import '../screen/purchase_screen.dart';
import '../screen/search_screen.dart';
import '../screen/user_profile_screen.dart';

const String introScreen = '/intro-screen';
const String homeScreen = '/home';
const String checkOutScreen = '/checkout';
const String detailScreen = '/detail';
const String uploadItemScreen = '/uploadItemScreen';
const String mangeItemScreen = '/manage-item';
const String purchaseScreen = '/purchase-screen';
const String blueToothScreen = '/bluetooth-screen';
const String searchScreen = '/searchScreen';
const String userProfileUrl = "/user_profile";
const String rewardProducts = "/reward_products";

List<GetPage> routes = [
  GetPage(
    name: introScreen,
    page: () => OnBoardingPage(),
  ),
  GetPage(
    name: homeScreen,
    page: () => HomeScreen(),
  ),
  GetPage(
    name: checkOutScreen,
    page: () => CheckOutScreen(),
  ),
  GetPage(
    name: detailScreen,
    page: () => DetailScreen(),
  ),
  GetPage(
    name: rewardProducts,
    page: () => RewardProductSeeAll(),
  ),
  /* GetPage(
    name: uploadItemScreen,
    page: () => UploadItem(),
    binding: UploadBinding(),
  ),*/
  /*GetPage(
    name: mangeItemScreen,
    page: () => ManageItem(),
    binding: ManageBinding(),
  ),*/
  GetPage(
    name: purchaseScreen,
    page: () => PurchaseScreen(),
  ),
  GetPage(
    name: blueToothScreen,
    page: () => BlueToothPrintScreen(),
  ),
  GetPage(
    name: searchScreen,
    page: () => SearchScreen(),
  ),
  GetPage(
    name: userProfileUrl,
    page: () => UserProfileScreen(),
  ),
];

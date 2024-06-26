import 'package:flutter/material.dart';

const defaultUserProfile =
    "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png";
const Color scaffoldBackground = Colors.white;
const Color appBarColor = Colors.white;
const Color appBarTitleColor = /* Color.fromRGBO(19, 19, 19, 1); */
    Color(0xFFBD539E);
const Color homeIndicatorColor = /* Color.fromRGBO(247, 98, 16, 1); */
    Color(0xFFBD539E);
const Color detailBackgroundColor = Colors.white;
const Color detailTextBackgroundColor = Colors.white;
ButtonStyle buttonStyle = ButtonStyle(
  backgroundColor:
      MaterialStateProperty.all(/* Colors.orange */ Color(0xFFBD539E)),
);
ButtonStyle disableButtonStyle = ButtonStyle(
  backgroundColor:
      MaterialStateProperty.all(/* Colors.orange */ Colors.grey.shade300),
);

const String baseUrl = 'http://192.168.1.5:5000/api/v1/streaming/movie/';
const String profileUrl = 'profile/';
const String itemUrl = 'item/';
const rewardProductCollection = "rewardProducts";
const productCategoryCollection = "productCategories";

const String userCollection = 'users';
const String profileCollection = 'profiles';
const productCollection = "products";
const String purchaseCollection = 'purchases';
const String brandCollection = 'brandProducts';
const String normalUserCollection = "normalUsers";
const String userImage =
    "https://kzn.fra1.cdn.digitaloceanspaces.com/Hammies/IMG_2508.PNG";
/*const List<String> priceList = [
  '၁ ထည် လက်လီ ဈေးနှုန်း',
  'လက်ကား ဈေးနှုန်း',
];*/

final dailyMapKey = DateTime.now().toString().split(" ").first;

const String boxName = "favouriteBOX";
const String purchaseBox = "purchasesBoxs";
const String fcmKey =
    "AAAAF6su9BQ:APA91bGG5JDpoS0JW98KmH_egSgK2jPjRFFbIqbIQ_DZbVABFMHeCRlOLHkWga7SsrKfptGxS_HlOWGWTDbOnTvCsKEf8j0A59gAVnhidkeSugdI2BmBKrOrzOdt250JKBO7qRrGdDNp";

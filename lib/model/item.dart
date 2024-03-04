import 'package:freezed_annotation/freezed_annotation.dart';

import 'item_size.dart';

part 'item.freezed.dart';
part 'item.g.dart';

@freezed
class ItemModel with _$ItemModel {
  @JsonSerializable(explicitToJson: true)
  factory ItemModel({
    required String id,
    required String photo,
    required String photo2,
    required String photo3,
    required String desc,
    required String name,
    required String deliverytime,
    required int price,
    int? finalPrice,
    @JsonKey(nullable: true, defaultValue: 0) int? discountPrice,
    List<String>? colorList,
    //TODO:Add Size List
    List<ItemSize>? sizeList,
    String? selectedColor,
    ItemSize? selectedSize,
    required int star,
    required String category,
    required int originalQuantity,
    required int originalPrice,
    required int remainQuantity,
    @JsonKey(nullable: true, defaultValue: 0) int? count,
  }) = _ItemModel;

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);
}

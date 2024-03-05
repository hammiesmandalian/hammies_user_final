import 'package:freezed_annotation/freezed_annotation.dart';

part 'division.freezed.dart';
part 'division.g.dart';

@freezed
class Division with _$Division {
  factory Division({
    required String id,
    required String name,
    required Map<int, List<String>> townShipMap,
  }) = _Division;
  factory Division.fromJson(Map<String, dynamic> json) =>
      _$DivisionFromJson(json);
}

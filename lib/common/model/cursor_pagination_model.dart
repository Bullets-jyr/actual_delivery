import 'package:json_annotation/json_annotation.dart';

import '../../restaurant/model/restaurant_model.dart';

part 'cursor_pagination_model.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
)
class CursorPaginationModel<T> {
  final CursorPaginationModelMeta meta;
  final List<T> data;

  CursorPaginationModel({
    required this.meta,
    required this.data,
  });

  factory CursorPaginationModel.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CursorPaginationModelFromJson(json, fromJsonT);
}

@JsonSerializable()
class CursorPaginationModelMeta {
  final int count;
  final bool hasMore;

  CursorPaginationModelMeta({
    required this.count,
    required this.hasMore,
  });

  factory CursorPaginationModelMeta.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginationModelMetaFromJson(json);
}

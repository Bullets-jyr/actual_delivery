import 'package:json_annotation/json_annotation.dart';

import '../../restaurant/model/restaurant_model.dart';

part 'cursor_pagination_model.g.dart';

abstract class CursorPaginationModelBase {}

class CursorPaginationModelError extends CursorPaginationModelBase {
  final String message;

  CursorPaginationModelError({
    required this.message,
  });
}

class CursorPaginationModelLoading extends CursorPaginationModelBase {}

@JsonSerializable(
  genericArgumentFactories: true,
)
class CursorPaginationModel<T> extends CursorPaginationModelBase {
  final CursorPaginationModelMeta meta;
  final List<T> data;

  CursorPaginationModel({
    required this.meta,
    required this.data,
  });

  factory CursorPaginationModel.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
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

// 새로고침 할 때
class CursorPaginationModelRefetching<T> extends CursorPaginationModel<T> {
  CursorPaginationModelRefetching({
    required super.meta,
    required super.data,
  });
}

// 리스트의 맨 아래로 내려서
// 추가 데이터를 요청하는 중
class CursorPaginationModelFetchMore<T> extends CursorPaginationModel<T> {
  CursorPaginationModelFetchMore({
    required super.meta,
    required super.data,
  });
}

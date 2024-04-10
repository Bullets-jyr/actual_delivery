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

// 로딩 상태
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

  CursorPaginationModel copyWith({
    CursorPaginationModelMeta? meta,
    List<T>? data,
  }) {
    return CursorPaginationModel<T>(
      meta: meta ?? this.meta,
      data: data ?? this.data,
    );
  }

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

  CursorPaginationModelMeta copyWith({
    int? count,
    bool? hasMore,
  }) {
    return CursorPaginationModelMeta(
      count: count ?? this.count,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  factory CursorPaginationModelMeta.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginationModelMetaFromJson(json);
}

// 로딩 상태
// 데이터가 있는 상태
// 새로고침 할 때
class CursorPaginationModelRefetching<T> extends CursorPaginationModel<T> {
  CursorPaginationModelRefetching({
    required super.meta,
    required super.data,
  });
}

// 로딩 상태
// 데이터가 있는 상태
// 리스트의 맨 아래로 내려서
// 추가 데이터를 요청하는 중
class CursorPaginationModelFetchingMore<T> extends CursorPaginationModel<T> {
  CursorPaginationModelFetchingMore({
    required super.meta,
    required super.data,
  });
}

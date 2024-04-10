import 'package:actual_delivery/common/model/cursor_pagination_model.dart';
import 'package:actual_delivery/common/provider/pagination_provider.dart';
import 'package:actual_delivery/product/model/product_model.dart';
import 'package:actual_delivery/product/repository/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productProvider =
    StateNotifierProvider<ProductStateNotifier, CursorPaginationModelBase>(
  (ref) {
    final repo = ref.watch(productRepositoryProvider);
    return ProductStateNotifier(repository: repo);
  },
);

class ProductStateNotifier
    extends PaginationProvider<ProductModel, ProductRepository> {
  ProductStateNotifier({
    required super.repository,
  });
}

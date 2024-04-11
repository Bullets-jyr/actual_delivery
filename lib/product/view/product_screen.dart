import 'package:actual_delivery/product/component/product_card.dart';
import 'package:actual_delivery/product/model/product_model.dart';
import 'package:actual_delivery/product/provider/product_provider.dart';
import 'package:flutter/material.dart';

import '../../common/component/pagination_list_view.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView<ProductModel>(
      provider: productProvider,
      itemBuilder: <ProductModel>(_, index, model) {
        return ProductCard.fromProductModel(
          model: model,
        );
      },
    );
  }
}

import 'package:actual_delivery/common/layout/default_layout.dart';
import 'package:actual_delivery/product/component/product_card.dart';
import 'package:actual_delivery/restaurant/component/restaurant_card.dart';
import 'package:actual_delivery/restaurant/model/restaurant_detail_model.dart';
import 'package:actual_delivery/restaurant/provider/restaurant_provider.dart';
import 'package:actual_delivery/restaurant/repository/restaurant_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletons/skeletons.dart';

import '../../common/const/data.dart';
import '../../common/dio/dio.dart';
import '../model/restaurant_model.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  final String id;

  const RestaurantDetailScreen({
    required this.id,
    super.key,
  });

  // Future<RestaurantDetailModel> getRestaurantDetail(WidgetRef ref) async {
  // final dio = ref.watch(dioProvider);

  // final dio = Dio();

  // dio.interceptors.add(
  //   CustomInterceptor(
  //     storage: storage
  //   ),
  // );

  // final repository =
  //     RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant');

  // return repository.getRestaurantDetail(id: id);
  // return ref.watch(restaurantRepositoryProvider).getRestaurantDetail(
  //       id: id,
  //     );
  // }

  @override
  ConsumerState<RestaurantDetailScreen> createState() =>
      _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState
    extends ConsumerState<RestaurantDetailScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(restaurantProvider.notifier).getDetail(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restaurantDetailProvider(widget.id));

    if (state == null) {
      return DefaultLayout(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return DefaultLayout(
      title: '불타는 떡볶이',
      child: CustomScrollView(
        slivers: [
          // 일반 위젯
          renderTop(
            model: state,
          ),
          if (state is! RestaurantDetailModel)
            renderLoading(),
          if (state is RestaurantDetailModel) renderLabel(),
          if (state is RestaurantDetailModel)
            renderProducts(
              products: state.products,
            ),
        ],
      ),
    );
  }

  SliverPadding renderLoading() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: SkeletonParagraph(
                style: SkeletonParagraphStyle(
                  lines: 5,
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SliverPadding renderLabel() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  SliverPadding renderProducts({
    required List<RestaurantProductModel> products,
  }) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final model = products[index];

            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ProductCard.fromModel(
                model: model,
              ),
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }

  SliverToBoxAdapter renderTop({
    // required RestaurantDetailModel model,
    required RestaurantModel model,
  }) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          RestaurantCard.fromModel(
            model: model,
            isDetail: true,
          ),
        ],
      ),
    );
  }
}

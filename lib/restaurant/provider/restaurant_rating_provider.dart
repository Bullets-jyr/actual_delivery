import 'package:actual_delivery/common/model/cursor_pagination_model.dart';
import 'package:actual_delivery/common/provider/pagination_provider.dart';
import 'package:actual_delivery/rating/model/rating_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/restaurant_rating_repository.dart';

final restaurantRatingProvider = StateNotifierProvider.family<
    RestaurantRatingStateNotifier, CursorPaginationModelBase, String>(
  (ref, id) {
    final repo = ref.watch(restaurantRatingRepositoryProvider(id));

    return RestaurantRatingStateNotifier(repository: repo);
  },
);

class RestaurantRatingStateNotifier
    extends PaginationProvider<RatingModel, RestaurantRatingRepository> {
  // final RestaurantRatingRepository repository;

  RestaurantRatingStateNotifier({
    // required this.repository,
    required super.repository,
  });
}

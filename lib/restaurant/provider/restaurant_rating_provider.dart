import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/model/cursor_pagination_model.dart';
import '../repository/restaurant_rating_repository.dart';

class RestaurantRatingStateNotifier
    extends StateNotifier<CursorPaginationModelBase> {
  final RestaurantRatingRepository repository;

  RestaurantRatingStateNotifier({
    required this.repository,
  }) : super(
          CursorPaginationModelLoading(),
        );
}

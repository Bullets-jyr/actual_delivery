import 'package:actual_delivery/restaurant/model/restaurant_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/model/cursor_pagination_model.dart';
import '../../common/model/pagination_params.dart';
import '../../common/provider/pagination_provider.dart';
import '../repository/restaurant_repository.dart';

final restaurantDetailProvider =
    Provider.family<RestaurantModel?, String>((ref, id) {
  final state = ref.watch(restaurantProvider);

  if (state is! CursorPaginationModel) {
    return null;
  }

  return state.data.firstWhere((element) => element.id == id);
});

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationModelBase>(
  (ref) {
    final repository = ref.watch(restaurantRepositoryProvider);

    final notifier = RestaurantStateNotifier(repository: repository);

    return notifier;
  },
);

class RestaurantStateNotifier extends PaginationProvider<RestaurantModel, RestaurantRepository> {
  // final RestaurantRepository repository;

  RestaurantStateNotifier({
    // required this.repository,
    required super.repository,
  });

  void getDetail({
    required String id,
  }) async {
    // 만약에 아직 데이터가 하나도 없는 상태라면 (state가 CursorPaginationModel이 아니라면)
    // 데이터를 가져오는 시도를 한다.
    if (state is! CursorPaginationModel) {
      await this.paginate();
    }

    // state가 CursorPaginationModel이 아닐 때 그냥 리턴
    if (state is! CursorPaginationModel) {
      return;
    }

    final pState = state as CursorPaginationModel;

    final resp = await repository.getRestaurantDetail(id: id);

    state = pState.copyWith(
      data: pState.data
          .map<RestaurantModel>(
            (e) => e.id == id ? resp : e,
          )
          .toList(),
    );
  }
}

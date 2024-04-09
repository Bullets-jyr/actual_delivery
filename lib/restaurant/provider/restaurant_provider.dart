import 'package:actual_delivery/restaurant/model/restaurant_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/model/cursor_pagination_model.dart';
import '../../common/model/pagination_params.dart';
import '../repository/restaurant_repository.dart';

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationModelBase>(
  (ref) {
    final repository = ref.watch(restaurantRepositoryProvider);

    final notifier = RestaurantStateNotifier(repository: repository);

    return notifier;
  },
);

class RestaurantStateNotifier extends StateNotifier<CursorPaginationModelBase> {
  final RestaurantRepository repository;

  RestaurantStateNotifier({
    required this.repository,
  }) : super(CursorPaginationModelLoading()) {
    paginate();
  }

  void paginate({
    int fetchCount = 20,
    // 추가로 데이터 더 가져오기
    // true - 추가로 데이터 더 가져옴
    // false - 새로고침 (첫 번째 페이지의 데이터를 가져와서 현재 상태를 덮어씌움)
    bool fetchMore = false,
    // 강제로 다시 로딩하기
    // true - CursorPaginationModelLoading()
    bool forceRefetch = false,
  }) async {
    try {
      // 5가지 가능성
      // state의 상태
      // [상태가]
      // 1) CursorPaginationModel - 정상적으로 데이터가 있는 상태
      // 2) CursorPaginationModelLoading - 데이터가 로딩 중인 상태 (현재 캐시 없음), forceRefetch가 true인 경우
      // 3) CursorPaginationModelError - 에러가 있는 상태
      // 4) CursorPaginationModelRefetching - 첫 번째 페이지부터 다시 데이터를 가져올 때
      // 5) CursorPaginationModelFetchingMore - 추가 데이터를 paginate 해오라는 요청을 받았을 때

      // 바로 반환(return)하는 상황
      // 1) hasMore = false (기존 상태에서 이미 다음 데이터가 없다는 값을 들고있다면)
      // 2) 로딩 중 - fetchMore가 true일 때, 즉시 반환(return)
      // - 로딩 중일 때 반환(return)을 안해주는 상황은? fetchMore가 false일 때, 새로고침의 의도가 있을 수 있다.

      if (state is CursorPaginationModel && !forceRefetch) {
        final pState = state as CursorPaginationModel;

        if (!pState.meta.hasMore) {
          return;
        }
      }

      // 3가지 로딩 상태
      final isLoading = state is CursorPaginationModelLoading;
      final isRefetching = state is CursorPaginationModelRefetching;
      final isFetchingMore = state is CursorPaginationModelFetchingMore;

      // 2번 반환(return) 상황
      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }

      //

      // PaginationParams 생성
      PaginationParams paginationParams = PaginationParams(
        count: fetchCount,
      );

      // fetchMore
      // 데이터를 추가로 더 가져오는 상황
      if (fetchMore) {
        final pState = state as CursorPaginationModel;

        state = CursorPaginationModelFetchingMore(
          meta: pState.meta,
          data: pState.data,
        );

        paginationParams = paginationParams.copyWith(
          after: pState.data.last.id,
        );
      }
      // 데이터를 처음부터 가져오는 상황
      else {
        // 만약에 데이터가 있는 상황이라면
        // 기존 데이터를 보존한 채로 Fetch(API 요청)를 진행
        if (state is CursorPaginationModel && !forceRefetch) {
          final pState = state as CursorPaginationModel;

          state = CursorPaginationModelRefetching(
            meta: pState.meta,
            data: pState.data,
          );
        }
        // 나머지 상황 (데이터를 유지할 필요가 없는 상황)
        else {
          state = CursorPaginationModelLoading();
        }
      }

      final resp = await repository.paginate(
        paginationParams: paginationParams,
      );

      if (state is CursorPaginationModelFetchingMore) {
        final pState = state as CursorPaginationModelFetchingMore;

        // 기존 데이터에
        // 새로운 데이터 추가
        state = resp.copyWith(
          data: [
            ...pState.data,
            ...resp.data,
          ],
        );
      } else {
        state = resp;
      }
    } catch (e) {
      state = CursorPaginationModelError(message: '데이터를 가져오지 못했습니다.');
    }
  }
}

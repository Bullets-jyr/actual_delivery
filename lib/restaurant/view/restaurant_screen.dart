import 'package:actual_delivery/common/utils/pagination_utils.dart';
import 'package:actual_delivery/restaurant/provider/restaurant_provider.dart';
import 'package:actual_delivery/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/model/cursor_pagination_model.dart';
import '../component/restaurant_card.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({super.key});

  // Future<List<RestaurantModel>> paginateRestaurant(WidgetRef ref) async {
  //   final dio = ref.watch(dioProvider);
  //
  //   // final dio = Dio();
  //
  //   // dio.interceptors.add(
  //   //   CustomInterceptor(
  //   //     storage: storage,
  //   //   ),
  //   // );
  //
  //   final resp =
  //       await RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant')
  //           .paginate();
  //
  //   // final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
  //
  //   // final resp = await dio.get(
  //   //   'http://$ip/restaurant',
  //   //   options: Options(
  //   //     headers: {
  //   //       'authorization': 'Bearer $accessToken',
  //   //     },
  //   //   ),
  //   // );
  //
  //   // return resp.data['data'];
  //
  //   return resp.data;
  // }

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    controller.addListener(scrollListener);
  }

  void scrollListener() {
    PaginationUtils.paginate(
      controller: controller,
      provider: ref.read(restaurantProvider.notifier),
    );
    // // 현재 위치가
    // // 최대 길이보다 조금 덜 되는 위치까지 왔다면
    // // 새로운 데이터를 추가 요청
    // if (controller.offset > controller.position.maxScrollExtent - 300) {
    //   ref.read(restaurantProvider.notifier).paginate(
    //         fetchMore: true,
    //       );
    // }
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(restaurantProvider);

    // 완전 처음 로딩일 때
    if (data is CursorPaginationModelLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    // 에러
    if (data is CursorPaginationModelError) {
      return Center(
        child: Text(data.message),
      );
    }

    // CursorPaginationModel의 subclass
    // CursorPaginationModelRefetching
    // CursorPaginationModelFetchingMore
    final cpm = data as CursorPaginationModel;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        controller: controller,
        itemCount: cpm.data.length + 1,
        itemBuilder: (_, index) {
          if (index == cpm.data.length) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Center(
                child: data is CursorPaginationModelFetchingMore
                    ? CircularProgressIndicator()
                    : Text('마지막 데이터입니다 ㅠㅠ'),
              ),
            );
          }

          final pItem = cpm.data[index];

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => RestaurantDetailScreen(
                    id: pItem.id,
                  ),
                ),
              );
            },
            child: RestaurantCard.fromModel(
              model: pItem,
            ),
          );
        },
        separatorBuilder: (_, index) {
          return SizedBox(height: 16.0);
        },
      ),
    );
  }

// @override
// Widget build(BuildContext context) {
//   return Container(
//     child: Center(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: RestaurantCard(
//           image: Image.asset(
//             'asset/img/food/ddeok_bok_gi.jpg',
//             fit: BoxFit.cover,
//           ),
//           name: '불타는 떡볶이',
//           tags: ['떡볶이', '치즈', '매운맛'],
//           ratingsCount: 100,
//           deliveryTime: 15,
//           deliveryFee: 2000,
//           ratings: 4.52,
//         ),
//       ),
//     ),
//   );
// }
}

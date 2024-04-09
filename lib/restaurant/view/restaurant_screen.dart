import 'package:actual_delivery/common/dio/dio.dart';
import 'package:actual_delivery/restaurant/model/restaurant_model.dart';
import 'package:actual_delivery/restaurant/provider/restaurant_provider.dart';
import 'package:actual_delivery/restaurant/repository/restaurant_repository.dart';
import 'package:actual_delivery/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/const/data.dart';
import '../../common/model/cursor_pagination_model.dart';
import '../component/restaurant_card.dart';

class RestaurantScreen extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(restaurantProvider);

    if (data is CursorPaginationModelLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    final cpm = data as CursorPaginationModel;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        itemCount: cpm.data.length,
        itemBuilder: (_, index) {
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

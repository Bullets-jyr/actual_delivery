import 'package:actual_delivery/common/dio/dio.dart';
import 'package:actual_delivery/restaurant/model/restaurant_model.dart';
import 'package:actual_delivery/restaurant/repository/restaurant_repository.dart';
import 'package:actual_delivery/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../common/const/data.dart';
import '../component/restaurant_card.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List<RestaurantModel>> paginateRestaurant() async {
    final dio = Dio();

    dio.interceptors.add(
      CustomInterceptor(
        storage: storage,
      ),
    );

    final resp = await RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant').paginate();

    // final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    // final resp = await dio.get(
    //   'http://$ip/restaurant',
    //   options: Options(
    //     headers: {
    //       'authorization': 'Bearer $accessToken',
    //     },
    //   ),
    // );

    // return resp.data['data'];

    return resp.data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FutureBuilder<List<RestaurantModel>>(
            future: paginateRestaurant(),
            builder: (context, AsyncSnapshot<List<RestaurantModel>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.separated(
                itemBuilder: (_, index) {
                  final pItem = snapshot.data![index];
                  // final pItem = RestaurantModel.fromJson(
                  //   item,
                  // );

                  // parsed
                  // final pItem = RestaurantModel(
                  //   id: item['id'],
                  //   name: item['name'],
                  //   thumbUrl: 'http://$ip${item['thumbUrl']}',
                  //   tags: List<String>.from(item['tags']),
                  //   priceRange: RestaurantPriceRange.values.firstWhere(
                  //     (e) => e.name == item['priceRange'],
                  //   ),
                  //   ratings: item['ratings'],
                  //   ratingsCount: item['ratingsCount'],
                  //   deliveryTime: item['deliveryTime'],
                  //   deliveryFee: item['deliveryFee'],
                  // );

                  // return RestaurantCard(
                  //   image: Image.network(
                  //     pItem.thumbUrl,
                  //     fit: BoxFit.cover,
                  //   ),
                  //   // image: Image.asset(
                  //   //   'asset/img/food/ddeok_bok_gi.jpg',
                  //   //   fit: BoxFit.cover,
                  //   // ),
                  //   name: pItem.name,
                  //   // from List<dynamic> to List<String>
                  //   tags: pItem.tags,
                  //   ratingsCount: pItem.ratingsCount,
                  //   deliveryTime: pItem.deliveryTime,
                  //   deliveryFee: pItem.deliveryFee,
                  //   ratings: pItem.ratings,
                  // );

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
                itemCount: snapshot.data!.length,
              );
            },
          ),
        ),
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

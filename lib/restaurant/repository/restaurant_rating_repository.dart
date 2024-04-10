import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

import '../../common/model/cursor_pagination_model.dart';
import '../../common/model/pagination_params.dart';
import '../../rating/model/rating_model.dart';

part 'restaurant_rating_repository.g.dart';

// baseUrl
// http://$ip/restaurant/:rid/rating
@RestApi()
abstract class RestaurantRatingRepository {
  factory RestaurantRatingRepository(Dio dio, {String baseUrl}) =
      _RestaurantRatingRepository;

  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPaginationModel<RatingModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}

import 'dart:async';
import 'package:jasindo_app/src/resources/jasindo_api_provider.dart';
import '../models/item_model.dart';

class Repository {
  final buboApiProvider = JasindoApiProvider();

  Future<ItemModel> fetchAllMovies() => buboApiProvider.fetchMovieList();

  //Future<TrailerModel> fetchTrailers(int movieId) => buboApiProvider.fetchTrailer(movieId);
}

import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/models/movies_models.dart';
import 'package:http/http.dart' as http;

Future<MoviesApi> get getMovieAPI async {
  String url =
      'https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=36bf14c71777595dcb3c37f53069370b';
  http.Response response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    return compute(moviesApiFromMap, response.body);
  } else {
    throw Exception("Error Code: ${response.statusCode}");
  }
}

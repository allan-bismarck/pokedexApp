import 'package:dio/dio.dart';

class api {
  final String _baseURL = 'https://pokeapi.co/api/v2';
  final service = Dio();

  myRequest(String endPoint) async {
    try {
      Response response = await service.get(_baseURL + '/$endPoint');
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (response) {
      return null;
    }
  }
}

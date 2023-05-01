import 'package:dio/dio.dart';
import '../functions/strings.dart';
import 'api.dart';

class ApiDio implements Api{
  final baseURL = GlobalStrings().baseURL;
  final service = Dio();

  @override
  myRequest(String endPoint) async {
    try {
      Response response = await service.get('$baseURL/$endPoint');
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (response) {
      return null;
    }
  }
}

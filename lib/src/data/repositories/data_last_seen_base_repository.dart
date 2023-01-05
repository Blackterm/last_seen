import 'package:http/http.dart' as http;
import 'package:http/src/response.dart';
import '../../domain/repositories/last_seen_base_repository.dart';

class DataLastSeenBaseRepository implements LastSeenBaseRepository {
  static final DataLastSeenBaseRepository _instance =
      DataLastSeenBaseRepository._internal();
  DataLastSeenBaseRepository._internal();
  factory DataLastSeenBaseRepository() => _instance;

  String baseUrl = "https://www.osilates.net/api/v1/";

  @override
  Future<Response> executeLastSeenRequest(
      String requestType, String path, header, body) async {
    Response response;
    var url = Uri.parse(baseUrl + path);

    try {
      switch (requestType) {
        case "GET":
          response = await http.get(
            url,
            headers: header,
          );
          break;
        case "POST":
          response = await http.post(
            url,
            headers: header,
            body: body,
          );
          break;
        case "DELETE":
          response = await http.delete(
            url,
            headers: header,
          );
          break;
        default:
          throw Exception("");
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response;
      } else {
        throw Exception("");
      }
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }
}

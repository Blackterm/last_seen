import 'package:http/http.dart';

abstract class LastSeenBaseRepository {
  Future<Response> executeLastSeenRequest(
      String requestType, String path, var header, var body);
}

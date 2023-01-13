import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wpfamilylastseen/src/domain/entities/device_connections.dart';
import 'package:wpfamilylastseen/src/domain/entities/last_seen_languages.dart';
import 'package:wpfamilylastseen/src/domain/entities/last_seen_number.dart';
import 'package:wpfamilylastseen/src/domain/entities/purchase_control.dart';
import '../../domain/entities/add_number.dart';
import '../../domain/entities/edit_number.dart';
import '../../domain/entities/langauge_register.dart';
import '../../domain/entities/last_seen_numbers.dart';
import '../../domain/entities/last_seen_product.dart';
import '../../domain/entities/last_seen_settings.dart';
import '../../domain/repositories/home_page_repository.dart';
import '../../domain/repositories/last_seen_base_repository.dart';
import 'data_last_seen_base_repository.dart';

class DataHomePageRepository implements HomePageRepository {
  static final _instance = DataHomePageRepository._internal();
  DataHomePageRepository._internal()
      : _lastSeenBaseRepository = DataLastSeenBaseRepository();
  factory DataHomePageRepository() => _instance;
  final LastSeenBaseRepository _lastSeenBaseRepository;

  LangaugeRegister? langaugeRegister;
  LastSeenSettings? _lastSeenSettings;
  List<LastSeenProduct> _lastSeenProduct = [];
  List<ApiGoogleProduct> _lastGoogleProduct = [];
  List<LastSeenNumbers> _lastSeenNumbers = [];
  LastSeenNumber? _lastSeenNumber;
  AddNumber? _addNumber;
  EditNumber? _editNumber;
  PurchaseControl? purchaseControl;
  List<LastSeenLanguages> _lastSeenLanguages = [];
  List<DeviceConnections> _deviceConnections = [];

  @override
  Future<LangaugeRegister?> getLangaugeRegister() async {
    try {
      return await langaugeRegister;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<LangaugeRegister?> postLangaugeRegister(String device,
      String tokenData, String timezone, String locale, String version) async {
    try {
      var headers = {'Accept': 'application/json'};
      var body = await {
        'uuid': device,
        'token_data': tokenData,
        'timezone': timezone,
        'locale': locale,
        'version': version
      };
      http.Response response = await _lastSeenBaseRepository
          .executeLastSeenRequest("POST", "register", headers, body);

      langaugeRegister = LangaugeRegister.fromJson(jsonDecode(response.body));

      return langaugeRegister;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<LastSeenSettings?> getLastSeenSettings(
    String device,
  ) async {
    try {
      var headers = {'X-Device': device, 'Accept': 'application/json'};
      var body = await {};
      http.Response response = await _lastSeenBaseRepository
          .executeLastSeenRequest("GET", "settings", headers, body);

      _lastSeenSettings = LastSeenSettings.fromJson(jsonDecode(response.body));

      return _lastSeenSettings;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<List<LastSeenProduct>> getLastSeenProduct(String device) async {
    try {
      var headers = {'X-Device': device, 'Accept': 'application/json'};
      var body = await {};
      http.Response response = await _lastSeenBaseRepository
          .executeLastSeenRequest("GET", "products", headers, body);

      List jsonResponse = json.decode(response.body);

      _lastSeenProduct =
          jsonResponse.map((value) => LastSeenProduct.fromJson(value)).toList();

      return _lastSeenProduct;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<List<ApiGoogleProduct>> getApiGoogleProduct(String device) async {
    try {
      var headers = {'X-Device': device, 'Accept': 'application/json'};
      var body = await {};
      http.Response response = await _lastSeenBaseRepository
          .executeLastSeenRequest("GET", "products", headers, body);

      List jsonResponse = json.decode(response.body);

      _lastGoogleProduct = jsonResponse
          .map((value) => ApiGoogleProduct.fromJson(value))
          .toList();

      return _lastGoogleProduct;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<List<LastSeenNumbers>> getLastSeenNumbers(String device) async {
    try {
      var headers = {'X-Device': device, 'Accept': 'application/json'};
      var body = await {};
      http.Response response = await _lastSeenBaseRepository
          .executeLastSeenRequest("GET", "numbers", headers, body);

      List jsonResponse = json.decode(response.body);

      _lastSeenNumbers =
          jsonResponse.map((value) => LastSeenNumbers.fromJson(value)).toList();

      return _lastSeenNumbers;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<AddNumber?> postAddNumber(String sku, String name, String number,
      String countryCode, String token, String detail, String device) async {
    try {
      var headers = {
        'X-Device': device,
        'Accept': 'application/json',
      };
      var body = await {
        'name': name,
        'number': number,
        'country_code': countryCode,
        'product_sku': sku,
        'purchase_token': token,
        'purchase_detail': detail,
      };
      http.Response response = await _lastSeenBaseRepository
          .executeLastSeenRequest("POST", "add-number", headers, body);

      _addNumber = AddNumber.fromJson(jsonDecode(response.body));

      return _addNumber;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<EditNumber?> postEditNumber(String name, String notif, String phoneId,
      String isFavorite, String device) async {
    try {
      var headers = {
        'X-Device': device,
        'Accept': 'application/json',
      };
      var body = await {
        'name': name,
        'notification': notif,
        'is_favorite': isFavorite,
      };
      http.Response response =
          await _lastSeenBaseRepository.executeLastSeenRequest(
              "POST", "edit-number/$phoneId", headers, body);

      _editNumber = EditNumber.fromJson(jsonDecode(response.body));

      return _editNumber;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future removeNumber(String id, String device) async {
    try {
      var headers = {
        'X-Device': device,
        'Accept': 'application/json',
      };
      var body = await {};
      http.Response response = await _lastSeenBaseRepository
          .executeLastSeenRequest("DELETE", "remove-number/$id", headers, body);

      if (response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<LastSeenNumber?> getLastSeenNumber(
      String numberId, String device) async {
    try {
      var headers = {'X-Device': device, 'Accept': 'application/json'};
      var body = await {};
      http.Response response = await _lastSeenBaseRepository
          .executeLastSeenRequest("GET", "number/$numberId", headers, body);

      _lastSeenNumber = LastSeenNumber.fromJson(jsonDecode(response.body));

      return _lastSeenNumber;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<List<LastSeenLanguages>> getLastSeenLanguages(String device) async {
    try {
      var headers = {'X-Device': device, 'Accept': 'application/json'};
      var body = await {};
      http.Response response = await _lastSeenBaseRepository
          .executeLastSeenRequest("GET", "languages", headers, body);

      List jsonResponse = json.decode(response.body);

      _lastSeenLanguages = jsonResponse
          .map((value) => LastSeenLanguages.fromJson(value))
          .toList();

      return _lastSeenLanguages;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<PurchaseControl?> getPurchaseControl(
      String product_sku, String verify_token) async {
    try {
      var headers = {'Accept': 'application/json'};
      var body = await {
        "product_sku": product_sku,
        "verify_token": verify_token,
      };
      http.Response response = await _lastSeenBaseRepository
          .executeLastSeenRequest("POST", "verify-purchase", headers, body);

      purchaseControl = PurchaseControl.fromJson(jsonDecode(response.body));

      return purchaseControl;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<List<DeviceConnections>> getDeviceConnections(String device) async {
    try {
      var headers = {'X-Device': device, 'Accept': 'application/json'};
      var body = await {};
      http.Response response = await _lastSeenBaseRepository
          .executeLastSeenRequest("GET", "connections", headers, body);

      List jsonResponse = json.decode(response.body);

      _deviceConnections = jsonResponse
          .map((value) => DeviceConnections.fromJson(value))
          .toList();

      return _deviceConnections;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }
}

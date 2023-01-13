import 'package:wpfamilylastseen/src/domain/entities/add_number.dart';
import 'package:wpfamilylastseen/src/domain/entities/device_connections.dart';
import 'package:wpfamilylastseen/src/domain/entities/edit_number.dart';
import 'package:wpfamilylastseen/src/domain/entities/langauge_register.dart';
import 'package:wpfamilylastseen/src/domain/entities/last_seen_languages.dart';
import 'package:wpfamilylastseen/src/domain/entities/last_seen_numbers.dart';
import 'package:wpfamilylastseen/src/domain/entities/last_seen_product.dart';
import 'package:wpfamilylastseen/src/domain/entities/last_seen_settings.dart';
import 'package:wpfamilylastseen/src/domain/entities/purchase_control.dart';
import '../entities/last_seen_number.dart';

abstract class HomePageRepository {
  Future<LangaugeRegister?> getLangaugeRegister();
  Future<LangaugeRegister?> postLangaugeRegister(String device,
      String tokenData, String timezone, String locale, String version);
  Future<LastSeenSettings?> getLastSeenSettings(String device);
  Future<List<LastSeenProduct>> getLastSeenProduct(String device);
  Future<List<ApiGoogleProduct>> getApiGoogleProduct(String device);
  Future<List<LastSeenNumbers>> getLastSeenNumbers(String device);
  Future<AddNumber?> postAddNumber(String sku, String name, String number,
      String countryCode, String token, String detail, String device);
  Future<EditNumber?> postEditNumber(String name, String notif, String phoneId,
      String isFavorite, String device);
  Future removeNumber(String id, String device);
  Future<LastSeenNumber?> getLastSeenNumber(String numberId, String device);
  Future<List<LastSeenLanguages>> getLastSeenLanguages(String device);
  Future<PurchaseControl?> getPurchaseControl(
      String product_sku, String verify_token);
  Future<List<DeviceConnections>> getDeviceConnections(String device);
}

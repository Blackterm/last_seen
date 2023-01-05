import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import '../entities/last_seen_settings.dart';
import '../repositories/home_page_repository.dart';

class GetLastSeenSettings
    extends UseCase<LastSeenSettings?, GetLastSeenSettingsParams> {
  final HomePageRepository _homePageRepository;

  GetLastSeenSettings(this._homePageRepository);
  @override
  Future<Stream<LastSeenSettings?>> buildUseCaseStream(
      GetLastSeenSettingsParams? params) async {
    StreamController<LastSeenSettings?> controller = StreamController();
    try {
      LastSeenSettings? list = await _homePageRepository.getLastSeenSettings(
        params!.device,
      );
      controller.add(list);
      controller.close();
    } catch (e, st) {
      print(e);
      print(st);
      controller.addError(e, st);
    }
    return controller.stream;
  }
}

class GetLastSeenSettingsParams {
  final String device;

  GetLastSeenSettingsParams(this.device);
}

import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wpfamilylastseen/src/domain/entities/last_seen_languages.dart';

import '../repositories/home_page_repository.dart';

class GetLastSeenLanguages
    extends UseCase<List<LastSeenLanguages>, GetLastSeenLanguagesParams> {
  final HomePageRepository _homePageRepository;

  GetLastSeenLanguages(this._homePageRepository);
  @override
  Future<Stream<List<LastSeenLanguages>?>> buildUseCaseStream(
      GetLastSeenLanguagesParams? params) async {
    StreamController<List<LastSeenLanguages>> controller = StreamController();
    try {
      List<LastSeenLanguages> list =
          await _homePageRepository.getLastSeenLanguages(
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

class GetLastSeenLanguagesParams {
  final String device;

  GetLastSeenLanguagesParams(this.device);
}

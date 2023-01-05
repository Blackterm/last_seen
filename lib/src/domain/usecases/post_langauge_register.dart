import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import '../entities/langauge_register.dart';
import '../repositories/home_page_repository.dart';

class PostLangaugeRegister
    extends UseCase<LangaugeRegister?, PostLangaugeRegisterParams> {
  final HomePageRepository _homePageRepository;

  PostLangaugeRegister(this._homePageRepository);
  @override
  Future<Stream<LangaugeRegister?>> buildUseCaseStream(
      PostLangaugeRegisterParams? params) async {
    StreamController<LangaugeRegister?> controller = StreamController();
    try {
      LangaugeRegister? list = await _homePageRepository.postLangaugeRegister(
          params!.device,
          params.tokenData,
          params.timezone,
          params.locale,
          params.version);
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

class PostLangaugeRegisterParams {
  final String device;
  final String tokenData;
  final String timezone;
  final String locale;
  final String version;

  PostLangaugeRegisterParams(
    this.device,
    this.tokenData,
    this.timezone,
    this.locale,
    this.version,
  );
}

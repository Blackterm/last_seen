import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wpfamilylastseen/src/domain/entities/langauge_register.dart';
import '../repositories/home_page_repository.dart';

class GetLangaugeRegister extends UseCase<LangaugeRegister?, void> {
  final HomePageRepository _homePageRepository;

  GetLangaugeRegister(this._homePageRepository);
  @override
  Future<Stream<LangaugeRegister?>> buildUseCaseStream(void params) async {
    StreamController<LangaugeRegister?> controller = StreamController();
    try {
      LangaugeRegister? getUser =
          await _homePageRepository.getLangaugeRegister();
      controller.add(getUser);
      controller.close();
    } catch (e, st) {
      print(e);
      print(st);
      controller.addError(e, st);
    }
    return controller.stream;
  }
}

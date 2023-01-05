import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wpfamilylastseen/src/domain/entities/last_seen_numbers.dart';
import '../repositories/home_page_repository.dart';

class GetLastSeenNumbers
    extends UseCase<List<LastSeenNumbers>, GetLastSeenNumbersParams> {
  final HomePageRepository _homePageRepository;

  GetLastSeenNumbers(this._homePageRepository);
  @override
  Future<Stream<List<LastSeenNumbers>?>> buildUseCaseStream(
      GetLastSeenNumbersParams? params) async {
    StreamController<List<LastSeenNumbers>> controller = StreamController();
    try {
      List<LastSeenNumbers> list = await _homePageRepository.getLastSeenNumbers(
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

class GetLastSeenNumbersParams {
  final String device;

  GetLastSeenNumbersParams(this.device);
}

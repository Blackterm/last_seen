import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wpfamilylastseen/src/domain/entities/last_seen_number.dart';
import '../repositories/home_page_repository.dart';

class GetLastSeenNumber
    extends UseCase<LastSeenNumber?, GetLastSeenNumberParams> {
  final HomePageRepository _homePageRepository;

  GetLastSeenNumber(this._homePageRepository);
  @override
  Future<Stream<LastSeenNumber?>> buildUseCaseStream(
      GetLastSeenNumberParams? params) async {
    StreamController<LastSeenNumber?> controller = StreamController();
    try {
      LastSeenNumber? list = await _homePageRepository.getLastSeenNumber(
        params!.numberId,
        params.device,
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

class GetLastSeenNumberParams {
  final String numberId;
  final String device;

  GetLastSeenNumberParams(this.numberId, this.device);
}

import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import '../entities/edit_number.dart';
import '../repositories/home_page_repository.dart';

class PostEditNumber extends UseCase<EditNumber?, PostEditNumberParams> {
  final HomePageRepository _homePageRepository;

  PostEditNumber(this._homePageRepository);
  @override
  Future<Stream<EditNumber?>> buildUseCaseStream(
      PostEditNumberParams? params) async {
    StreamController<EditNumber?> controller = StreamController();
    try {
      EditNumber? list = await _homePageRepository.postEditNumber(
        params!.name,
        params.notif,
        params.phoneId,
        params.isFavorite,
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

class PostEditNumberParams {
  final String name;
  final String notif;
  final String phoneId;
  final String isFavorite;
  final String device;

  PostEditNumberParams(
    this.name,
    this.notif,
    this.phoneId,
    this.isFavorite,
    this.device,
  );
}

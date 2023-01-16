import 'dart:async';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import '../repositories/home_page_repository.dart';

class PostEditConnection extends UseCase<dynamic, PostEditConnectionParams> {
  final HomePageRepository _homePageRepository;

  PostEditConnection(this._homePageRepository);
  @override
  Future<Stream<dynamic>> buildUseCaseStream(
      PostEditConnectionParams? params) async {
    StreamController<dynamic> controller = StreamController();
    try {
      dynamic list = await _homePageRepository.postEditConnection(
        params!.connectionId,
        params.numberId,
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

class PostEditConnectionParams {
  final String connectionId;
  String numberId;
  final String device;

  PostEditConnectionParams(this.connectionId, this.numberId, this.device);
}

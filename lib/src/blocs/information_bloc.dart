import 'package:jasindo_app/src/models/abouts_model.dart';
import 'package:jasindo_app/src/models/information_model.dart';
import 'package:jasindo_app/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class InformationBloc {
  final _repository = Repository();
  final _infoBloc = PublishSubject<InformationModels>();

  Observable<InformationModels> get getaboutBloc => _infoBloc.stream;

  infoBloc() async {
    InformationModels model = await _repository.fetchInformation();
    _infoBloc.sink.add(model);
  }

  dispose() {
    _infoBloc.close();
  }
}

final bloc = InformationBloc();

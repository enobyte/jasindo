import 'package:jasindo_app/src/models/abouts_model.dart';
import 'package:jasindo_app/src/models/news_model.dart';
import 'package:jasindo_app/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class NewsBloc {
  final _repository = Repository();
  final _newsBloc = PublishSubject<NewsModel>();

  Observable<NewsModel> get getNewsBloc => _newsBloc.stream;

  newsBloc(Function(NewsModel model) callback) async {
    NewsModel model = await _repository.fetchNews();
    _newsBloc.sink.add(model);
    callback(model);
  }

  dispose() {
    _newsBloc.close();
  }
}

final bloc = NewsBloc();

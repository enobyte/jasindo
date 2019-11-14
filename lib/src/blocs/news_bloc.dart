import 'package:jasindo_app/src/models/news_model.dart';
import 'package:jasindo_app/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class NewsBloc {
  final _repository = Repository();
  final _newsBloc = PublishSubject<NewsModel>();

  Observable<NewsModel> get getNewsBloc => _newsBloc.stream;

  newsBloc(Function(NewsModel model) callback, String package_name) async {
    NewsModel model = await _repository.fetchNews(package_name: package_name);
    _newsBloc.sink.add(model);
    callback(model);
  }

  dispose() {
    _newsBloc.close();
  }
}

final bloc = NewsBloc();

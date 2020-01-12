import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:named_entities_extraction/data_sources/local_data_source.dart';
import 'package:named_entities_extraction/entities/tagged_entity.dart';
import './bloc.dart';
import 'package:named_entities_extraction/data_sources/remote_data_source.dart';

class NexBloc extends Bloc<NexEvent, NexState> {
  @override
  NexState get initialState => Empty();

  @override
  Stream<NexState> mapEventToState(
    NexEvent event,
  ) async* {
    if (event is GetData) {
      yield Loading();
      Response response = await RemoteDataSource().getDataFromRemote();
      print('getDataFromRemote called!');
      if (response.statusCode == 200) {
        // if we get a successful response from the sever we return Loaded sate
        // var data = await json.decode(response.body);
        
        // yield Loaded(data: response);
      } else {
        // else we return Error state
        yield Error();
      }
    } else if (event is GetDataFromLocal) {
      yield Loading();
      await Future.delayed(Duration(milliseconds: Random().nextInt(2000)));
      List<TaggedEntity> result =
          LocalDataSource().tagEntities(event.text.split(" "));
      yield result.isEmpty ? Empty() : Loaded(data: result);
    }
  }
}

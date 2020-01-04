import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class NexEvent extends Equatable {
  const NexEvent();
}

class GetData extends NexEvent {
  @override
  List<Object> get props => null;
}

class GetDataFromLocal extends NexEvent {
  final text;
  GetDataFromLocal({@required this.text});
  @override
  List<Object> get props => null;
}

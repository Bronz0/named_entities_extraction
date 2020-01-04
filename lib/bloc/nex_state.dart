import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class NexState extends Equatable {
  const NexState();
}

// this class represents the initial state where no event was added to the stream (noting hapens yet)
class Empty extends NexState {
  @override
  List<Object> get props => [];
}

// this class represent the loading state, when the app is waiting for the server's response
class Loading extends NexState {
  @override
  List<Object> get props => null;
}

// this class represent the loaded state, when the app get a successful response from the server
class Loaded extends NexState {
  final data;
  Loaded({@required this.data}) : assert(data != null);
  @override
  List<Object> get props => null;
}

// this class represent an error state, when the app get a bad response (or no response) from the server
class Error extends NexState {
  @override
  List<Object> get props => null;
}

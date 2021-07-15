import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
}

class GenerateDataSet extends AppEvent {
  @override
  List<Object?> get props => [];
}
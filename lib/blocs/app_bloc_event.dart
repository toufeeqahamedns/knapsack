import 'package:equatable/equatable.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
}

class GenerateDataSet extends AppEvent {
  final int value;

  GenerateDataSet(this.value);

  @override
  List<Object?> get props => [];
}

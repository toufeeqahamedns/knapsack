import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knapsack/blocs/app_bloc_event.dart';
import 'package:knapsack/blocs/app_bloc_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState.unknown());

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is GenerateDataSet) {}
  }
}

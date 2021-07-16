import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knapsack/blocs/app_bloc_event.dart';
import 'package:knapsack/blocs/app_bloc_state.dart';
import 'package:knapsack/knapsack_item.dart';
import 'package:random_color/random_color.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState.unknown());

  late List<KnapsackItem> dataSet;

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is GenerateDataSet) {
      yield* _mapGenerateDataSetToState(event.value);
    }
  }

  Stream<AppState> _mapGenerateDataSetToState(int value) async* {
    yield AppState.generatingData();

    dataSet = List<KnapsackItem>.generate(value, (index) {
      return KnapsackItem(
          Random().intInRange(2, 10),
          Random().intInRange(2, 10),
          RandomColor()
              .randomColor(colorSaturation: ColorSaturation.highSaturation));
    });

    yield AppState.datasetGenerated();
  }
}

extension RandomInt on Random {
  int intInRange(int start, int end) =>
      start + Random().nextInt((end + 1) - start);
}
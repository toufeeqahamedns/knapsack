import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knapsack/blocs/app_bloc_event.dart';
import 'package:knapsack/blocs/app_bloc_state.dart';
import 'package:knapsack/knapsack_item.dart';
import 'package:random_color/random_color.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState.unknown());

  late List<KnapsackItem> dataSet;
  List<KnapsackItem> itemsSelected = [];
  late int maxValueObtained;

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is GenerateDataSet) {
      yield* _mapGenerateDataSetToState(event.value);
    } else if (event is FillSack) {
      yield* _mapFillSackToState(event.sackSize);
    }
  }

  Stream<AppState> _mapGenerateDataSetToState(int value) async* {
    yield AppState.generatingData();

    dataSet = List<KnapsackItem>.generate(
        value,
        (index) => KnapsackItem(
            Random().intInRange(2, 10),
            Random().intInRange(2, 10),
            RandomColor()
                .randomColor(colorSaturation: ColorSaturation.highSaturation)));

    yield AppState.datasetGenerated();
  }

  Stream<AppState> _mapFillSackToState(int sackSize) async* {
    yield AppState.fillingSack();
    computeKnapsack(sackSize, dataSet, dataSet.length);
    yield AppState.sackFilled();
  }

  void computeKnapsack(int sackSize, List<KnapsackItem> dataSet, int n) {
    List<List<int>> k =
        List.generate(n + 1, (_) => List.generate(sackSize + 1, (_) => 0));

    int i = 0;
    int w = 0;

    for (i = 0; i <= n; i++) {
      for (int w = 0; w <= sackSize; w++) {
        if (i == 0 || w == 0) {
          k[i][w] = 0;
        } else if (dataSet[i - 1].itemWeight <= w) {
          k[i][w] = max(
              dataSet[i - 1].itemValue +
                  k[i - 1][w - dataSet[i - 1].itemWeight],
              k[i - 1][w]);
        } else {
          k[i][w] = k[i - 1][w];
        }
      }
    }

    maxValueObtained = k[n][sackSize];
    print("Max Value obtained: $maxValueObtained");
    w = sackSize;
    itemsSelected.clear();
    for (i = n; i > 0 && maxValueObtained > 0; i--) {
      if (maxValueObtained == k[i - 1][w]) {
        continue;
      } else {
        itemsSelected.add(dataSet[i - 1]);

        print("${dataSet[i - 1].itemWeight} ");

        maxValueObtained = maxValueObtained - dataSet[i - 1].itemValue;
        w = w - dataSet[i - 1].itemWeight;
      }
    }
  }
}

extension RandomInt on Random {
  int intInRange(int start, int end) =>
      start + Random().nextInt((end + 1) - start);
}

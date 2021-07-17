import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knapsack/blocs/app_bloc.dart';
import 'package:knapsack/blocs/app_bloc_event.dart';
import 'package:knapsack/blocs/app_bloc_state.dart';
import 'package:knapsack/dataset_visualizer.dart';
import 'package:knapsack/sack_visualizer.dart';

class KnapSack extends StatefulWidget {
  const KnapSack({Key? key}) : super(key: key);

  @override
  _KnapSackState createState() => _KnapSackState();
}

class _KnapSackState extends State<KnapSack> {
  double itemSize = (Random().doubleInRange(5, 10)).roundToDouble();
  double sackSize = 10;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Center(child: Text("Set number of items between 5-10: ${itemSize.toInt()}")),
                Slider(
                    min: 5,
                    max: 10,
                    label: "$itemSize",
                    value: itemSize,
                    onChanged: (newValue) {
                      setState(() {
                        itemSize = newValue.roundToDouble();
                      });
                    }),
                ElevatedButton(
                    child: Text("Generate Dataset"),
                    onPressed: () {
                      sackSize = (Random().doubleInRange(10, 50)).roundToDouble();
                      context.read<AppBloc>().add(
                            GenerateDataSet(
                              itemSize.toInt(),
                            ),
                          );
                    }),
                SizedBox(height: 8.0),
                BlocBuilder<AppBloc, AppState>(
                  builder: (BuildContext context, AppState state) {
                    switch (state.status) {
                      case AppStatus.datasetGenerated:
                      case AppStatus.fillingSack:
                      case AppStatus.sackFilled:
                        return DatasetVisualizer(
                            context.watch<AppBloc>().dataSet);
                      case AppStatus.generatingDataset:
                        return Center(child: Text("Generating dataset..."));
                      case AppStatus.unknown:
                      default:
                        return Center(child: Text("Generate DataSet to continue..."));
                    }
                  },
                ),
                SizedBox(height: 8.0),
                Offstage(
                  offstage:
                      context.watch<AppBloc>().state == AppState.unknown() ||
                          context.watch<AppBloc>().state ==
                              AppState.generatingData(),
                  child: Column(
                    children: [
                      Text("Set Sack Size 10-50: ${sackSize.toInt()}"),
                      Slider(
                          min: 10,
                          max: 50,
                          label: "$sackSize",
                          value: sackSize,
                          onChanged: (newValue) {
                            setState(() {
                              print(newValue);
                              sackSize = newValue.roundToDouble();
                            });
                          }),
                      ElevatedButton(
                        child: Container(
                            width: double.infinity,
                            child: Center(child: Text("Fill Sack"))),
                        onPressed: () => context.read<AppBloc>().add(
                              FillSack(
                                sackSize.toInt(),
                              ),
                            ),
                      ),
                      SizedBox(height: 8.0),
                      BlocBuilder<AppBloc, AppState>(
                        builder: (BuildContext context, AppState state) {
                          switch (state.status) {
                            case AppStatus.sackFilled:
                              return SackVisualizer(
                                  context.watch<AppBloc>().itemsSelected,
                                  context.watch<AppBloc>().maxValueObtained,
                                  context.watch<AppBloc>().maxWeightObtained);
                            case AppStatus.fillingSack:
                              return Text("Filling Sack...");
                            case AppStatus.unknown:
                            default:
                              return Text("Fill Sack to view result...");
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension RandomDouble on Random {
  double doubleInRange(int start, int end) =>
      Random().nextDouble() * (end - start) + start;
}

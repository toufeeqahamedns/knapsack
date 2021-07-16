import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knapsack/blocs/app_bloc.dart';
import 'package:knapsack/blocs/app_bloc_event.dart';
import 'package:knapsack/blocs/app_bloc_state.dart';
import 'package:knapsack/dataset_visualizer.dart';

class KnapSack extends StatefulWidget {
  const KnapSack({Key? key}) : super(key: key);

  @override
  _KnapSackState createState() => _KnapSackState();
}

class _KnapSackState extends State<KnapSack> {
  double value = (Random().doubleInRange(5, 10)).roundToDouble();

  @override
  Widget build(BuildContext context) {
    print(value);
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Set number of items between 5-10: ${value.toInt()}"),
                Slider(
                    min: 5,
                    max: 10,
                    label: "$value",
                    value: value,
                    onChanged: (newValue) {
                      setState(() {
                        print(newValue);
                        value = newValue.roundToDouble();
                      });
                    }),
                ElevatedButton(
                    child: Text("Generate Dataset"),
                    onPressed: () {
                      context
                          .read<AppBloc>()
                          .add(GenerateDataSet(value.toInt()));
                    }),
                SizedBox(height: 8.0),
                BlocBuilder<AppBloc, AppState>(
                  builder: (BuildContext context, AppState state) {
                    switch (state.status) {
                      case AppStatus.datasetGenerated:
                        return DatasetVisualizer(
                            context.watch<AppBloc>().dataSet);
                      case AppStatus.generatingDataset:
                        return Text("Generating dataset...");
                      case AppStatus.unknown:
                      default:
                        return Text("Generate DataSet to continue...");
                    }
                  },
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

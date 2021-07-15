import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knapsack/blocs/app_bloc.dart';
import 'package:knapsack/blocs/app_bloc_state.dart';

class KnapSack extends StatelessWidget {
  const KnapSack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    child: Text("Generate Dataset"), onPressed: () {}),
                SizedBox(height: 8.0),
                BlocBuilder<AppBloc, AppState>(
                    builder: (BuildContext context, AppState state) {
                  switch (state.status) {
                    case AppStatus.unknown:
                    default:
                      return Text("Generate DataSet to continue...");
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

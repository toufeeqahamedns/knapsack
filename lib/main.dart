import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knapsack/blocs/app_bloc.dart';
import 'package:knapsack/knapsack.dart';

void main() {
  runApp(
    BlocProvider<AppBloc>(
      create: (_) => AppBloc(),
      child: KnapSack(),
    ),
  );
}
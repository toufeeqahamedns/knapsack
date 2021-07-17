import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:knapsack/blocs/app_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knapsack/knapsack_item.dart';

class DatasetVisualizer extends StatelessWidget {
  final List<KnapsackItem> items;

  const DatasetVisualizer(this.items, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: const Color(0xff2c4260),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 12,
              barTouchData: BarTouchData(
                enabled: false,
              ),
              axisTitleData: FlAxisTitleData(
                leftTitle: AxisTitle(
                  showTitle: true,
                  titleText: 'Item Weight',
                  margin: 0,
                  textStyle: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                bottomTitle: AxisTitle(
                  showTitle: true,
                  titleText: 'Item Value',
                  margin: 0,
                  textStyle: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: SideTitles(
                  showTitles: true,
                  getTitles: (value) =>
                      items[value.toInt()].itemValue.toString(),
                  getTextStyles: (value) =>
                      const TextStyle(color: Colors.white, fontSize: 10),
                  margin: 8.0,
                ),
                leftTitles: SideTitles(
                  showTitles: true,
                  getTextStyles: (value) =>
                      const TextStyle(color: Colors.white, fontSize: 10),
                  margin: 8.0,
                ),
              ),
              gridData: FlGridData(
                show: true,
                checkToShowHorizontalLine: (value) => value % 2 == 0,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: const Color(0xffe7e8ec),
                  strokeWidth: 1,
                ),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              barGroups: List<BarChartGroupData>.generate(
                context.watch<AppBloc>().dataSet.length,
                (index) {
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                          y: items[index].itemWeight.toDouble(),
                          width: 16.0,
                          colors: [items[index].itemColor]),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

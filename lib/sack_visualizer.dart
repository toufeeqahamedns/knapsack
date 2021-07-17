import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:knapsack/knapsack_item.dart';

class SackVisualizer extends StatelessWidget {
  final List<KnapsackItem> items;
  final int maxValue;
  final int maxWeight;

  const SackVisualizer(this.items, this.maxValue, this.maxWeight, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: const Color(0xff2c4260),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Total Weight filled: $maxWeight",
                style: TextStyle(color: Colors.white),
              ),
              Text(
                "Max Value obtained: $maxValue",
                style: TextStyle(color: Colors.white),
              ),
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    PieChart(
                      PieChartData(
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: List.generate(
                          items.length,
                          (i) {
                            final fontSize = 16.0;  
                            final radius = 50.0;
                            return PieChartSectionData(
                              color: items[i].itemColor,
                              value: items[i].itemWeight.toDouble(),
                              title: '${items[i].itemWeight}',
                              radius: radius,
                              titleStyle: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xffffffff)),
                            );
                          },
                        ),
                      ),
                    ),
                    Text(
                      "$maxValue",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

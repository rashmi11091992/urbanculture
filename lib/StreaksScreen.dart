import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Skincareprovider.dart';

class StreaksScreen extends StatefulWidget {
  @override
  State<StreaksScreen> createState() => _StreaksScreenState();
}

class _StreaksScreenState extends State<StreaksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCF7FA),
      appBar: AppBar(
        toolbarHeight: 50,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Streaks',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xffFCF7FA),
      ),
      body: Consumer<SkincareProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, top: 20),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Today',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '\'',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 's Goal: 3 streak days',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, top: 20),
                  padding: EdgeInsets.all(10),
                  height: 110,
                  width: 358,
                  decoration: BoxDecoration(
                      color: Color(0xfff2e8eb),
                      borderRadius: BorderRadius.circular(10)),
                  //   constraints: BoxConstraints(maxHeight: 110, maxWidth: 358),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Streak Days',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${provider.streak}',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Daily Streak',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${provider.streak}',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Last 30 Days ',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xffb88797),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: '+100%',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          height: 230,
                          width: 358,
                          child: LineChart(
                            LineChartData(
                              lineTouchData: LineTouchData(enabled: false),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: [
                                    FlSpot(0, 4), // 1D
                                    FlSpot(1, 8), // 1W
                                    FlSpot(2, 4), // 1M
                                    FlSpot(3, 9), // 3M
                                    FlSpot(4, 5), // 1Y
                                  ],
                                  isCurved: true,
                                  colors: [
                                    const Color(0xffb88797),
                                  ],
                                  barWidth: 4,
                                  isStrokeCapRound: true,
                                  belowBarData: BarAreaData(show: false),
                                  dotData: FlDotData(
                                    show: false,
                                  ), // Hide dots at points
                                ),
                              ],
                              titlesData: FlTitlesData(
                                bottomTitles: SideTitles(
                                  showTitles: true,
                                  getTitles: (value) {
                                    switch (value.toInt()) {
                                      case 0:
                                        return '1D';
                                      case 1:
                                        return '1W';
                                      case 2:
                                        return '1M';
                                      case 3:
                                        return '3M';
                                      case 4:
                                        return '1Y';
                                      default:
                                        return '';
                                    }
                                  },
                                  getTextStyles: (context, xValue) =>
                                      const TextStyle(
                                    color: Color(0xffb88797),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                leftTitles: SideTitles(
                                  showTitles: false,
                                ), // Hide y-axis labels
                              ),
                              borderData: FlBorderData(
                                show: false,
                              ), // Hide borders
                              gridData: FlGridData(
                                show: false,
                              ), // Hide grid lines
                            ),
                          ))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    'Keep it up! You are on a roll.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Get Started',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xfff2e8eb),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: Size(
                              constraints.maxWidth, 40), // Make it responsive
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          textStyle:
                              TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

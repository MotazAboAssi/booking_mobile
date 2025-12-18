import 'package:booking/data/sections/LandLordDashboard/Appartment_State_dashboard.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BodyLandLordDashboard extends StatelessWidget {
  const BodyLandLordDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(children: [Text("This mounth incoming")]),
                  Row(
                    children: [
                      Text(
                        "7000 Dollar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: const Color.fromARGB(255, 14, 141, 130),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "This mounth +8%",
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              height: 200,
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: 4,
                  minY: 0,
                  maxY: 5,

                  borderData: FlBorderData(show: false),

                  titlesData: FlTitlesData(show: false),
                  gridData: FlGridData(show: true), // إخفاء الخطوط
                  // titlesData: FlTitlesData(
                  //   // إظهار النصوص تحت النقاط
                  //   bottomTitles: AxisTitles(
                  //     sideTitles: SideTitles(
                  //       showTitles: true,
                  //       reservedSize: 32,
                  //       getTitlesWidget: (value, meta) {
                  //         List labels = ["Mon", "Tue", "Wed", "Thu", "Fri"];
                  //         return Text(labels[value.toInt()]);
                  //       },
                  //     ),
                  //   ),
                  //   leftTitles: AxisTitles(
                  //     sideTitles: SideTitles(showTitles: true),
                  //   ),
                  // ),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: false, // منحني
                      color: Colors.blue,
                      barWidth: 4,
                      dotData: FlDotData(show: true), // نقاط
                      spots: const [
                        FlSpot(0, 1),
                        FlSpot(1, 1.8),
                        FlSpot(2, 1.2),
                        FlSpot(3, 2.8),
                        FlSpot(4, 3.6),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 400, child: AppartmentStateDashboard()),
          ],
        ),
      ),
    );
  }
}

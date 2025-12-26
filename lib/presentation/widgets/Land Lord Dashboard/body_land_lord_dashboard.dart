// import 'package:booking/data/sections/LandLordDashboard/appartment_state_dashboard.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// class BodyLandLordDashboard extends StatelessWidget {
//   const BodyLandLordDashboard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         child: ListView(
//           children: [
//             Container(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   Row(children: [Text("This mounth incoming")]),
//                   Row(
//                     children: [
//                       Text(
//                         "7000 Dollar",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 25,
//                           color: const Color.fromARGB(255, 14, 141, 130),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         "This mounth +8%",
//                         style: TextStyle(color: Colors.blueGrey),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.all(20),
//               height: 200,
//               child: LineChart(
//                 LineChartData(
//                   minX: 0,
//                   maxX: 4,
//                   minY: 0,
//                   maxY: 5,

//                   borderData: FlBorderData(show: false),

//                   titlesData: FlTitlesData(show: false),
//                   gridData: FlGridData(show: true), // إخفاء الخطوط
//                   // titlesData: FlTitlesData(
//                   //   // إظهار النصوص تحت النقاط
//                   //   bottomTitles: AxisTitles(
//                   //     sideTitles: SideTitles(
//                   //       showTitles: true,
//                   //       reservedSize: 32,
//                   //       getTitlesWidget: (value, meta) {
//                   //         List labels = ["Mon", "Tue", "Wed", "Thu", "Fri"];
//                   //         return Text(labels[value.toInt()]);
//                   //       },
//                   //     ),
//                   //   ),
//                   //   leftTitles: AxisTitles(
//                   //     sideTitles: SideTitles(showTitles: true),
//                   //   ),
//                   // ),
//                   lineBarsData: [
//                     LineChartBarData(
//                       isCurved: false, // منحني
//                       color: Colors.blue,
//                       barWidth: 4,
//                       dotData: FlDotData(show: true), // نقاط
//                       spots: const [
//                         FlSpot(0, 1),
//                         FlSpot(1, 1.8),
//                         FlSpot(2, 1.2),
//                         FlSpot(3, 2.8),
//                         FlSpot(4, 3.6),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 400, child: AppartmentStateDashboard()),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class LandlordDashboard extends StatelessWidget {
  final requests = [
    _Request('أحمد علي', 'شقة رقم 3'),
    _Request('محمد حسن', 'شقة رقم 5'),
  ];
  final rentedApartments = [
    'شقة رقم 1',
    'شقة رقم 3',
    'شقة رقم 7',
    'شقة رقم 1',
    'شقة رقم 3',
    'شقة رقم 7',
    'شقة رقم 1',
    'شقة رقم 3',
    'شقة رقم 7',
  ];

  final notRentedApartments = ['شقة رقم 2', 'شقة رقم 4', 'شقة رقم 6'];

  void _showApartmentsDialog(
    BuildContext context, {
    required String title,
    required List<String> apartments,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: SizedBox(
            height: 300,
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: apartments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.home),
                  title: Text(apartments[index]),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('close', style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

  // final stats = [
  //   _Stat('Appartment count', '12', Icons.apartment),
  //   _Stat('Rented', '8', Icons.check_circle),
  //   _Stat('Not Rented', '4', Icons.cancel),
  //   _Stat('Balance', '\$1200', Icons.account_balance_wallet),
  // ];
  late final List<_Stat> stats;

  @override
  Widget build(BuildContext context) {
    stats = [
      _Stat('Appartment count', '12', Icons.apartment),

      _Stat(
        'Rented',
        '8',
        Icons.check_circle,
        onTap: () {
          _showApartmentsDialog(
            context,
            title: 'Rented Apartments',
            apartments: rentedApartments,
          );
        },
      ),

      _Stat(
        'Not Rented',
        '4',
        Icons.cancel,
        onTap: () {
          _showApartmentsDialog(
            context,
            title: 'Available Apartments',
            apartments: notRentedApartments,
          );
        },
      ),

      _Stat('Balance', '\$1200', Icons.account_balance_wallet),
    ];

    return Scaffold(
      backgroundColor: Color(0xfff5f7fb),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: stats.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.3,
              ),
              itemBuilder: (context, index) {
                final stat = stats[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: stat.onTap,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(stat.icon, color: Colors.blue, size: 28),
                          const Spacer(),
                          Text(
                            stat.title,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            stat.value,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 24),
            const Text(
              'New Requests',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Column(
              children: requests.map((r) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(r.name),
                    subtitle: Text(r.apartment),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.check, color: Colors.green),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat {
  final String title;
  final String value;
  final IconData icon;
  final VoidCallback? onTap;

  _Stat(this.title, this.value, this.icon, {this.onTap});
}

class _Request {
  final String name;
  final String apartment;

  _Request(this.name, this.apartment);
}

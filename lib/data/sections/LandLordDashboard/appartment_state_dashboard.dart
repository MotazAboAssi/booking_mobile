import 'package:flutter/material.dart';

class AppartmentStateDashboard extends StatefulWidget {
  const AppartmentStateDashboard({super.key});

  @override
  State<AppartmentStateDashboard> createState() =>
      _AppartmentStateDashboardState();
}

class _AppartmentStateDashboardState extends State<AppartmentStateDashboard> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  _buildTabButton("Rented", 0),
                  _buildTabButton("Listed", 1),
                ],
              ),
            ),
          ),

          SizedBox(height: 20),
          Expanded(
            child: selectedTab == 0
                ? _buildRentedList()
                : _buildNotRentedList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, int index) {
    bool isSelected = selectedTab == index;

    return Expanded(
      child: InkWell(
        onTap: () => setState(() => selectedTab = index),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRentedList() {
    List<String> rented = [
      "شقة 1 - قيد الاستئجار",
      "شقة 2 - قيد الاستئجار",
      "شقة 1 - قيد الاستئجار",
      "شقة 2 - قيد الاستئجار",
      "شقة 1 - قيد الاستئجار",
      "شقة 2 - قيد الاستئجار",
      "شقة 1 - قيد الاستئجار",
      "شقة 2 - قيد الاستئجار",
      "شقة 2 - قيد الاستئجار",
      "شقة 1 - قيد الاستئجار",
      "شقة 2 - قيد الاستئجار",
      "شقة 1 - قيد الاستئجار",
      "شقة 2 - قيد الاستئجار",
      "شقة 1 - قيد الاستئجار",
      "شقة 2 - قيد الاستئجار",
    ];

    return ListView.builder(
      itemCount: rented.length,
      padding: EdgeInsets.all(16),
      itemBuilder: (_, i) => Card(child: ListTile(title: Text(rented[i]))),
    );
  }

  Widget _buildNotRentedList() {
    List<String> notRented = ["شقة 3 - غير مؤجرة", "شقة 4 - غير مؤجرة"];

    return ListView.builder(
      itemCount: notRented.length,
      padding: EdgeInsets.all(16),
      itemBuilder: (_, i) => Card(child: ListTile(title: Text(notRented[i]))),
    );
  }
}

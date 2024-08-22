import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class HomeScreen extends StatelessWidget {
  static const routeName = "/home";
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.pinkAccent),
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  const Text('Hi, Demo Vendor...',
                      style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
                  Text(
                    DateFormat.yMMMEd().format(DateTime.now()),
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Container(
                height: 55,
                width: 55,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://t4.ftcdn.net/jpg/07/28/78/53/360_F_728785396_muNh6GKN3XdVTePE7vGCxPcXgpUBDdaA.jpg',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      body: Container(
        width: mediaQuery.size.width,
        height: mediaQuery.size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.blue.shade50],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      'This Month',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    const Text(
                      'All Reports',
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoCard('Gross Sales', '\$230.555', '+10%',
                          Icons.monetization_on, Colors.blueAccent, true,context),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildInfoCard('Earnings', '\$29.996', '+9.5%',
                          Icons.account_balance_wallet, Colors.red, false,context),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoCardWithCircleChart(
                          'Sold Items', '60', Icons.shopping_cart, Colors.green, true,context),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildInfoCardWithCircleChart(
                          'Orders Received', '40', Icons.receipt, Colors.lightBlueAccent, false,context),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Sales by Week',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 4),
                        const Text('Sales'),
                        const SizedBox(width: 16),
                        Container(
                          width: 12,
                          height: 12,
                          color: Colors.redAccent,
                        ),
                        const SizedBox(width: 4),
                        const Text('Revenue'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 300,
                  child: BarChart(
                    BarChartData(
                      barGroups: _getBarGroups(),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: getBottomTitles,
                              reservedSize: 30),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                '\$${value.toInt()}k',
                                style: const TextStyle(color: Colors.grey, fontSize: 12),
                              );
                            },
                            reservedSize: 30,
                          ),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String amount, String change, IconData icon, Color color, bool is1stCard, BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      height: mediaQuery.size.height * 0.19,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 42,),
              const Spacer(),
              Text(
                change,
                style: TextStyle(color: (is1stCard ? color : Colors.blue)),
              ),
              const Icon(Icons.arrow_upward, color: Colors.blue, size: 16),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            amount,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: (is1stCard ? Colors.black : Colors.red)),
          ),
          const SizedBox(height: 4),
          Text(title,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCardWithCircleChart(String title, String amount, IconData icon, Color color, bool is1stCard,context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      height: mediaQuery.size.height * 0.19,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 42,),
              const Spacer(),
              Transform.translate(
                  offset: const Offset(-25, 10),
                  child: MultiColorPieChart()),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            amount,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: (is1stCard ? Colors.green : Colors.lightBlueAccent)),
          ),
          const SizedBox(height: 4),
          Text(title,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12);
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Mon', style: style);
        break;
      case 1:
        text = const Text('Tue', style: style);
        break;
      case 2:
        text = const Text('Wed', style: style);
        break;
      case 3:
        text = const Text('Thu', style: style);
        break;
      case 4:
        text = const Text('Fri', style: style);
        break;
      case 5:
        text = const Text('Sat', style: style);
        break;
      case 6:
        text = const Text('Sun', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(axisSide: meta.axisSide, child: text);
  }

  List<BarChartGroupData> _getBarGroups() {
    return [
      _makeGroupData(0, 8, 6, 12),
      _makeGroupData(1, 6, 4, 12),
      _makeGroupData(2, 9, 5, 12),
      _makeGroupData(3, 4, 3, 12),
      _makeGroupData(4, 7, 5, 12),
      _makeGroupData(5, 10, 4, 12),
      _makeGroupData(6, 7, 3, 12),
    ];
  }

  BarChartGroupData _makeGroupData(int x, double y1, double y2, double maxY) {
    return

      BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: maxY,
          color: Colors.transparent,
          width: 16,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          rodStackItems: [
            BarChartRodStackItem(0, maxY, Colors.grey.shade300),
            BarChartRodStackItem(0, y1 , Colors.blue),
            BarChartRodStackItem(0, y2, Colors.redAccent),
          ],
        ),
      ],
    );
  }
}

class MultiColorPieChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 10,
      height: 10,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              color: Colors.red,
              value: 15,
              title: '',
              radius: 7,
            ),
            PieChartSectionData(
              color: Colors.blue,
              value: 20,
              title: '',
              radius: 7,
            ),
            PieChartSectionData(
              color: Colors.green,
              value: 25,
              title: '',
              radius: 7,
            ),
            PieChartSectionData(
              color: Colors.grey.shade300,
              value: 35,
              title: '',
              radius: 7,
            ),
          ],
          sectionsSpace: 0,
          centerSpaceRadius: 15,
        ),
      ),
    );
  }
}
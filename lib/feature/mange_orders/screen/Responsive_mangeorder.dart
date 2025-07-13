import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/utils/font/fonts.dart';
import '../Data/model/order.dart';

class ResponsiveManageOrder extends StatefulWidget {
  const ResponsiveManageOrder({super.key});

  @override
  _ResponsiveManageOrderState createState() => _ResponsiveManageOrderState();
}

class _ResponsiveManageOrderState extends State<ResponsiveManageOrder> {
  int? selectedOrderIndex;
  DateTime? lastTapTime;
  bool showTopProducts = false;

  List<Order> orders = [
    Order(name: "الكل", price: 12870, percent: -2.5),
    Order(name: "سيارات", price: 12870, percent: -2.2),
    Order(name: "عقارات", price: 12870, percent: -2.5),
    Order(name: "ملابس", price: 12870, percent: -2.5),
    Order(name: "الجوال-انترنت", price: 12870, percent: 1.8),
    Order(name: "الأجهزة الإلكترونية", price: 12870, percent: 0.9),
  ];

  double getCardAspectRatio(double width) {
    if (width >= 1200) return 3.5;
    if (width >= 800) return 2.8;
    return 4;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildOrdersList(
                  crossAxisCount: constraints.maxWidth < 800 ? 1 : 3,
                  aspect: getCardAspectRatio(constraints.maxWidth),
                ),
                const SizedBox(height: 30),
                _buildChartHeader(),
                const SizedBox(height: 12),
                showTopProducts ? _buildTopProductsTable() : _buildLineChart(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildChartHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '\$11.642',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: Fonts.cairo,
          ),
        ),
        Text(
          '+3.4% من الفترة الماضية',
          style: TextStyle(
            fontSize: 14,
            color: Colors.green[600],
            fontFamily: Fonts.cairo,
          ),
        ),
      ],
    );
  }

  Widget _buildLineChart() {
    const days = ['جمعة', 'خميس', 'أربع', 'ثلاث', 'اثنين', 'أحد', 'سبت'];
    final spotData = [
      FlSpot(0, 0),
      FlSpot(1, 40),
      FlSpot(2, 35),
      FlSpot(3, 50),
      FlSpot(4, 65),
      FlSpot(5, 20),
      FlSpot(6, 80),
    ];

    return AspectRatio(
      aspectRatio: 1.8,
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: 100,
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 42,
                getTitlesWidget: (value, _) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    '\$${value.toInt()}k',
                    style: TextStyle(fontSize: 12, fontFamily: Fonts.cairo),
                  ),
                ),
                interval: 20,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, _) {
                  int index = value.toInt();
                  if (index >= 0 && index < days.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        days[index],
                        style: TextStyle(
                          fontFamily: Fonts.cairo,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: index == 4 ? Colors.blue : Colors.black,
                        ),
                      ),
                    );
                  }
                  return const Text('');
                },
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spotData,
              isCurved: false,
              color: Colors.green,
              barWidth: 2,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: Colors.green.withOpacity(0.2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopProductsTable() {
    final products = [
      {"name": "لاب توب HP", "percent": 45.0, "color": Colors.blue},
      {"name": "سماعة بلوتوث JBL", "percent": 29.0, "color": Colors.green},
      {"name": "ثلاجة سامسونج", "percent": 18.0, "color": Colors.purple},
      {"name": "شواحن سريعة", "percent": 25.0, "color": Colors.orange},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0, right: 4),
          child: Text(
            "المنتجات الاكثر مبيعًا",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: Fonts.cairo,
              color: Colors.blue[900],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 30, child: Text('#', textAlign: TextAlign.center, style: TextStyle(fontFamily: Fonts.cairo, fontWeight: FontWeight.bold))),
                    Expanded(child: Text('الاسم', textAlign: TextAlign.center, style: TextStyle(fontFamily: Fonts.cairo, fontWeight: FontWeight.bold))),
                    Expanded(child: Text('النسبة', textAlign: TextAlign.center, style: TextStyle(fontFamily: Fonts.cairo, fontWeight: FontWeight.bold))),
                    SizedBox(width: 60, child: Text('المبيعات', textAlign: TextAlign.center, style: TextStyle(fontFamily: Fonts.cairo, fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
              Divider(),
              ...List.generate(products.length, (index) {
                final item = products[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 30,
                        child: Text(
                          "0${index + 1}",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: Fonts.cairo, color: Colors.grey[800]),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          item['name'].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: Fonts.cairo, fontSize: 14),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: (item['color'] as Color).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            FractionallySizedBox(
                              widthFactor: (item['percent'] as double) / 100,
                              child: Container(
                                height: 6,
                                decoration: BoxDecoration(
                                  color: item['color'] as Color,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: (item['color'] as Color).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "${item['percent']}%",
                            style: TextStyle(
                              fontFamily: Fonts.cairo,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: item['color'] as Color,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildOrdersList({required int crossAxisCount, required double aspect}) {
    final cardColors = [
      Colors.blue.shade100,
      Colors.cyan.shade100,
      Colors.grey.shade300,
      Colors.pink.shade100,
      Colors.purple.shade100,
      Colors.green.shade100,
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: aspect,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        final color = cardColors[index % cardColors.length];

        return GestureDetector(
          onTap: () {
            final now = DateTime.now();
            if (selectedOrderIndex == index &&
                lastTapTime != null &&
                now.difference(lastTapTime!) < Duration(milliseconds: 400)) {
              setState(() {
                showTopProducts = true;
              });
            } else {
              setState(() {
                selectedOrderIndex = index;
                showTopProducts = false;
                lastTapTime = now;
              });
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    order.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: Fonts.cairo,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${order.percent > 0 ? '+' : ''}${order.percent.toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: Fonts.cairo,
                        color: order.percent < 0 ? Colors.red[400] : Colors.green[700],
                      ),
                    ),
                    Text(
                      "\$${order.price.toStringAsFixed(2)}k",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: Fonts.cairo,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

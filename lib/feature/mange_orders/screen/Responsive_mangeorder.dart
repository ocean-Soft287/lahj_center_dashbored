import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lahj_center/feature/mange_orders/screen/widget/order_list.dart';

import '../../../core/utils/font/fonts.dart';
import '../Data/model/data_of_category.dart';
import '../screen/manger/datagroupdata_cubit.dart';

class ResponsiveManageOrder extends StatefulWidget {
  const ResponsiveManageOrder({super.key});

  @override
  State<ResponsiveManageOrder> createState() => _ResponsiveManageOrderState();
}

class _ResponsiveManageOrderState extends State<ResponsiveManageOrder> {
  int? selectedOrderIndex;
  DateTime? lastTapTime;
  bool showTopProducts = false;

  double getCardAspectRatio(double width) {
    if (width >= 1200) return 3.5;
    if (width >= 800) return 2.8;
    return 4;
  }

  void handleOrderTap(int index) {
    final now = DateTime.now();
    if (selectedOrderIndex == index &&
        lastTapTime != null &&
        now.difference(lastTapTime!) < const Duration(milliseconds: 400)) {
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
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return BlocProvider(
          create:
              (context) =>
                  GetIt.instance<DatagroupdataCubit>()..getDataNumber(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BuildOrdersList(
                    crossAxisCount: constraints.maxWidth < 800 ? 1 : 3,
                    aspect: getCardAspectRatio(constraints.maxWidth),
                    onOrderTap: handleOrderTap,
                  ),
                  const SizedBox(height: 30),
                  _buildChartHeader(),
                  const SizedBox(height: 12),
                  showTopProducts
                      ? _buildTopProductsTable()
                      : _buildLineChart(),
                ],
              ),
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
          style: const TextStyle(
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
                getTitlesWidget:
                    (value, _) => Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        '\$${value.toInt()}k',
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: Fonts.cairo,
                        ),
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
}


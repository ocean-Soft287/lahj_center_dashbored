import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/font/fonts.dart';
import '../../Data/model/data_of_category.dart';
import '../manger/datagroupdata_cubit.dart';

class BuildOrdersList extends StatelessWidget {
  const BuildOrdersList({
    super.key,
    required this.crossAxisCount,
    required this.aspect,
    required this.onOrderTap,
  });

  final int crossAxisCount;
  final double aspect;
  final void Function(int index) onOrderTap;

  @override
  Widget build(BuildContext context) {
    final cardColors = [
      Colors.blue.shade100,
      Colors.cyan.shade100,
      Colors.grey.shade300,
      Colors.pink.shade100,
      Colors.purple.shade100,
      Colors.green.shade100,
    ];

    return BlocBuilder<DatagroupdataCubit, DatagroupdataState>(
      builder: (context, state) {
        if (state is DatagroupdataLoaded) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: aspect,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: state.data.length,
            itemBuilder: (context, index) {
              final GroupDataNumbers groupDataNumbers = state.data[index];
              final color = cardColors[index % cardColors.length];

              return GestureDetector(
                onTap: () => onOrderTap(index),
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
                          groupDataNumbers.groupName,
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
                            '0',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: Fonts.cairo,
                              color: Colors.red[400],
                            ),
                          ),
                          const Text(
                            "",
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
        return const SizedBox();
      },
    );
  }
}

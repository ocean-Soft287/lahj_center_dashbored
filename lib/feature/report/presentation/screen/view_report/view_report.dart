import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lahj_center/core/utils/colors/colors.dart';
import 'package:lahj_center/feature/report/presentation/screen/view_report/widget/desktop_report_grid.dart';
import 'package:lahj_center/feature/report/presentation/screen/view_report/widget/mobile_report_list.dart';
import '../../../../../core/const/widget/custom_button.dart';
import '../../../../../core/utils/font/fonts.dart';
import '../../../data/report_model/comment_report.dart';
import '../../manger/report_cubit.dart';

class ViewReportScreen extends StatelessWidget {
  const ViewReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<ReportCubit>()..getReportComment(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "التقارير",
            style: TextStyle(fontFamily: Fonts.cairo),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<ReportCubit, ReportState>(
            builder: (context, state) {
          if (state is ReportError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(fontFamily: Fonts.cairo, color: Colors.red),
                  ),
                );
              } else if (state is ReportLoaded) {
                final reports = state.comments;

                return LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 800) {
                      return MobileReportList( reports: reports,);
                    } else {
                      return DesktopReportGrid(reports: reports, );
                    }
                  },
                );
              } else {
                return const SizedBox(); // fallback
              }
            },
          ),
        ),
      ),
    );
  }


}








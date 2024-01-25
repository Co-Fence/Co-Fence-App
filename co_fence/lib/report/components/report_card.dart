import 'package:co_fence/common/const/colors.dart';
import 'package:co_fence/report/model/report_model.dart';
import 'package:co_fence/report/model/report_status.dart';
import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  final String title;
  final String category;
  final String reportDate;

  const ReportCard({
    required this.title,
    required this.category,
    required this.reportDate,
    super.key,
  });

  factory ReportCard.fromModel({
    required ReportModel model,
  }) {
    return ReportCard(
      title: model.reportSubject,
      category: model.reportStatus.code,
      reportDate: model.createdAt.toString().substring(
            0,
            10,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: PRIMARY_COLOR,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(
          10.0,
        ),
      ),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(2.5),
        },
        border: TableBorder.symmetric(
          inside: const BorderSide(
            color: PRIMARY_COLOR,
            width: 1,
          ),
        ),
        children: [
          TableRow(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Category',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  category,
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Title',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Report Date',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  reportDate,
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

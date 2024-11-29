import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartAnalytics extends StatefulWidget {
  final Map<int, int> data;
  const ChartAnalytics({required this.data, super.key});

  @override
  State<ChartAnalytics> createState() => _ChartAnalyticsState();
}

class _ChartAnalyticsState extends State<ChartAnalytics> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        bottom: 0,
        left: 10,
        right: 10,
      ),
      child: BarChart(
        BarChartData(
          barTouchData: barTouchData,
          titlesData: titlesData,
          borderData: borderData,
          barGroups: barGroups,
          gridData: const FlGridData(show: false),
          alignment: BarChartAlignment.spaceAround,
          maxY: widget.data[0]!.toDouble() + 5,
        ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 1,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.cyan,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 10,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Total';
        break;
      case 1:
        text = 'Adultos';
        break;
      case 2:
        text = 'Jovens';
        break;
      case 3:
        text = 'Adolecentes';
        break;
      case 4:
        text = 'Crianças';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          Colors.blue,
          Colors.cyan,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups => [
    ...widget.data.entries.map((bar) => Bars(bar.key, bar.value.toDouble())),      
  ];
  
  BarChartGroupData Bars(int index, double quantidade){
    return BarChartGroupData(
      x: index,
      barRods: [
        BarChartRodData(
          toY: quantidade,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    );
  }
}




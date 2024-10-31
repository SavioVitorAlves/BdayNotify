
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartAnivesariantes extends StatefulWidget {
  const ChartAnivesariantes({required this.aniversariosPorMes, super.key});
  final Map<int, int> aniversariosPorMes;

  @override
  State<ChartAnivesariantes> createState() => _ChartAnivesariantesState();
}

class _ChartAnivesariantesState extends State<ChartAnivesariantes> {

  List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];
  


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.90,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 10,
              left: 0,
              top: 10,
              bottom: 10,
            ),
            child: LineChart(
               mainData(),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 10,
      color: Colors.white,
    );
    List<String> meses = ['JAN', 'FEV', 'MAR', 'ABR', 'MAI', 'JUN', 'JUL', 'AGO', 'SET', 'OUT', 'NOV', 'DEZ'];
    String monthName = value >= 0 && value < 12 ? meses[value.toInt()] : '';
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(monthName, style: style),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.blue,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.cyan,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 20,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color.fromARGB(255, 255, 255, 255)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 20,
      lineBarsData: [
        LineChartBarData(
          spots: widget.aniversariosPorMes.entries
            .map((entry) => FlSpot(entry.key.toDouble(), entry.value.toDouble()))
            .toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
            ),
          ),
        ),
      ],
    );
  }

}
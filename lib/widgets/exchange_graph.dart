import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../models/exchange_rate_data.dart';

class ExchangeGraph extends StatelessWidget {
  final List<ExchangeRateData> historicalRatesList;

  const ExchangeGraph({required this.historicalRatesList, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(left: 20),
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              tooltipRoundedRadius: 8,
              getTooltipItems: (List<LineBarSpot> touchedSpots) {
                return touchedSpots.map((spot) {
                  return LineTooltipItem(
                    "${spot.y.toStringAsFixed(6)}\n${DateFormat('MMM dd, yyyy').format(historicalRatesList[spot.x.toInt()].date)}",
                    const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  );
                }).toList();
              },
            ),
            getTouchedSpotIndicator: (barData, indicators) =>
                indicators.map((index) => TouchedSpotIndicatorData(
                      FlLine(color: Colors.grey.shade400, strokeWidth: 1.5),
                      FlDotData(show: false),
                    )).toList(),
          ),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 20,
                interval: (historicalRatesList.length / 6).roundToDouble(),
                getTitlesWidget: (value, meta) {
                  int index = value.toInt();
                  if (index >= 0 && index < historicalRatesList.length) {
                    return Padding(
                      padding: EdgeInsets.only(top: 7),
                      child: Transform.rotate(
                        angle: -0.15,
                        child: Text(
                          DateFormat('MMM yyyy').format(historicalRatesList[index].date),
                          style: TextStyle(fontSize: 9, color: Colors.grey.shade600),
                        ),
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) => Text(
                  value.toStringAsFixed(1),
                  style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSecondary),
                ),
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: historicalRatesList
                  .asMap()
                  .entries
                  .map((e) => FlSpot(e.key.toDouble(), e.value.rate))
                  .toList(),
              isCurved: true,
              color: Colors.blue.shade700,
              barWidth: 2,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(show: false),
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}

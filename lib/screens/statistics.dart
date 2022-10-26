import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

const Mainbrown = const Color.fromRGBO(137, 115, 88, 1);
const Mainbeige = const Color.fromRGBO(255, 240, 199, 1);

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mainbeige,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background6.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(157, 109, 92, 0.5),
                ),
                alignment: Alignment(0, -0.93),
                width: 390,
                height: 380,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Mainbeige,
                      ),
                      width: 220,
                      height: 45,
                      alignment: Alignment.topCenter,
                      child: const Text(
                        'إحصائيات الجمال',
                        style: TextStyle(
                          fontSize: 28,
                          fontFamily: 'DINNextLTArabic',
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    //creat a pie chart and assigne its values
                    SfCircularChart(
                      legend: Legend(
                        isVisible: true,
                        overflowMode: LegendItemOverflowMode.wrap,
                        position: LegendPosition.bottom,
                        textStyle: TextStyle(
                            fontFamily: 'DINNextLTArabic',
                            fontWeight: FontWeight.w700,
                            fontSize: 15),
                      ),
                      tooltipBehavior: _tooltipBehavior,
                      series: <CircularSeries>[
                        DoughnutSeries<GDPData, String>(
                          dataSource: _chartData,
                          pointColorMapper: (GDPData data, _) => data.color,
                          xValueMapper: (GDPData data, _) => data.name,
                          yValueMapper: (GDPData data, _) => data.value,
                          dataLabelMapper: (GDPData data, _) => data.percent,
                          dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                          ),
                          enableTooltip: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //get and assigne data for the pie chart
  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData('المجاهيم', 35, '35%', Colors.blue),
      GDPData('الوضح', 25, '25%', Colors.red),
      GDPData('الشقح', 15, '15%', Colors.green),
      GDPData('الحمر', 10, '10%', Colors.yellow),
      GDPData('الصفر', 5, '5%', Colors.purple),
      GDPData('الشعل', 10, '10%', Colors.orange),
    ];
    return chartData;
  }
}

class GDPData {
  GDPData(this.name, this.value, this.percent, this.color);
  final String name;
  final int value;
  final Color color;
  final String percent;
}

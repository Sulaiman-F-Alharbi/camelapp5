import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:camelapp/services/SQLiteDB.dart';
import 'package:http/http.dart' as http;
import "dart:convert";

// const Mainbrown = const Color.fromRGBO(137, 115, 88, 1);
const Mainbrown = const Color.fromRGBO(152, 78, 51, 1);
const Mainbeige = const Color.fromRGBO(255, 240, 199, 1);

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  int AlhumrNum = -1;
  int AlshaqhNum = -1;
  int AlshuelNum = -1;
  int AlsifrNum = -1;
  int AlwadahNum = -1;
  int MijaheemNum = -1;

  int Total = 0;

  late bool doneCalling;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    // await getTotal("Mjaheem");
    // _chartData = getChartData();
    // SQLiteDB().getTotal("Alhumr");
    // SQLiteDB().getTotal("Alshaqh");
    // SQLiteDB().getTotal("Alshuel");
    // SQLiteDB().getTotal("Alsifr");
    // SQLiteDB().getTotal("Alwadah");
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
              ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromRGBO(157, 109, 92, 0.7),
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
                            color: Colors.white.withOpacity(0.5),
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
                        FutureBuilder<dynamic>(
                            future: waitForUs(),
                            builder: (context, snapshot) {
                              if (doneCalling) {
                                return SfCircularChart(
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
                                      pointColorMapper: (GDPData data, _) =>
                                          data.color,
                                      xValueMapper: (GDPData data, _) =>
                                          data.name,
                                      yValueMapper: (GDPData data, _) =>
                                          data.value,
                                      dataLabelMapper: (GDPData data, _) =>
                                          data.percent,
                                      dataLabelSettings: DataLabelSettings(
                                        isVisible: true,
                                      ),
                                      enableTooltip: true,
                                    ),
                                  ],
                                );
                              } else {
                                return Column(
                                  children: [
                                    SizedBox(height: 50),
                                    CircularProgressIndicator(),
                                  ],
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future waitForUs() async {
    Total = 0;
    doneCalling = false;
    await getTotal('Alhumr');
    await getTotal('Alshaqh');
    await getTotal('Alshuel');
    await getTotal('Alsifr');
    await getTotal('Alwadah');
    await getTotal('Mijaheem');

    print("Alhumr: " + AlhumrNum.toString());
    print("Alshaqh: " + AlshaqhNum.toString());
    print("Alshuel: " + AlshuelNum.toString());
    print("Alsifr: " + AlsifrNum.toString());
    print("Alwadah: " + AlwadahNum.toString());
    print("Mijaheem: " + MijaheemNum.toString());
    print("Total: " + Total.toString());

    _chartData = await getChartData();
    doneCalling = true;
  }

  //get and assigne data for the pie chart
  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData('المجاهيم', MijaheemNum, getPercent(MijaheemNum), Colors.blue),
      GDPData('الوضح', AlwadahNum, getPercent(AlwadahNum), Colors.purple),
      GDPData('الشقح', AlshaqhNum, getPercent(AlshaqhNum), Colors.green),
      GDPData('الحمر', AlhumrNum, getPercent(AlhumrNum), Colors.red),
      GDPData('الصفر', AlsifrNum, getPercent(AlsifrNum), Colors.yellow),
      GDPData('الشعل', AlshuelNum, getPercent(AlshuelNum), Colors.orange),
    ];
    return chartData;
  }

  Future getTotal(String breed) async {
    var url = 'http://ec2-44-201-201-139.compute-1.amazonaws.com/get' +
        breed +
        '.php';
    http.Response response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body);

    if (breed == "Alhumr") {
      AlhumrNum = data;
    } else if (breed == "Alshaqh") {
      AlshaqhNum = data;
    } else if (breed == "Alshuel") {
      AlshuelNum = data;
    } else if (breed == "Alsifr") {
      AlsifrNum = data;
    } else if (breed == "Alwadah") {
      AlwadahNum = data;
    } else if (breed == "Mijaheem") {
      MijaheemNum = data;
    }
    Total = (Total + data) as int;
    return data;
  }

  getPercent(int num) {
    double percent = (num / Total) * 100;
    return percent.toInt().toString() + "%";
  }
}

class GDPData {
  GDPData(this.name, this.value, this.percent, this.color);
  final String name;
  final int value;
  final Color color;
  final String percent;
}

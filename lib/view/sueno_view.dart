import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';





class Sueno extends StatefulWidget {
  static String routeName = 'sueno';
  // ignore: prefer_const_constructors_in_immutables
  Sueno({Key? key}) : super(key: key);

  @override
  _SuenoState createState() => _SuenoState();
}

class _SuenoState extends State<Sueno> {
  late List<_ChartData> data;
  // late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _ChartData('sueñotranscurrido', 10),
      _ChartData('totalSueño', 100),
      
    ];
    
    // _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter chart'),
        ),
        body: Column(
          children: [
            SfCircularChart(
              
                // tooltipBehavior: _tooltip,
                series: <CircularSeries<_ChartData, String>>[
                  DoughnutSeries<_ChartData, String>(
                      dataSource: data,
                      xValueMapper: (_ChartData data, _) => data.x,
                      yValueMapper: (_ChartData data, _) => data.y,
                      )
                ]),
          ],
        ));
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
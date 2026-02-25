import 'dart:math';
import 'package:flutter/material.dart';
import 'package:money_tracker/data/operation.dart';
import 'package:money_tracker/views/pages/creator_op_page.dart';
import 'package:pie_chart/pie_chart.dart';

enum TermChange {
  day,
  week,
  month
}

List<Map<String, Object?>> filteredOpsByTerm(List<Map<String, Object?>> ops, TermChange term) {
  DateTime now = DateTime.now();
  List<Map<String, Object?>> filteredOps = [];
  switch (term) {
    case TermChange.day:
      ops.forEach((op) {
        if (DateTime.parse(op['date'].toString()).day == now.day) {
          filteredOps.add(op);
        }
      });
    case TermChange.week:
      ops.forEach((op) {
        if (now.difference(DateTime.parse(op['date'].toString())) <= Duration(days: 6)) {
          filteredOps.add(op);
        }
      });
    case TermChange.month:
      ops.forEach((op) {
        if (now.difference(DateTime.parse(op['date'].toString())) <= Duration(days: 29)) {
          filteredOps.add(op);
        }
      });
  }
  return filteredOps;
}

Map<String, double> getCountOfCategories(List<Map<String, Object?>> ops, String type) {
  Map<String, double> countOfCategories = {};

  for (var item in ops) {
    var category = item['category']?.toString();
    var typ = item['type']?.toString();
    var count = double.tryParse(item['count']?.toString() ?? '') ?? 0.0;

    if (category != null && typ == type) {
      countOfCategories.update(
        category,
        (value) => value + count,
        ifAbsent: () => count,
      );
    }
  }

  return countOfCategories;
}

Map<String, double> getShares(Map<String, double> countOfCategories) {
  double sum = 0;

  countOfCategories.forEach((key, value) => sum += value);

  Map<String, double> shares = {};

  countOfCategories.forEach((key, value) {
    shares[key] = (value / sum) * 100;
  });

  return shares;
}

double totalSum(Map<String, double> count) {
  double sum = 0;
  count.forEach((a, b) => sum += b);
  return sum;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  late List<Map<String, Object?>> ops;
  late List<Map<String, Object?>> filteredOps;
  late Map<String, double> countOfSpends;
  late Map<String, double> countOfIncomes;
  late Map<String, double> sharesOfSpends;
  late Map<String, double> sharesOfIncomes;
  late List<Color> colorListIncome;
  late List<Color> colorListSpend;

  late TabController _termTabs;
  TermChange term = TermChange.day;
  
  @override
  void initState() {
    super.initState();
    _termTabs = TabController(length: 3, vsync: this);

    _termTabs.addListener(() {
      if (!_termTabs.indexIsChanging) {
        switch(_termTabs.index) {
          case 0:
            setState(() {
              term = TermChange.day;
              _load();
            });
          case 1:
            setState(() {
              term = TermChange.week;
              _load();
            });
          case 2:
            setState(() {
              term = TermChange.month;
              _load();
            });
        }
      }
    });

    ops = [];
    countOfSpends = {};
    countOfIncomes = {};
    sharesOfSpends = {};
    sharesOfIncomes = {};
    colorListIncome = [];
    colorListSpend = [];
    _load();
  }

  void _load() async{
    ops = await getOperationsToMaps();
    filteredOps = filteredOpsByTerm(ops, term);
    
    setState(() {
      countOfSpends = getCountOfCategories(filteredOps, 'spend');
      countOfIncomes = getCountOfCategories(filteredOps, 'income');
      sharesOfSpends = getShares(countOfSpends);
      sharesOfIncomes = getShares(countOfIncomes);

      colorListIncome = List.generate(sharesOfIncomes.length,
        (index) => index % 2 == 0 ? Color.fromARGB(255, Random().nextInt(120), 180 + Random().nextInt(76), Random().nextInt(120)) : Color.fromARGB(255, Random().nextInt(120), 100 + Random().nextInt(76), Random().nextInt(120))
      );
      colorListSpend = List.generate(sharesOfSpends.length,
        (index) => index % 2 == 0 ? Color.fromARGB(255,  180 + Random().nextInt(76), Random().nextInt(120), Random().nextInt(120)) : Color.fromARGB(255,  120 + Random().nextInt(40), Random().nextInt(30), Random().nextInt(100))
      );
    });
    
  }

  

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TabBar(
                
                tabs: [
                  Tab(text: 'Spends',),
                  Tab(text: 'Incomes',),
                ],
                
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    
                    Column(
                      children: [
                        TabBar(
                          controller: _termTabs,
                          tabs: [
                            Tab(text: 'Day',),
                            Tab(text: 'Week',),
                            Tab(text: 'Month',),
                          ] 
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsetsGeometry.only(top: 24),
                                child: Text(
                                  'Total sum',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purpleAccent
                                  ),
                                )
                              ),
                              Padding(
                                padding: EdgeInsetsGeometry.only(top: 8),
                                child: Text(
                                  '${totalSum(countOfSpends)} rub.',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 80),
                                child: PieChart(
                                  
                                  dataMap: sharesOfSpends.isEmpty ? {'No spends': 1} : sharesOfSpends,
                                  colorList: sharesOfSpends.isEmpty ? [Colors.grey] : colorListSpend,
                                  chartRadius: MediaQuery.of(context).size.width / 2,
                                  centerText: '',
                                  ringStrokeWidth: 24,
                                  animationDuration: sharesOfSpends.isEmpty ? const Duration(milliseconds: 0) : const Duration(milliseconds: 700),
                                      
                                  chartValuesOptions: ChartValuesOptions(
                                    showChartValues: sharesOfSpends.isEmpty ? false : true,
                                    showChartValuesOutside: false,
                                    showChartValuesInPercentage: true,
                                    showChartValueBackground: false
                                  ),
                                              
                                  legendOptions: const LegendOptions(
                                    showLegends: true,
                                    legendShape: BoxShape.circle,
                                    legendTextStyle: TextStyle(fontSize: 15),
                                    legendPosition: LegendPosition.bottom,
                                    showLegendsInRow: true
                                  ),
                                  gradientList: [],
                                ),
                              ),
                            ],
                          )
                        ),
                        
                      ],
                    ),
                    
                    Column(
                      children: [
                        TabBar(
                          controller: _termTabs,
                          tabs: [
                            Tab(text: 'Day',),
                            Tab(text: 'Week',),
                            Tab(text: 'Month',),
                          ] 
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsetsGeometry.only(top: 24),
                                child: Text(
                                  'Total sum',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purpleAccent
                                  ),
                                )
                              ),
                              Padding(
                                padding: EdgeInsetsGeometry.only(top: 8),
                                child: Text(
                                  '${totalSum(countOfIncomes)} rub.',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 80),
                                child: PieChart(
                                  dataMap: sharesOfIncomes.isEmpty ? {'No incomes': 1} : sharesOfIncomes,
                                  colorList: sharesOfIncomes.isEmpty ? [Colors.grey] : colorListIncome,
                                  chartRadius: MediaQuery.of(context).size.width / 2,
                                  centerText: '',
                                  ringStrokeWidth: 24,
                                  animationDuration: sharesOfIncomes.isEmpty ? const Duration(milliseconds: 0) : const Duration(milliseconds: 700),
                                      
                                  chartValuesOptions: ChartValuesOptions(
                                    showChartValues: sharesOfIncomes.isEmpty ? false : true,
                                    showChartValuesOutside: false,
                                    showChartValuesInPercentage: true,
                                    showChartValueBackground: false
                                  ),
                                              
                                  legendOptions: const LegendOptions(
                                    showLegends: true,
                                    legendShape: BoxShape.circle,
                                    legendTextStyle: TextStyle(fontSize: 15),
                                    legendPosition: LegendPosition.bottom,
                                    showLegendsInRow: true
                                  ),
                                  gradientList: [],
                                ),
                              ),
                            ],
                          )
                        ),
                        
                      ],
                    ),
                    
                  ]
                ),
              ),
              
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => CreatorOpPage()
                    ),
                  ),
                  child: Icon(Icons.add),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.purpleAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
                    iconColor: Colors.white,
                    iconSize: 35,
                    fixedSize: Size(60, 60),
                  ),
                ),
              ),
            ],
          ),
          
        ),
      ),
      
    );
  }
}

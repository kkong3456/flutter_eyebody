import 'package:eyebody/data/data.dart';
import 'package:eyebody/view/body.dart';
import 'package:eyebody/view/utils.dart';
import 'package:eyebody/view/workout.dart';
import 'package:flutter/material.dart';

import 'view/food.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'EyeBody'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              backgroundColor: Colors.white,
              builder: (ctx) {
                return SizedBox(
                    height: 200,
                    child: Column(
                      children: [
                        TextButton(
                            child: const Text("식단"),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => FoodAddPage(
                                          food: Food(
                                        date:
                                            Utils.getFormatTime(DateTime.now()),
                                        kcal: 0,
                                        memo: "",
                                        type: 0,
                                        image: "",
                                      ))));
                            }),
                        TextButton(
                          child: const Text("운동"),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => WorkoutAddPage(
                                      workout: Workout(
                                        date:
                                            Utils.getFormatTime(DateTime.now()),
                                        time: 0,
                                        memo: "",
                                        name: "",
                                        image: "",
                                      ),
                                    )));
                          },
                        ),
                        TextButton(
                          child: const Text("눈바디"),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => EyeBodyAddPage(
                                eyeBody: EyeBody(
                                  date: Utils.getFormatTime(DateTime.now()),
                                  weight: 0,
                                  image: "",
                                ),
                              ),
                            ));
                          },
                        ),
                      ],
                    ));
              });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

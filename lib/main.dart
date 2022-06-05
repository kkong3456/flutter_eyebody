import 'package:eyebody/data/data.dart';
import 'package:eyebody/data/database.dart';
import 'package:eyebody/view/body.dart';
import 'package:eyebody/view/utils.dart';
import 'package:eyebody/view/workout.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:table_calendar/table_calendar.dart';

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
  int currentIndex = 0;

  List<Food> todayFood = [];
  List<Workout> todayWorkout = [];
  List<EyeBody> todayEyeBody = [];

  CalendarController controller = CalendarController();

  final dbHelper = DatabaseHelper.instance;
  DateTime time = DateTime.now();

  void getHistories() async {
    int d = Utils.getFormatTime(time);

    todayFood = await dbHelper.queryFoodByDate(d);
    todayWorkout = await dbHelper.queryWorkoutByDate(d);
    todayEyeBody = await dbHelper.queryEyeBodyByDate(d);

    setState(() {});
  }

  @override
  void initState() {
    getHistories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: getPage(),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, //4개이상 아이템생성시 반드시  타입을 지정해야 함
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "오늘",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: "기록",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "통계"),
            BottomNavigationBarItem(
              icon: Icon(Icons.photo_album_outlined),
              label: "갤러리",
            ),
          ],
          currentIndex: currentIndex,
          onTap: (idx) {
            setState(() {
              currentIndex = idx;
            });
          }),

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
                            onPressed: () async {
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => FoodAddPage(
                                    food: Food(
                                      date: Utils.getFormatTime(time),
                                      kcal: 0,
                                      memo: "",
                                      type: 0,
                                      image: "",
                                    ),
                                  ),
                                ),
                              );
                              getHistories();
                            }),
                        TextButton(
                          child: const Text("운동"),
                          onPressed: () async {
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => WorkoutAddPage(
                                      workout: Workout(
                                        date: Utils.getFormatTime(time),
                                        time: 0,
                                        memo: "",
                                        name: "",
                                        image: "",
                                      ),
                                    )));
                            getHistories();
                          },
                        ),
                        TextButton(
                          child: const Text("눈바디"),
                          onPressed: () async {
                            await Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => EyeBodyAddPage(
                                eyeBody: EyeBody(
                                  date: Utils.getFormatTime(time),
                                  weight: 0,
                                  image: "",
                                ),
                              ),
                            ));
                            getHistories();
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

  Widget getPage() {
    if (currentIndex == 0) {
      return getMainPage();
    } else if (currentIndex == 1) {
      return getHistoryPage();
    } else if (currentIndex == 2) {
      return getChartPage();
    } else if (currentIndex == 3) {
      return getGalleryPage();
    }
    return Container();
  }

  Widget getMainPage() {
    return Container(
        child: Column(
      children: [
        Container(
            height: 140,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(todayFood.length, (idx) {
                return Container(
                  width: 140,
                  child: FoodCard(food: todayFood[idx]),
                );
              }),
            )),
        Container(
            height: 140,
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(todayWorkout.length, (idx) {
                  return Container(
                    width: 140,
                    child: WorkoutCard(workout: todayWorkout[idx]),
                  );
                }))),
        Container(
            height: 140,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(todayEyeBody.length, (idx) {
                return Container(
                  width: 140,
                  child: EyeBodyCard(eyeBody: todayEyeBody[idx]),
                );
              }),
            ))
      ],
    ));
  }

  Widget getHistoryPage() {
    return Container(
        child: ListView(
      children: [
        TableCalendar(
            calendarController: controller,
            onDaySelected: (date, events, holidays) {
              time = date;
              getHistories();
            }),
        getMainPage(),
      ],
    ));
  }

  Widget getChartPage() {
    return Container();
  }

  Widget getGalleryPage() {
    return Container();
  }
}

class FoodCard extends StatelessWidget {
  final Food food;

  FoodCard({Key key, this.food}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.all(8),
      child: ClipRRect(
        child: Stack(
          children: [
            Positioned.fill(
              child: AssetThumb(
                  asset: Asset(food.image, "food.png", 0, 0),
                  width: 300,
                  height: 300),
            ),
            Positioned.fill(
              child: Container(color: Colors.black38),
            ),
            Container(
                alignment: Alignment.center,
                child: Text(
                  "${['아침', '점심', '저녁', '간식'][food.type]}",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class WorkoutCard extends StatelessWidget {
  final Workout workout;
  WorkoutCard({Key key, this.workout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.all(8),
      child: ClipRRect(
        child: Stack(
          children: [
            Positioned.fill(
              child: AssetThumb(
                  asset: Asset(workout.image, "food.png", 0, 0),
                  width: 300,
                  height: 300),
            ),
            Positioned.fill(
              child: Container(color: Colors.black38),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "${workout.name}",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class EyeBodyCard extends StatelessWidget {
  final EyeBody eyeBody;
  EyeBodyCard({Key key, this.eyeBody}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.all(8),
      child: ClipRRect(
        child: Stack(
          children: [
            Positioned.fill(
              child: AssetThumb(
                  asset: Asset(eyeBody.image, "food.png", 0, 0),
                  width: 300,
                  height: 300),
            ),
            Positioned.fill(
              child: Container(color: Colors.black38),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "${eyeBody.weight}kg",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

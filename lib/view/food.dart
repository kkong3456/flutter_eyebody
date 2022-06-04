import 'package:eyebody/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FoodAddPage extends StatefulWidget {
  final Food food;
  const FoodAddPage({Key key, this.food}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FoodAddPageState();
  }
}

class _FoodAddPageState extends State<FoodAddPage> {
  TextEditingController kcalController = TextEditingController();
  TextEditingController memoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              child: const Text("저장"),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
            child: ListView.builder(
          itemBuilder: (ctx, idx) {
            if (idx == 0) {
              return Container(
                child: Text("오늘 어떤 음식을 드셔싸요?"),
              );
            } else if (idx == 1) {
              return Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("칼로리"),
                  Container(
                    width: 100,
                    child: TextField(
                      controller: kcalController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ));
            } else if (idx == 2) {
              return Container(
                child: Container(),
              );
            }
            return Container();
          },
          itemCount: 5,
        )));
  }
}

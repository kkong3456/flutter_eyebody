import 'package:eyebody/data/data.dart';
import 'package:eyebody/data/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

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

  Food get food => widget.food;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              child: const Text(
                "저장",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                food.memo = memoController.text;
                food.kcal = int.tryParse(kcalController.text) ?? 0;

                final dbHelper = DatabaseHelper.instance;
                await dbHelper.insertFood(food);

                Navigator.of(context).pop();
              },
            )
          ],
        ),
        body: Container(
            child: ListView.builder(
          itemBuilder: (ctx, idx) {
            if (idx == 0) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Text("오늘 어떤 음식을 드셨어요?", style: TextStyle(fontSize: 20)),
              );
            } else if (idx == 1) {
              return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("칼로리",
                          style: TextStyle(
                            fontSize: 16,
                          )),
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
                // color: Colors.black26,
                // padding:
                // const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: InkWell(
                        child: AspectRatio(
                            child: food.image.isEmpty
                                ? Image.asset("assets/img/rice.png")
                                : AssetThumb(
                                    asset: Asset(food.image, "food.png", 0, 0),
                                    width: 200,
                                    height: 200),
                            aspectRatio: 1 / 1),
                        onTap: () {
                          selectImage();
                        }),
                  ),
                ),
              );
            } else if (idx == 3) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: CupertinoSegmentedControl(
                  children: {
                    0: Text("아침"),
                    1: Text("점심"),
                    2: Text("저녁"),
                    3: Text("간식"),
                  },
                  onValueChanged: (idx) {
                    setState(() {
                      food.type = idx;
                      print(idx);
                    });
                  },
                  groupValue: food.type,
                ),
              );
            } else if (idx == 4) {
              return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("메모",
                          style: TextStyle(
                            fontSize: 16,
                          )),
                      SizedBox(height: 5),
                      TextField(
                          maxLines: 10,
                          minLines: 10,
                          keyboardType: TextInputType.multiline,
                          controller: memoController,
                          decoration:
                              InputDecoration(border: OutlineInputBorder()))
                    ],
                  ));
            }
            return Container();
          },
          itemCount: 5,
        )));
  }

  Future<void> selectImage() async {
    final __img =
        await MultiImagePicker.pickImages(maxImages: 1, enableCamera: true);
    if (__img.length < 1) {
      return;
    }
    setState(() {
      food.image = __img.first.identifier;
    });
  }
}

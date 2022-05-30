class Food {
  int id;
  int date;
  int type;
  int kcal;
  String image;
  String memo;

  Food({this.id, this.date, this.type, this.kcal, this.image, this.memo});

  factory Food.fromDB(Map<String, dynamic> data) {
    return Food(
      id: data["id"],
      date: data["date"],
      type: data["type"],
      kcal: data["kcal"],
      image: data["image"],
      memo: data["memo"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "date": this.date,
      "type": type,
      "kcal": kcal,
      "image": image,
      "memo": memo,
    };
  }
}

class Workout {
  int id;
  int date;
  int time; //운동시간
  String image;
  String name;
  String memo;

  Workout({this.id, this.date, this.time, this.image, this.name, this.memo});

  factory Workout.fromDB(Map<String, dynamic> data) {
    return Workout(
      id: data["id"],
      date: data["date"],
      time: data["time"],
      image: data["image"],
      name: data["name"],
      memo: data["memo"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "date": this.date,
      "time": time,
      "image": image,
      "name": this.name,
      "memo": memo,
    };
  }
}

class EyeBody {
  int id;
  int date;
  int weight;
  String image;

  EyeBody({this.id, this.date, this.weight, this.image});

  factory EyeBody.fromDB(Map<String, dynamic> data) {
    return EyeBody(
      id: data["id"],
      date: data["date"],
      weight: data["weight"],
      image: data["image"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "date": date,
      "weight": weight,
      "image": image,
    };
  }
}

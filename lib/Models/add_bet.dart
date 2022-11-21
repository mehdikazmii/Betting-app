class AddBet {
  String uid = '';
  String privacy = '';
  String def = '';
  String option1 = '';
  String option2 = '';
  String option3 = '';
  String comment = '';
  String name = '';
  DateTime? dateTime;
  String multiplier = '';
  String totalBet = '';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'privacy': privacy,
      'def': def,
      'option1': option1,
      'option2': option2,
      'option3': option3,
      'comment': comment,
      'dateTime': dateTime,
      'name': name,
      'multiplier': multiplier,
      'totalBet': totalBet,
      "publishTime": DateTime.now()
    };
  }
}

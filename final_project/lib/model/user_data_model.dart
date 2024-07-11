class LoginModel {
  dynamic userId;
  dynamic userName;
  dynamic age;
  dynamic email;
  dynamic phone;
  dynamic sex;
  dynamic weight;
  dynamic ethnicity;
  dynamic bodyType;
  dynamic bodyGoal;
  dynamic bloodPressure;
  dynamic bloodSugar;
  dynamic isPremium;

  LoginModel(
      {this.userId,
      this.userName,
      this.age,
      this.email,
      this.phone,
      this.sex,
      this.weight,
      this.ethnicity,
      this.bodyType,
      this.bodyGoal,
      this.bloodPressure,
      this.bloodSugar,
      this.isPremium});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      userId: json['user_id'],
      userName: json['name'],
      age: json['age'],
      email: json['email'],
      phone: json['phone'],
      sex: json['sex'],
      weight: json['weight'],
      ethnicity: json['ethnicity'], 
      bodyType: json['bodyType'],
      bodyGoal: json['bodyGoal'],
      bloodPressure: json['bloodPressure'],
      bloodSugar: json['bloodSugar'],
      isPremium: json['isPremium'],
    );
  }
}

import 'dart:io';

void main() {
  String? val;
  double sum = 0;
  print('CS, Programming, Physics, Math, English, social');
  for (int i = 0; i < 6; i++) {
    val = stdin.readLineSync()!;
    sum += (calc(val)! * (i >= 4 ? 2.0 : 3.0));
  }
  print(sum / 16.0);
}

double? calc(String val) {
  const Map<String, double> grade = {
    'A+': 4.0,
    'A': 3.7,
    'B+': 3.3,
    'B': 3.0,
    'C+': 2.7,
    'C': 2.4,
    'D+': 2.2,
    'D': 2.0,
    'F': 0.0,
  };
  return grade[val];
}

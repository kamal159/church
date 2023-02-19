import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class SchoolGrade extends Equatable {
  final int levelCount;
  final String arNameGrade;
  final String enNameGrade;
  bool isExpanded;

  SchoolGrade({
    required this.levelCount,
    required this.arNameGrade,
    required this.enNameGrade,
    this.isExpanded = false,
  });

  SchoolGrade copyWith({
    int? levelCount,
    String? arNameGrade,
    String? enNameGrade,
    bool? isExpanded,
  }) =>
      SchoolGrade(
        levelCount: levelCount ?? this.levelCount,
        arNameGrade: arNameGrade ?? this.arNameGrade,
        enNameGrade: enNameGrade ?? this.enNameGrade,
        isExpanded: isExpanded ?? this.isExpanded,
      );

  @override
  List<Object?> get props => [
        levelCount,
        arNameGrade,
        enNameGrade,
        isExpanded,
      ];
}

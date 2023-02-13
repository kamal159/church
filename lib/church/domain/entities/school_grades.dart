import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class SchoolGrade extends Equatable {
  final int levelCount;
  final String nameGrade;
  bool isExpanded;

  SchoolGrade({
    required this.levelCount,
    required this.nameGrade,
    this.isExpanded = false,
  });

  SchoolGrade copyWith({
    int? levelCount,
    String? nameGrade,
    bool? isExpanded,
  }) =>
      SchoolGrade(
        levelCount: levelCount ?? this.levelCount,
        nameGrade: nameGrade ?? this.nameGrade,
        isExpanded: isExpanded ?? this.isExpanded,
      );

  @override
  List<Object?> get props => [
        levelCount,
        nameGrade,
        isExpanded,
      ];
}

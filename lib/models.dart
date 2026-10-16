import 'package:hive/hive.dart';

part 'models.g.dart';

@HiveType(typeId: 0)
class VocabGroup extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<Word> words;

  @HiveField(3)
  DateTime createdAt;

  VocabGroup({
    required this.id,
    required this.name,
    required this.words,
    required this.createdAt,
  });
}

@HiveType(typeId: 1)
class Word extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String english;

  @HiveField(2)
  List<String> partOfSpeech;

  @HiveField(3)
  String chineseMeaning;

  @HiveField(4)
  int wrongCount;

  @HiveField(5)
  DateTime createdAt;

  Word({
    required this.id,
    required this.english,
    required this.partOfSpeech,
    required this.chineseMeaning,
    this.wrongCount = 0,
    required this.createdAt,
  });
}

@HiveType(typeId: 2)
class ErrorRecord extends HiveObject {
  @HiveField(0)
  String wordId;

  @HiveField(1)
  String groupId;

  @HiveField(2)
  String english;

  @HiveField(3)
  String correctAnswer;

  @HiveField(4)
  String userAnswer;

  @HiveField(5)
  DateTime wrongAt;

  ErrorRecord({
    required this.wordId,
    required this.groupId,
    required this.english,
    required this.correctAnswer,
    required this.userAnswer,
    required this.wrongAt,
  });
}

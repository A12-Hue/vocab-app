// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VocabGroupAdapter extends TypeAdapter<VocabGroup> {
  @override
  final int typeId = 0;

  @override
  VocabGroup read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VocabGroup(
      id: fields[0] as String,
      name: fields[1] as String,
      words: (fields[2] as List).cast<Word>(),
      createdAt: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, VocabGroup obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.words)
      ..writeByte(3)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VocabGroupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WordAdapter extends TypeAdapter<Word> {
  @override
  final int typeId = 1;

  @override
  Word read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Word(
      id: fields[0] as String,
      english: fields[1] as String,
      partOfSpeech: (fields[2] as List).cast<String>(),
      chineseMeaning: fields[3] as String,
      wrongCount: fields[4] as int,
      createdAt: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Word obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.english)
      ..writeByte(2)
      ..write(obj.partOfSpeech)
      ..writeByte(3)
      ..write(obj.chineseMeaning)
      ..writeByte(4)
      ..write(obj.wrongCount)
      ..writeByte(5)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ErrorRecordAdapter extends TypeAdapter<ErrorRecord> {
  @override
  final int typeId = 2;

  @override
  ErrorRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ErrorRecord(
      wordId: fields[0] as String,
      groupId: fields[1] as String,
      english: fields[2] as String,
      correctAnswer: fields[3] as String,
      userAnswer: fields[4] as String,
      wrongAt: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ErrorRecord obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.wordId)
      ..writeByte(1)
      ..write(obj.groupId)
      ..writeByte(2)
      ..write(obj.english)
      ..writeByte(3)
      ..write(obj.correctAnswer)
      ..writeByte(4)
      ..write(obj.userAnswer)
      ..writeByte(5)
      ..write(obj.wrongAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ErrorRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

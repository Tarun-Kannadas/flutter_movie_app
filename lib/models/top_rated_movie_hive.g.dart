// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_rated_movie_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TopRatedMovieHiveAdapter extends TypeAdapter<TopRatedMovieHive> {
  @override
  final int typeId = 0;

  @override
  TopRatedMovieHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TopRatedMovieHive(
      title: fields[0] as String,
      year: fields[1] as String,
      image: fields[2] as String,
      imdbRating: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TopRatedMovieHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.year)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.imdbRating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopRatedMovieHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

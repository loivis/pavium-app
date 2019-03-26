// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Favorite _$FavoriteFromJson(Map<String, dynamic> json) {
  return Favorite(
      json['author'] as String,
      json['id'] as String,
      json['image'] as String,
      json['site'] as String,
      json['title'] as String,
      json['update'] as String ?? '2018-02-03')
    ..progress = json['progress'] as int;
}

Map<String, dynamic> _$FavoriteToJson(Favorite instance) => <String, dynamic>{
      'author': instance.author,
      'id': instance.id,
      'image': instance.image,
      'site': instance.site,
      'title': instance.title,
      'progress': instance.progress,
      'update': instance.update
    };

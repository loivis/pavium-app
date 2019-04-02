// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chapter _$ChapterFromJson(Map<String, dynamic> json) {
  return Chapter(
      json['title'] as String, json['link'] as String, json['text'] as String);
}

Map<String, dynamic> _$ChapterToJson(Chapter instance) => <String, dynamic>{
      'title': instance.title,
      'link': instance.link,
      'text': instance.text
    };

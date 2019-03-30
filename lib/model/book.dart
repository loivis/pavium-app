import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

@JsonSerializable()
class Book {
  final String author, id, image, link, site, title;

  String get key => this.site + this.id;

  Book(
    this.author,
    this.id,
    this.image,
    this.link,
    this.site,
    this.title,
  );

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);
}

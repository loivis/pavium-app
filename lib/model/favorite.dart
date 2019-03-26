import 'package:json_annotation/json_annotation.dart';

part 'favorite.g.dart';

@JsonSerializable()
class Favorite {
  final String author, id, image, site, title;

  int progress;

  @JsonKey(defaultValue: '2018-02-03')
  String update;

  String get key => this.site + this.id;

  Favorite(
    this.author,
    this.id,
    this.image,
    this.site,
    this.title,
    this.update,
  );

  factory Favorite.fromJson(Map<String, dynamic> json) =>
      _$FavoriteFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteToJson(this);
}

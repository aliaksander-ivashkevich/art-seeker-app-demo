import 'package:freezed_annotation/freezed_annotation.dart';

part 'art_preview.freezed.dart';
part 'art_preview.g.dart';

@freezed
class ArtPreview with _$ArtPreview {
  const factory ArtPreview({
    required int id,
    required String title,
    @JsonKey(name: 'image_id') required String? imageId,
    @JsonKey(name: 'date_display') required String? date,
    @JsonKey(name: 'artist_display') required String? artist,
    @JsonKey(name: 'place_of_origin') required String? origin,
  }) = _ArtPreview;

  const ArtPreview._();

  factory ArtPreview.fromJson(Map<String, dynamic> json) => _$ArtPreviewFromJson(json);

  String get previewImageUrl => 'https://www.artic.edu/iiif/2/$imageId/full/200,/0/default.jpg';

  String get fullImageUrl => 'https://www.artic.edu/iiif/2/$imageId/full/843,/0/default.jpg';
}

import '../../domain/entities/pin_entity.dart';

class PinModel extends PinEntity {
  const PinModel({
    required super.id,
    required super.title,
    required super.imageUrl,
    required super.imageHeight,
  });

  factory PinModel.fromMap(Map<String, dynamic> map) {
    return PinModel(
      id: map['id'] as String,
      title: map['title'] as String,
      imageUrl: map['imageUrl'] as String,
      imageHeight: (map['imageHeight'] as num).toDouble(),
    );
  }
}

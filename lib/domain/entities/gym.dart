import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'photo.dart';

part 'gym.g.dart';

@JsonSerializable()
class Gym extends Equatable {
  final String id;
  final String address;
  final String title;
  final String description;
  final String workingTime;
  final String phoneNumber;
  final String email;
  final String vkLink;
  @JsonKey(defaultValue: [])
  final List<Photo> photos;
  @JsonKey(defaultValue: false)
  final bool isFavorite;
  const Gym({
    @required this.id,
    @required this.address,
    @required this.title,
    this.description,
    this.workingTime,
    this.phoneNumber,
    this.email,
    this.vkLink,
    this.photos = const [],
    this.isFavorite = false,
  })  : assert(id != null),
        assert(address != null),
        assert(title != null),
        assert(photos != null),
        assert(isFavorite != null);

  factory Gym.fromJson(Map<String, dynamic> json) => _$GymFromJson(json);
  Map<String, dynamic> toJson() => _$GymToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      address,
      title,
      description,
      workingTime,
      phoneNumber,
      email,
      vkLink,
      photos,
      isFavorite
    ];
  }

  Gym copyWith({
    String id,
    String address,
    String title,
    String description,
    String workingTime,
    String phoneNumber,
    String email,
    String vkLink,
    List<Photo> photos,
    bool isFavorite,
  }) {
    return Gym(
      id: id ?? this.id,
      address: address ?? this.address,
      title: title ?? this.title,
      description: description ?? this.description,
      workingTime: workingTime ?? this.workingTime,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      vkLink: vkLink ?? this.vkLink,
      photos: photos ?? this.photos,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  bool get stringify => true;
}

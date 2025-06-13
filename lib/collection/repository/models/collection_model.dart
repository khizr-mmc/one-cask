part of 'models.dart';

class CollectionModel {
    final String? name;
    final int? year;
    final String? number;
    final int? count;
    final int? total;
    final String? image;

    CollectionModel({
        this.name,
        this.year,
        this.number,
        this.count,
        this.total,
        this.image,
    });

    CollectionModel copyWith({
        String? name,
        int? year,
        String? number,
        int? count,
        int? total,
        String? image,
    }) => 
        CollectionModel(
            name: name ?? this.name,
            year: year ?? this.year,
            number: number ?? this.number,
            count: count ?? this.count,
            total: total ?? this.total,
            image: image ?? this.image,
        );

    factory CollectionModel.fromJson(Map<String, dynamic> json) => CollectionModel(
        name: json["name"],
        year: json["year"],
        number: json["number"],
        count: json["count"],
        total: json["total"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "year": year,
        "number": number,
        "count": count,
        "total": total,
        "image": image,
    };
}

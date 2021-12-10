class GeoSearch {
  List<Predictions> predictions;
  String status;

  GeoSearch(this.predictions, this.status);

  factory GeoSearch.fromJson(Map<String, dynamic> json) {
    List<Predictions> predictions = [];
    if (json['predictions'] != null) {
      json['predictions'].forEach((v) {
        predictions.add(new Predictions.fromJson(v));
      });
    }

    return GeoSearch(predictions, json['status']);
  }
}

class Predictions {
  String description;
  String placeId;

  Predictions(this.description, this.placeId);

  factory Predictions.fromJson(Map<String, dynamic> json) {
    return Predictions(json['description'], json['place_id']);
  }
}

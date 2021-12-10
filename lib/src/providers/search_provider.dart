class SearchResultWrapper {
  List<Results> results;
  String status;

  SearchResultWrapper(this.results, this.status);

  factory SearchResultWrapper.fromJson(Map<String, dynamic> json) {
    return SearchResultWrapper(
        List<Results>.from(json["results"]?.map((x) => Results.fromJson(x))),
        json['status']);
  }
}

class Results {
  String formattedAddress;
  Geometry geometry;

  Results(this.formattedAddress, this.geometry);

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
        json['formatted_address'], Geometry.fromJson(json['geometry']));
  }
}

class Geometry {
  LocationDetail location;

  Geometry(this.location);

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(LocationDetail.fromJson(json['location']));
  }
}

class LocationDetail {
  double lat;
  double lng;

  LocationDetail(this.lat, this.lng);

  factory LocationDetail.fromJson(Map<String, dynamic> json) {
    return LocationDetail(json['lat'], json['lng']);
  }
}

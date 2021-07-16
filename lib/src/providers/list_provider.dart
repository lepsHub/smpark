class ObjectPark {
  int id;
  String latitud;
  String longitud;
  String nombre;
  Estado? estado;
  String direccion;
  String foto;
  Tarifa? tarifa;
  Horario? horario;
  List<PuntosInteres> puntosInteres;

  ObjectPark(this.id, this.latitud, this.longitud, this.nombre, this.estado,
      this.direccion, this.foto, this.tarifa, this.horario, this.puntosInteres);

  factory ObjectPark.fromJson(Map<String, dynamic> json) {
    return ObjectPark(
      json['id'],
      json['latitud'],
      json['longitud'],
      json['nombre'],
      json['estado'] != null ? new Estado.fromJson(json['estado']) : null,
      json['direccion'],
      json['foto'],
      json['tarifa'] != null ? new Tarifa.fromJson(json['tarifa']) : null,
      json['horario'] != null ? new Horario.fromJson(json['horario']) : null,
      List<PuntosInteres>.from(
          json["puntosInteres"]?.map((x) => PuntosInteres.fromJson(x)) ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['latitud'] = this.latitud;
    data['longitud'] = this.longitud;
    data['nombre'] = this.nombre;
    if (this.estado != null) {
      data['estado'] = this.estado!.toJson();
    }
    data['direccion'] = this.direccion;
    data['foto'] = this.foto;
    if (this.tarifa != null) {
      data['tarifa'] = this.tarifa!.toJson();
    }
    if (this.horario != null) {
      data['horario'] = this.horario!.toJson();
    }
    data['puntos_interes'] = this.puntosInteres.map((v) => v.toJson()).toList();
    return data;
  }
}

class Estado {
  int total;
  int libres;

  Estado(this.total, this.libres);

  factory Estado.fromJson(Map<String, dynamic> json) => Estado(
        json['total'],
        json['libres'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['libres'] = this.libres;
    return data;
  }
}

class Tarifa {
  int tarifaHora;
  int lavadoAutos;

  Tarifa(this.tarifaHora, this.lavadoAutos);

  factory Tarifa.fromJson(Map<String, dynamic> json) => Tarifa(
        json['tarifa_hora'],
        json['lavado_autos'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tarifa_hora'] = this.tarifaHora;
    data['lavado_autos'] = this.lavadoAutos;
    return data;
  }
}

class Horario {
  String diaSemana;
  String finSemana;

  Horario(this.diaSemana, this.finSemana);

  factory Horario.fromJson(Map<String, dynamic> json) => Horario(
        json['dia_semana'],
        json['fin_semana'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dia_semana'] = this.diaSemana;
    data['fin_semana'] = this.finSemana;
    return data;
  }
}

class PuntosInteres {
  String nombre;
  String url;
  String foto;

  PuntosInteres(this.nombre, this.url, this.foto);

  factory PuntosInteres.fromJson(Map<String, dynamic> json) => PuntosInteres(
        json['nombre'],
        json['url'],
        json['foto'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombre'] = this.nombre;
    data['url'] = this.url;
    data['foto'] = this.foto;
    return data;
  }
}

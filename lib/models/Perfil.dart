import 'package:aqueduct/aqueduct.dart';

class Perfil extends Serializable {
  Perfil({this.id, this.nome, this.idReferencia, this.classe});

  int id;
  String nome;
  int idReferencia;
  String classe;

  @override
  Map<String, dynamic> asMap() =>
      {"id": id, "nome": nome, "idReferencia": idReferencia, "classe": classe};

  @override
  void readFromMap(Map<String, dynamic> map) {
    id = map['id'] as int;
    nome = map['nome'] as String;
    idReferencia = map['idReferencia'] as int;
    classe = map["classe"] as String;
  }
}

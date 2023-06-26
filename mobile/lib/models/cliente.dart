// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Cliente {
  final int id;
  final String nome;
  final int conta;
  final num saldo;
  Cliente({
    required this.id,
    required this.nome,
    required this.conta,
    required this.saldo,
  });

  Cliente copyWith({
    int? id,
    String? nome,
    int? conta,
    String? senha,
    num? saldo,
  }) {
    return Cliente(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      conta: conta ?? this.conta,
      saldo: saldo ?? this.saldo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'conta': conta,
      'saldo': saldo,
    };
  }

  factory Cliente.fromMap(Map<String, dynamic> map) {
    return Cliente(
      id: map['id'] as int,
      nome: map['nome'] as String,
      conta: map['conta'] as int,
      saldo: map['saldo'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cliente.fromJson(String source) =>
      Cliente.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cliente(id: $id, nome: $nome, conta: $conta, saldo: $saldo)';
  }

  @override
  bool operator ==(covariant Cliente other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nome == nome &&
        other.conta == conta &&
        other.saldo == saldo;
  }

  @override
  int get hashCode {
    return id.hashCode ^ nome.hashCode ^ conta.hashCode ^ saldo.hashCode;
  }
}

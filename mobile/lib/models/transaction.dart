// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Transaction {
  final int id;
  final int tipo;
  final int idCliente;
  final String? clienteTransf;
  final num valor;
  final DateTime dtTransacao;
  Transaction({
    required this.id,
    required this.tipo,
    required this.idCliente,
    this.clienteTransf,
    required this.valor,
    required this.dtTransacao,
  });

  Transaction copyWith({
    int? id,
    int? tipo,
    int? idCliente,
    String? clienteTransf,
    num? valor,
    DateTime? dtTransacao,
  }) {
    return Transaction(
      id: id ?? this.id,
      tipo: tipo ?? this.tipo,
      idCliente: idCliente ?? this.idCliente,
      clienteTransf: clienteTransf ?? this.clienteTransf,
      valor: valor ?? this.valor,
      dtTransacao: dtTransacao ?? this.dtTransacao,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'tipo': tipo,
      'idCliente': idCliente,
      'clienteTransf': clienteTransf,
      'valor': valor,
      'dtTransacao': dtTransacao.millisecondsSinceEpoch,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
        id: map['id'] as int,
        tipo: map['tipo'] as int,
        idCliente: map['idCliente'] as int,
        clienteTransf: map['clienteTransf'] != null
            ? map['clienteTransf'] as String
            : null,
        valor: map['valor'] as num,
        dtTransacao: DateTime.parse(map['dtTransacao']));
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Transaction(id: $id, tipo: $tipo, idCliente: $idCliente, clienteTransf: $clienteTransf, valor: $valor, dtTransacao: $dtTransacao)';
  }

  @override
  bool operator ==(covariant Transaction other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.tipo == tipo &&
        other.idCliente == idCliente &&
        other.clienteTransf == clienteTransf &&
        other.valor == valor &&
        other.dtTransacao == dtTransacao;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        tipo.hashCode ^
        idCliente.hashCode ^
        clienteTransf.hashCode ^
        valor.hashCode ^
        dtTransacao.hashCode;
  }
}

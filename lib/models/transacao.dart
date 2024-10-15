class Transacao {
  final int? id;
  final String descricao;
  final double valor;

  Transacao({this.id, required this.descricao, required this.valor});

  factory Transacao.fromJson(Map<String, dynamic> json) {
    return Transacao(
      id: json['id'],
      descricao: json['descricao'],
      valor: json['valor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
      'valor': valor,
    };
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/transacao.dart';
import 'api_service.dart';

class TransacaoService implements ApiService<Transacao> {
  final String apiUrl = 'http://localhost:3000/transacoes';

  @override
  Future<List<Transacao>> getAll() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Transacao.fromJson(data)).toList();
    } else {
      throw Exception('falha em atualizar transações');
    }
  }

  @override
  Future<Transacao> getOne(int id) async {
    final response = await http.get(Uri.parse('$apiUrl/$id'));
    if (response.statusCode == 200) {
      return Transacao.fromJson(json.decode(response.body));
    } else {
      throw Exception('falha em carregar transação');
    }
  }

  @override
  Future<void> create(Transacao transacao) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(transacao.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('falha em criar transação');
    }
  }

  @override
  Future<void> update(int id, Transacao transacao) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(transacao.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('falha em atualizar transação');
    }
  }

  @override
  Future<void> delete(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('falha em deletar transação');
    }
  }
}

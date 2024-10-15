import 'package:flutter/material.dart';
import '../services/transacao_service.dart';
import '../models/transacao.dart';
import 'transacao_form.dart';

class TransacaoList extends StatefulWidget {
  @override
  _TransacaoListState createState() => _TransacaoListState();
}

class _TransacaoListState extends State<TransacaoList> {
  final TransacaoService _transacaoService = TransacaoService();
  late Future<List<Transacao>> _transacoes;

  @override
  void initState() {
    super.initState();
    _transacoes = _transacaoService.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transações'),
      ),
      body: FutureBuilder<List<Transacao>>(
        future: _transacoes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Transacao transacao = snapshot.data![index];
                return ListTile(
                  title: Text(transacao.descricao),
                  subtitle: Text('Valor: ${transacao.valor}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TransacaoForm(transacao: transacao),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _transacaoService.delete(transacao.id!);
                          setState(() {
                            _transacoes = _transacaoService.getAll();
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TransacaoForm()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../services/transacao_service.dart';
import '../models/transacao.dart';

class TransacaoForm extends StatefulWidget {
  final Transacao? transacao;

  TransacaoForm({this.transacao});

  @override
  _TransacaoFormState createState() => _TransacaoFormState();
}

class _TransacaoFormState extends State<TransacaoForm> {
  final _formKey = GlobalKey<FormState>();
  String _descricao = '';
  double _valor = 0;

  final TransacaoService _transacaoService = TransacaoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.transacao == null ? 'Nova Transação' : 'Editar Transação'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.transacao?.descricao ?? '',
                decoration: InputDecoration(labelText: 'Descrição'),
                onSaved: (value) => _descricao = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira uma descrição';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: widget.transacao?.valor.toString() ?? '',
                decoration: InputDecoration(labelText: 'Valor'),
                keyboardType: TextInputType.number,
                onSaved: (value) => _valor = double.parse(value!),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Insira um valor';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    Transacao transacao = Transacao(
                      descricao: _descricao,
                      valor: _valor,
                    );

                    if (widget.transacao == null) {
                      _transacaoService.create(transacao);
                    } else {
                      _transacaoService.update(
                          widget.transacao!.id!, transacao);
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text(widget.transacao == null ? 'Criar' : 'Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

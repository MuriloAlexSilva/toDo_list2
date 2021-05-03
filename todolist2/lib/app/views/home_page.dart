import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _tarefas = [];
  TextEditingController _tarefaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Lista de Tarefas'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 17, top: 1, bottom: 1),
                  child: TextField(
                    controller: _tarefaController,
                    decoration: InputDecoration(labelText: 'Digite a Tarefa'),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    final newTarefa = _tarefaController.text;
                    _tarefas.add(newTarefa);
                    _tarefaController.clear();
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.blueAccent,
                  child: Text(
                    'ADD',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  height: 40,
                  width: 70,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tarefas.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 17, top: 5),
                  child: Text(_tarefas[index]),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  //Coletar dados
  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  //Salvar dados
  Future<File> _saveData() async {
    String data = jsonEncode(_tarefas);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  //Ler dados
  Future<String> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}

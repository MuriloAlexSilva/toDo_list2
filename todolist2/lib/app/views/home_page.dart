import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _readData().then((data) {
      setState(() {
        _tarefas = jsonDecode(data);
      });
    });
  }

  List _tarefas = [];
  TextEditingController _tarefaController = TextEditingController();
  void _addToDo() {
    setState(() {
      Map<String, dynamic> _newToDo = Map();
      _newToDo["title"] = _tarefaController.text;
      _tarefaController.clear();
      _newToDo["ok"] = false;
      _tarefas.add(_newToDo);
      _saveData();
    });
  }

  Map<String, dynamic> _lastRemoved = Map();
  int _lastRemovedPos;
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
                onPressed: _addToDo,
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
              padding: EdgeInsets.only(top: 5),
              itemBuilder: (context, index) {
                return Dismissible(
                    onDismissed: (direction) {
                      setState(() {
                        _lastRemoved = Map.from(_tarefas[index]);
                        _lastRemovedPos = index;
                        _tarefas.removeAt(index);
                        _saveData();
                        final snack = SnackBar(
                          duration: Duration(seconds: 5),
                          content: Text(
                              "Tarefa \"${_lastRemoved["title"]}\" removida!!"),
                          action: SnackBarAction(
                            onPressed: () {
                              setState(() {
                                _tarefas.insert(_lastRemovedPos, _lastRemoved);
                                _saveData();
                              });
                            },
                            label: "Desfazer",
                          ),
                        );
                        Scaffold.of(context).removeCurrentSnackBar();
                        Scaffold.of(context).showSnackBar(snack);
                      });
                    },
                    direction: DismissDirection.startToEnd,
                    key: Key(Random().toString()),
                    background: Container(
                      color: Colors.red,
                      child: Icon(Icons.delete, color: Colors.white),
                      alignment: Alignment(-0.9, 0.0),
                    ),
                    child: CheckboxListTile(
                      onChanged: (c) {
                        setState(() {
                          _tarefas[index]["ok"] = c;
                          _saveData();
                        });
                      },
                      title: Text(_tarefas[index]["title"]),
                      secondary: CircleAvatar(
                        child: Icon(
                            _tarefas[index]["ok"] ? Icons.check : Icons.error),
                      ),
                      value: _tarefas[index]["ok"],
                    ));
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

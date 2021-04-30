import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _newTarefa = [];
  TextEditingController _tarefas = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title: Text('Lista de Tarefas !!'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 1, bottom: 1),
                  child: TextField(
                    controller: _tarefas,
                    decoration:
                        InputDecoration(labelText: 'Escreva sua Tarefa'),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    final tarefa = _tarefas.text;
                    _newTarefa.add(tarefa);
                    _tarefas.clear();
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 70,
                  height: 40,
                  child: Text(
                    "ADD",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _newTarefa.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Text(_newTarefa[index]),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

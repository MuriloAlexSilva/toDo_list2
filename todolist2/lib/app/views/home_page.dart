import 'dart:math';

import 'package:flutter/material.dart';

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
}

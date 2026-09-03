
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends 
StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: 
    TelaInicial()); 
  }
   
}

class TelaInicial extends StatelessWidget{
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text('Caverna Do Dragão',
            style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(onPressed: () {}, child: Text('Entrar')),
          ],
        )
      )
    );
  }
}

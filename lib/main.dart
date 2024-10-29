import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hola Mundo',
        home: RecipeBook());
  }
}

class RecipeBook extends StatelessWidget {
  const RecipeBook({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'Recipe Book',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(width: MediaQuery.of(context).size.width, height: 125, child: Card(child: Row(children: <Widget>[
        Container(
          height: 125,
          width: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(), 
          ),
        ),
        SizedBox(width: 26,),
        Column(children: <Widget>[
          Text('Lasagna'),
          Text('Alison J'),
          Container(
            height: 2,
            width: 75,
            color: Colors.orange,
          )
        ],)
      ],),),),
    );
  }
}

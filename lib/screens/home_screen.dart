import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recipe_book/screens/recipe_detail.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<List<dynamic>> fetchRecipes() async {
    // Android 10.0.2.2
    // IOS 127.0.0.1
    // WEB
    final url = Uri.parse('http://10.0.2.2:12346/recipes');
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    return data['recipes'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: fetchRecipes(), 
        builder: (context, snapshot){
          final recipes = snapshot.data ?? [];
          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index){
              return _RecipesCard(context,recipes[index]);
            } );

        }
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            _showBottom(context);
          }),
    );
  }

  Future<void> _showBottom(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (contexto) => Container(
              width: MediaQuery.of(context).size.width,
              height: 600,
              color: Colors.white,
              child: const RecipeForm(),
            ));
  }

  Widget _RecipesCard(BuildContext context, dynamic recipe) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetail(recipeName: recipe['name']
      )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 125,
          child: Card(
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 125,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      recipe['image_link'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 26,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      recipe['name'],
                      style: const TextStyle(fontSize: 16, fontFamily: 'Quicksand'),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      height: 2,
                      width: 75,
                      color: Colors.orange,
                    ),
                    const Text('Alisonn',
                        style: TextStyle(fontSize: 16, fontFamily: 'Quicksand')),
                    const SizedBox(
                      height: 4,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecipeForm extends StatelessWidget {
  const RecipeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final TextEditingController _recipeName = TextEditingController();
    final TextEditingController _recipeAuthor = TextEditingController();
    final TextEditingController _recipeIMG = TextEditingController();
    final TextEditingController _recipeDecription = TextEditingController();

    return Padding(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add New Recipe',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              _buildTextField(
                  controller: _recipeName,
                  label: 'Recipe Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name recipe';
                    }
                    return null;
                  }),
              const SizedBox(
                height: 16,
              ),
              _buildTextField(
                  controller: _recipeAuthor,
                  label: 'Author',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the author';
                    }
                    return null;
                  }),
              const SizedBox(
                height: 16,
              ),
              _buildTextField(
                  controller: _recipeIMG,
                  label: 'Image Url',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name recipe';
                    }
                    return null;
                  }),
              const SizedBox(
                height: 16,
              ),
              _buildTextField(
                  maxLines: 4,
                  controller: _recipeDecription,
                  label: 'Recipe',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name recipe';
                    }
                    return null;
                  }),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text(
                      'Save Recipe',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ),
        ));
  }

  Widget _buildTextField(
      {required String label,
      required TextEditingController controller,
      required String? Function(String?) validator,
      int maxLines = 1}) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontFamily: 'Quicksand',
            color: Colors.orange,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.orange, width: 1),
              borderRadius: BorderRadius.circular(10))),
      validator: validator,
      maxLines: maxLines,
    );
  }
}

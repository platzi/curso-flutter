import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/models/recipe_model.dart';
import 'package:recipe_book/providers/recipes_provider.dart';
import 'package:recipe_book/screens/recipe_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoritesRecipes extends StatelessWidget {
  const FavoritesRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<RecipesProvider>(
        builder: (context, recipeProvider, child) {
          final favoritesRecipes = recipeProvider.favoriteRecipe;

          return favoritesRecipes.isEmpty
              ? Center(
                  child: Text(AppLocalizations.of(context)!.noRecipes),
                )
              : ListView.builder(
                  itemCount: favoritesRecipes.length,
                  itemBuilder: (contex, index) {
                    final recipe = favoritesRecipes[index];
                    return favoriteRecipesCard(recipe: recipe);
                  });
        },
      ),
    );
  }
}

class favoriteRecipesCard extends StatelessWidget {
  final Recipe recipe;
  const favoriteRecipesCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RecipeDetail(recipesData: recipe)));
      },
      child: Semantics(
        label: 'Tarjeta de recetas',
        hint: 'Toca para ver detalle de receta ${recipe.name}',
        child: Card(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Image.network(
                    recipe.imageLink,
                    fit: BoxFit.fill,
                  )),
              Text(
                recipe.name,
                style: TextStyle(
                    color: Colors.orange,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,      
                ),
              ),
              SizedBox(height: 8),
              Text(recipe.author),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

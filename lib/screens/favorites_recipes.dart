import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/models/recipe_model.dart';
import 'package:recipe_book/providers/recipes_provider.dart';
import 'package:recipe_book/screens/recipe_detail.dart';

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
                  child: Text('No favorites reciper'),
                )
              : ListView.builder(
                  itemCount: favoritesRecipes.length,
                  itemBuilder: (contex, index) {
                    final recipe = favoritesRecipes[index];
                    favoriteRecipesCard(recipe: recipe);
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
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Text(recipe.name),
            Text(recipe.author),
          ],
        ),
      ),
    );
  }
}

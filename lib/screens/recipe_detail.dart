import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/models/recipe_model.dart';
import 'package:recipe_book/providers/recipes_provider.dart';

class RecipeDetail extends StatefulWidget {
  final Recipe recipesData;
  const RecipeDetail({super.key, required this.recipesData});

  @override
  _RecipeDetailState createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> with SingleTickerProviderStateMixin {
  bool isFavorite = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this,
      duration:  Duration(milliseconds: 300)
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isFavorite = Provider.of<RecipesProvider>(context, listen: false)
        .favoriteRecipe
        .contains(widget.recipesData);
    ;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.recipesData.name,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          IconButton(
              onPressed: () async {
                await Provider.of<RecipesProvider>(context, listen: false)
                    .toggleFavoriteStatus(widget.recipesData);
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              icon: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  )))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            Image.network(widget.recipesData.imageLink),
            SizedBox(
              height: 8,
            ),
            Text(
              widget.recipesData.name,
              style: TextStyle(
                color: Colors.orange,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text("by ${widget.recipesData.author}",
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                )),
            SizedBox(
              height: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recipes steps:',
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                for (var step in widget.recipesData.recipeSteps)
                  Text("- $step"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

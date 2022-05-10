import 'package:getko/src/models/category.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({Key? key, required this.category}) : super(key: key);

  Widget getImage(String image) {
    if (image.contains("http")) {
      return Center(child: Image.network(image));
    } else {
      return Center(child: Image.asset(image));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 80,
                width: 90,
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    category.category,
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              Container(
                height: 80,
                width: 90,
                decoration: BoxDecoration(
                    gradient: RadialGradient(
                        colors: [category.begin, category.end],
                        center: Alignment(0, 0),
                        radius: 0.8,
                        focal: Alignment(0, 0),
                        focalRadius: 0.1)),
                padding: EdgeInsets.all(8.0),
                child: Center(
                    // child: Image.asset(category.image),
                    child: getImage(category.image)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cooky_recipe/api/api_fetch.dart';
import 'package:cooky_recipe/storage/store_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../states/bookmark_provider.dart';

Widget selectionContainer(
    double height, double width, bool selected, Widget widget) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
            color: selected == true ? const Color(0xff00cfc8) : Colors.grey,
            width: selected == true ? 2 : 0.75)),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: widget,
    ),
  );
}

Widget longSelectionContainer(
    Size screenSize, String imagePath, String text, bool selected) {
  return Container(
    height: 70,
    width: (screenSize.width / 2) - 32,
    decoration: BoxDecoration(
        border: Border.all(
            color: selected == true ? const Color(0xff00cfc8) : Colors.grey,
            width: selected == true ? 2 : 0.90),
        borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(imagePath), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 9),
            child: Text(
              text,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget homeSelect(Meals meal) {

  return Consumer<BookmarkProvider>(
    builder: (context, bookmarkProvider, _) {
      return Container(
        height: 250,
        width: 170,
        padding: const EdgeInsets.only(bottom: 20, left: 20),
        margin: const EdgeInsets.only(top: 20, left: 20),
        decoration: BoxDecoration(
          border: Border.all(
            width: 0.5,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: NetworkImage(meal.image),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  width: 135,
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(blurRadius: 50, blurStyle: BlurStyle.normal)
                  ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          overflow: meal.name.length < 18
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 5,
              right: 5,
              child: InkWell(
                child: Container(
                    height: 30,
                    width: 30,
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: SvgPicture.asset("assets/icons/bookmark.svg",
                        color: meal.isBookmarked == true
                            ? Colors.blue
                            : Colors.black26)),
                onTap: ()  {
                  final bool bmark = bookmarkProvider.bmchanges;
                  bookmarkProvider.toggleBookmark(!bmark);
                  if (meal.isBookmarked) {
                     removeBookmark(meal.id);
                     meal =  Meals(
                              name: meal.name,
                              category: meal.category,
                              id: meal.id,
                              image: meal.image,
                              instruction: meal.instruction,
                              ingredients: meal.ingredients,
                              measure: meal.measure,
                              isBookmarked: false,
                            );
                  } else {
                     addBookmark(meal.id);
                    meal = Meals(
                              name: meal.name,
                              category: meal.category,
                              id: meal.id,
                              image: meal.image,
                              instruction: meal.instruction,
                              ingredients: meal.ingredients,
                              measure: meal.measure,
                              isBookmarked: true,
                            );
                    bookmarkProvider.toggleBookmark(!bmark);

                  }
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}

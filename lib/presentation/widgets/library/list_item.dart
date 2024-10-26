import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ListItems extends StatelessWidget {
  const ListItems({
    super.key,
    required this.title,
    required this.subTitle,
    required this.image,
    required this.routes,
  });

  final List<String> image;
  final List<String> title;
  final List<String> subTitle;
  final List<String> routes;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        itemCount: 1,
        separatorBuilder: (context, index) => const SizedBox(
          height: 20,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              context.goNamed(routes[index]);
            },
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        image[index],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title[index],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      subTitle[index],
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

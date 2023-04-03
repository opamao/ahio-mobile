import 'package:flutter/material.dart';

class ItemsWidget extends StatelessWidget {
  const ItemsWidget({super.key});

  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 0.77,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 3),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            children: [
              Image.asset(
                "images/table2.png",
                width: 520,
                height: 200,
              ),
              const Text("Lorem ipsum dolor sit \namet,")
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 3,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            children: [
              Image.asset(
                "images/maison.png",
                width: 510,
                height: 190,
              ),
              const Text("Lorem ipsum dolor sit \namet,")
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 3),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            children: [
              Image.asset(
                "images/bsalon.png",
                width: 520,
                height: 200,
              ),
              const Text("Lorem ipsum dolor sit \namet,")
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            left: 3,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            children: [
              Image.asset(
                "images/sal1.png",
                width: 520,
                height: 200,
              ),
              const Text("Lorem ipsum dolor sit \namet,")
            ],
          ),
        )
      ],
    );
  }
}

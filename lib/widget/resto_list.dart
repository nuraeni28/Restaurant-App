import 'package:flutter/material.dart';
import 'package:yess_nutrion/model/resto.dart';
import 'package:yess_nutrion/styles.dart';

import '../resto_detail.dart';

class ListResto extends StatelessWidget {
  final Restaurant resto;
  const ListResto({required this.resto});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailResto.routeName,
          arguments: resto,
        );
      },
      child: Column(children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 40, bottom: 20),
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(
                        "https://restaurant-api.dicoding.dev/images/medium/" +
                            resto.pictureId),
                    fit: BoxFit.cover),
              ),
            ),
            Expanded(
              child: Container(
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    color: Colors.white70),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        resto.name,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: secondaryColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            resto.city,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(resto.rating.toString())
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }
}

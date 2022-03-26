import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:yess_nutrion/api/api_service.dart';
import 'package:yess_nutrion/model/resto.dart';
import 'package:yess_nutrion/recomend_resto.dart';
import 'package:yess_nutrion/styles.dart';
import 'package:yess_nutrion/widget/drink_list.dart';
import 'package:yess_nutrion/widget/food_list.dart';

class DetailResto extends StatefulWidget {
  static const routeName = 'detail_restaurant_page';
  final Restaurant resto;

  const DetailResto({required this.resto});

  @override
  State<DetailResto> createState() => _DetailRestoState();
}

class _DetailRestoState extends State<DetailResto> {

  Widget build(BuildContext context) {
String id = 'rqdv5juczeskfw1e867';
    return Scaffold(
      
      body: FutureBuilder(
        future: get(Uri.parse('https://restaurant-api.dicoding.dev/detail/$id')),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.hasData) {
            final response = snapshot.data as Response;
            final body = response.body;
            final restaurantFull = RestaurantFull.fromJson(jsonDecode(body)['restaurant']);

            return DetailRestoBody(restaurantFull: restaurantFull);
          } else {
            return CircularProgressIndicator();
          }
      },
      ),
    );
  }
}

class DetailRestoBody extends StatelessWidget {
  final RestaurantFull restaurantFull;

  const DetailRestoBody({
    required this.restaurantFull,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage('https://restaurant-api.dicoding.dev/images/medium/${restaurantFull.pictureId}'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, RecomendResto.routeName);
                              },
                            ),
                          ]),
                      SizedBox(
                        height: 200,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurantFull.name,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: secondaryColor,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(restaurantFull.city)
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(restaurantFull.description),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Foods',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      FoodList(resto: restaurantFull),
                      SizedBox(height: 30),
                      Text(
                        'Drinks',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      DrinkList(resto: restaurantFull),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

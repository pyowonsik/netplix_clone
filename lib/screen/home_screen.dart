import 'package:flutter/material.dart';
import 'package:netplix_clone/model/model_movie.dart';
import 'package:netplix_clone/widget/box_slider.dart';
import 'package:netplix_clone/widget/carousel_slider.dart';
import 'package:netplix_clone/widget/circle_slider.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 생성한 model에 List 데이터 저장
  List<Movie> movies = [
    Movie.fromMap({
      'title': '사랑의 불시착',
      'keyword': '사랑/로맨스/판타지',
      'poster': 'test_movie_1.png',
      'like': false
    }),
    Movie.fromMap({
      'title': '사랑의 불시착',
      'keyword': '사랑/로맨스/판타지',
      'poster': 'test_movie_1.png',
      'like': false
    }),
    Movie.fromMap({
      'title': '사랑의 불시착',
      'keyword': '사랑/로맨스/판타지',
      'poster': 'test_movie_1.png',
      'like': false
    }),
    Movie.fromMap({
      'title': '사랑의 불시착',
      'keyword': '사랑/로맨스/판타지',
      'poster': 'test_movie_1.png',
      'like': false
    }),
    Movie.fromMap({
      'title': '사랑의 불시착',
      'keyword': '사랑/로맨스/판타지',
      'poster': 'test_movie_1.png',
      'like': false
    }),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        // 순서 대로 스택
        // 스택 1 구간
        Stack(
          children: <Widget>[
            CarouselImage(movies: movies),
            TopBar(),
          ],
        ),
        // 스택 2 구간
        CircleSlider(movies: movies),
        // 스택 3 구간
        BoxSlider(movies: movies),
      ],
    );
  }
}

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset(
              'images/bbongflix_logo.png',
              fit: BoxFit.contain,
              height: 25,
            ),
            Container(
              padding: EdgeInsets.only(right: 1),
              child: Text(
                'TV 프로그램',
                style: TextStyle(fontSize: 14),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 1),
              child: Text(
                '영화',
                style: TextStyle(fontSize: 14),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 1),
              child: Text(
                '내가 찜한 콘텐츠',
                style: TextStyle(fontSize: 14),
              ),
            )
          ]),
    );
  }
}

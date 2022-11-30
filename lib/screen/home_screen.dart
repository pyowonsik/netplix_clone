import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:netplix_clone/model/model_movie.dart';
import 'package:netplix_clone/widget/box_slider.dart';
import 'package:netplix_clone/widget/carousel_slider.dart';
import 'package:netplix_clone/widget/circle_slider.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // firebase 연동
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> streamData;

  @override
  void initState() {
    super.initState();
    // movie 테이블 데이터 저장
    streamData = firebaseFirestore.collection('movie').snapshots();
  }

  // 데이터 fetch
  Widget _fetchData(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('movie').snapshots(),
        builder: (context, snapshot) {
          // 데이가 없다면
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }
          return _buildBody(context, snapshot.data!.docs);
        });
  }

  // 데이터를 이용한 위젯(리스트뷰)
  Widget _buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
    // movie의 더미 데이터
    List<Movie> movies = snapshot.map((d) => Movie.fromSnapshot(d)).toList();
    return ListView(children: [
      Stack(
        children: [CarouselImage(movies: movies), TopBar()],
      ),
      CircleSlider(movies: movies),
      BoxSlider(movies: movies)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return _fetchData(context);
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

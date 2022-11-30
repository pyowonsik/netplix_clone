import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:netplix_clone/model/model_movie.dart';
import 'package:netplix_clone/screen/detail_screen.dart';

class LikeScreen extends StatefulWidget {
  _LikeScreenState createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('movie')
            .where('like', isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          // 데이가 없다면
          if (!snapshot.hasData) {
            return LinearProgressIndicator();
          }
          return _buildList(context, snapshot.data!.docs);
        });
  }

  // 데이터를 이용한 위젯(리스트뷰)
  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1 / 1.5,
        padding: EdgeInsets.all(3),
        children:
            snapshot.map((data) => _buildListItem(context, data)).toList(),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final movie = Movie.fromSnapshot(data);
    return InkWell(
      child: Image.network(movie.poster),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute<Null>(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return DetailScreen(movie: movie);
            }));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 27, 20, 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'images/bbongflix_logo.png',
                fit: BoxFit.contain,
                height: 25,
              ),
              Container(
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  '내가 찜한 콘텐츠',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        _buildBody(context),
      ],
    );
  }
}

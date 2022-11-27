import 'package:flutter/material.dart';
import 'package:netplix_clone/model/model_movie.dart';
import 'package:netplix_clone/screen/detail_screen.dart';

class CircleSlider extends StatelessWidget {
  final List<Movie>? movies;

  // 생성자
  CircleSlider({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('미리 보기'),
            Container(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: makeCircleImages(context, movies!),
              ),
            )
          ]),
    );
  }
}

List<Widget> makeCircleImages(BuildContext context, List<Movie> movies) {
  List<Widget> results = [];
  for (var i = 0; i < movies.length; i++) {
    results.add(InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
          return DetailScreen(
            movie: movies![i],
          );
        }));
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: CircleAvatar(
            backgroundImage: AssetImage('images/' + movies[i].poster),
            radius: 48,
          ),
        ),
      ),
    ));
  }
  return results;
}

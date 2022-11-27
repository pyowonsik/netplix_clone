import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:netplix_clone/model/model_movie.dart';

class BoxSlider extends StatelessWidget {
  final List<Movie>? movies;
  BoxSlider({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('지금 뜨는 콘텐츠'),
            Container(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: makeBoxImages(movies!),
              ),
            )
          ]),
    );
  }
}

List<Widget> makeBoxImages(List<Movie> movies) {
  List<Widget> results = [];
  for (var i = 0; i < movies.length; i++) {
    results.add(InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Image.asset('images/' + movies[i].poster),
        ),
      ),
    ));
  }
  return results;
}

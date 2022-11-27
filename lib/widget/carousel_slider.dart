import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netplix_clone/model/model_movie.dart';

class CarouselImage extends StatefulWidget {
  final List<Movie>? movies;
  CarouselImage({Key? key, required this.movies}) : super(key: key);
  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  List<Movie>? movies;
  List<Widget>? images;
  List<String>? keywords;
  List<bool>? likes;
  int _currentPage = 0;
  late String _currentKeyword;

  @override
  void initState() {
    super.initState();
    movies = widget.movies;
    images = movies?.map((m) => Image.asset('./images/' + m.poster)).toList();
    keywords = movies?.map((m) => m.keyword).cast<String>().toList();
    likes = movies?.map((m) => m.like).cast<bool>().toList();
    _currentKeyword = keywords![0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
          ),
          CarouselSlider(
            items: images,
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(
                  () {
                    _currentPage = index;
                    _currentKeyword = keywords![_currentPage];
                  },
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 3),
            child: Text(
              _currentKeyword,
              style: TextStyle(fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}

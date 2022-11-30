import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:netplix_clone/model/model_movie.dart';
import 'package:netplix_clone/screen/detail_screen.dart';

class SearchScreen extends StatefulWidget {
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _fillter = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _searchText = '';

  _SearchScreenState() {
    _fillter.addListener(() {
      setState(() {
        _searchText = _fillter.text;
      });
    });
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('movie').snapshots(),
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
    List<DocumentSnapshot> searchResult = [];
    for (DocumentSnapshot d in snapshot) {
      if (d.data().toString().contains(_searchText)) {
        searchResult.add(d);
      }
    }
    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1 / 1.5,
        padding: EdgeInsets.all(3),
        children:
            searchResult.map((data) => _buildListItem(context, data)).toList(),
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
    return Container(
      child: Column(
        children: <Widget>[
          // Padding(padding: EdgeInsets.all(30)),
          Container(
            color: Colors.black,
            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Row(children: [
              Expanded(
                flex: 6,
                child: TextField(
                  focusNode: focusNode,
                  style: TextStyle(fontSize: 15),
                  autofocus: true,
                  controller: _fillter,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white60,
                      size: 20,
                    ),
                    suffixIcon: focusNode.hasFocus
                        ? IconButton(
                            icon: Icon(Icons.cancel, size: 20),
                            onPressed: () {
                              setState(() {
                                _fillter.clear();
                                _searchText = '';
                              });
                            },
                          )
                        : Container(),
                    hintText: '검색',
                    labelStyle: TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
              ),
              focusNode.hasFocus
                  ? Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(),
                        onPressed: () {
                          setState(() {
                            _fillter.clear();
                            _searchText = '';
                            focusNode.unfocus();
                          });
                        },
                        child: Text('취소'),
                      ),
                    )
                  : Expanded(
                      flex: 0,
                      child: Container(),
                    ),
            ]),
          ),
          _buildBody(context),
        ],
      ),
    );
  }
}

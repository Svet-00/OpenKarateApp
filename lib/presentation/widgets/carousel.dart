import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  final List<String> imgList;
  final String title;
  final String subtitle;

  const Carousel({
    Key key,
    @required this.imgList,
    @required this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _current = 0;
  double subtitleHeight;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.imgList.forEach((imageUrl) {
        precacheImage(NetworkImage(imageUrl), context);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    subtitleHeight = widget.subtitle != null ? 30 : 0;
    final imageHeight = MediaQuery.of(context).size.width * 10 / 16;
    final shouldAutoscroll = widget.imgList.length > 1;
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        CarouselSlider.builder(
          options: CarouselOptions(
            height: imageHeight,
            //aspectRatio: 16 / 9,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: shouldAutoscroll,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: false,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          itemCount: widget.imgList.length,
          itemBuilder: (ctx, index) => Container(
            width: double.infinity,
            height: imageHeight,
            //margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: index < widget.imgList.length
                ? Image.network(widget.imgList[index], fit: BoxFit.cover)
                : Container(),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: imageHeight - (70 + subtitleHeight)),
          child: Column(
            children: [
              Container(
                color: Color.fromRGBO(0, 0, 0, 0.7),
                width: double.infinity,
                height: 70 + subtitleHeight,
                child: Padding(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.white),
                      ),
                      widget.subtitle != null
                          ? Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Text(
                                widget.subtitle,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(color: Colors.white),
                              ),
                            )
                          : Container(),
                      shouldAutoscroll
                          ? Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                // number of pictures * (width of bullet (12) + margin (4)) + 26 for clean look
                                width: widget.imgList.length * 14.0 + 26,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: widget.imgList.map((url) {
                                    final index = widget.imgList.indexOf(url);
                                    return Container(
                                      width: 10.0,
                                      height: 10.0,
                                      margin: EdgeInsets.symmetric(
                                          vertical: widget.subtitle != null
                                              ? 10.0
                                              : 5.0,
                                          horizontal: 2.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _current == index
                                            ? Color.fromRGBO(255, 255, 255, 0.7)
                                            : Color.fromRGBO(
                                                255, 255, 255, 0.3),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/gym.dart';
import '../../../presentation/widgets/carousel.dart';
import '../../../presentation/widgets/gym_favorite_button.dart';

class GymHeader extends StatelessWidget {
  final List<String> imgList;
  final String title;
  final String subtitle;
  final String description;
  final Gym gym;

  GymHeader({
    @required this.imgList,
    @required this.title,
    this.subtitle,
    @required this.description,
    this.gym,
  });

  @override
  Widget build(BuildContext context) {
    final imageHeight = MediaQuery.of(context).size.width * 10 / 16;

    final descriptionWidget = description == null || description.isEmpty
        ? Container(
            height: 20,
          )
        : ExpandableNotifier(
            child: ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: false,
                  tapHeaderToExpand: true,
                  tapBodyToExpand: true,
                  hasIcon: true,
                  useInkWell: false,
                ),
                collapsed: Padding(
                  padding: EdgeInsets.only(top: 10, left: 60),
                  child: Text(
                    description,
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.fade,
                  ),
                ),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(bottom: 10, top: 10, left: 60),
                        child: Text(
                          description,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        )),
                    ExpandableButton(
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(Icons.expand_less),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );

    return Container(
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Column(
                children: [
                  Carousel(
                    imgList: imgList,
                    title: title,
                    subtitle: subtitle ?? '',
                  ),
                  descriptionWidget,
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 10, top: imageHeight - 20),
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: GymFavoriteButton(gym: gym),
                  ),
                ),
              ),
            ],
          ),
          Divider(thickness: 1),
        ],
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/desk.dart';
import '../../widgets/desk_animation.dart';

const int initialIndex = 0;

/// A carousel slider that displays all [Desk] entities.
///
/// The user can select a desk by swiping through the carousel. (while doing this, the currentDesk gets updated)
class DeskCarouselSlider extends StatefulWidget {
  final List<Desk> allDesks;
  final Function(Desk) onDeskSelected;

  const DeskCarouselSlider({
    required this.allDesks,
    required this.onDeskSelected,
    super.key,
  });

  @override
  State<DeskCarouselSlider> createState() => _DeskCarouselSliderState();
}

class _DeskCarouselSliderState extends State<DeskCarouselSlider> {
  final CarouselController buttonCarouselController = CarouselController();
  int currentIndex = initialIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCarouselSlider(),
        _buildIndicatorBar(),
      ],
    );
  }

  Widget _buildCarouselSlider() {
    return CarouselSlider(
      items: [
        for (Desk desk in widget.allDesks)
          DeskAnimation(
            width: 200,
            deskHeight: desk.height,
          ),
      ],
      options: CarouselOptions(
        height: 200.0,
        enableInfiniteScroll: false,
        initialPage: initialIndex,
        onPageChanged: (index, _) {
          setState(() {
            currentIndex = index;
          });
          widget.onDeskSelected(widget.allDesks[index]);
        },
      ),
    );
  }

  Widget _buildIndicatorBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.allDesks.asMap().entries.map(
        (entry) {
          return GestureDetector(
            onTap: () => buttonCarouselController.animateToPage(entry.key),
            child: Container(
              width: 10.0,
              height: 10.0,
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (Theme.of(context).colorScheme.secondary).withOpacity(
                  currentIndex == entry.key ? 0.9 : 0.3,
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}

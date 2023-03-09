import 'package:flutter/material.dart';
import 'package:nusketch/util/dimension.dart';

class FlipAround extends StatefulWidget {
  const FlipAround({super.key});
  @override
  State<FlipAround> createState() => _FlipAroundState();
}

class _FlipAroundState extends State<FlipAround>
    with SingleTickerProviderStateMixin {
  late bool _flipped = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _flipped = !_flipped;
        });
      },
      child: AnimatedCrossFade(
        firstChild: Container(
          width: Dimension.innerpicturew,
          height: Dimension.innerpictureh,
          margin: EdgeInsets.only(top: Dimension.page10h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimension.page10r),
            color: Colors.white,
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("figures/girlimage1.png"), // figures/
            ),
          ),
        ),
        secondChild: Container(
          width: Dimension.innerpicturew,
          height: Dimension.innerpictureh,
          margin: EdgeInsets.only(top: Dimension.page10h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimension.page10r),
            color: Colors.white,
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("figures/illustration.png"),
            ),
          ),
        ),
        crossFadeState:
            _flipped ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 1700),
      ),
    );
  }
}

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
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 0.8,
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
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 0.8,
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

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TeamCrest extends StatelessWidget {
  const TeamCrest({
    Key? key,
    required this.crest,
  }) : super(key: key);

  final String crest;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.15,
      child: crest.split(".").last == "svg"
          ? SvgPicture.network(
              crest,
              fit: BoxFit.contain,
            )
          : Image.network(
              crest,
              fit: BoxFit.contain,
            ),
    );
  }
}

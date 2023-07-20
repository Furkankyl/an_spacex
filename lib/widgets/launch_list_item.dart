import 'package:an_spacex/models/launch_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class LaunchListItem extends StatelessWidget {
  final LaunchData launchData;

  const LaunchListItem({Key? key, required this.launchData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: const [
        FadeEffect(
            duration: Duration(milliseconds: 500),
            delay: Duration(milliseconds: 200)),
        SlideEffect(
            begin: Offset(-1, 0),
            end: Offset(0, 0),
            duration: Duration(milliseconds: 500),
            delay: Duration(milliseconds: 200))
      ],
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: const Offset(0, 0),
                  color: Colors.white54.withOpacity(.5))
            ]),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              if (launchData.links?.patch?.small != null)
                Expanded(
                    flex: 1,
                    child: Animate(effects: const [
                      FadeEffect(
                          duration: Duration(milliseconds: 500),
                          delay: Duration(milliseconds: 700)),
                    ], child: Image.network(launchData.links!.patch!.small!))),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 2,
                child: launchInfoItems(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget launchInfoItems(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          launchData.name!,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          launchData.details ?? "",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Color(0xFF8991a5)),
        ),
        const SizedBox(
          height: 8,
        ),
        Text("Numara:${launchData.flightNumber.toString()}"),
        Text(
            "Tarih:${DateFormat("dd MMMM yyyy", "tr_TR").format(DateTime.fromMillisecondsSinceEpoch(launchData.dateUnix! * 1000))}"),
        Text(
            "Saat:${DateFormat("HH:mm", "tr_TR").format(DateTime.fromMillisecondsSinceEpoch(launchData.dateUnix! * 1000))}"),
        const SizedBox(
          height: 8,
        ),
        launchInfoBottomRow()
      ],
    );
  }

  Widget launchInfoBottomRow(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (launchData.crew!.isNotEmpty)
          Column(
            children: [
              const Icon(
                FontAwesomeIcons.userAstronaut,
                size: 14,
              ),
              Text(
                "${launchData.crew!.length} astronot",
                style: const TextStyle(fontSize: 14),
              )
            ],
          ),
        if (launchData.ships!.isNotEmpty) ...[
          if (launchData.crew!.isNotEmpty)
            const SizedBox(
              width: 8,
            ),
          Column(
            children: [
              const Icon(
                FontAwesomeIcons.shuttleSpace,
                size: 14,
              ),
              Text(
                "${launchData.ships!.length} mekik",
                style: const TextStyle(fontSize: 14),
              )
            ],
          )
        ],
        if (launchData.capsules!.isNotEmpty) ...[
          if (launchData.ships!.isNotEmpty)
            const SizedBox(
              width: 8,
            ),
          Column(
            children: [
              const Icon(
                FontAwesomeIcons.rocket,
                size: 14,
              ),
              Text(
                "${launchData.capsules!.length} kapsül",
                style: const TextStyle(fontSize: 14),
              )
            ],
          )
        ],
      ],
    );
  }
}

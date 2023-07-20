import 'package:an_spacex/models/launch_data.dart';
import 'package:an_spacex/screens/launch_detail_page.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:translator/translator.dart';

class LaunchListItem extends StatelessWidget {
  final LaunchData launchData;
  final translator = GoogleTranslator();

  LaunchListItem({Key? key, required this.launchData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fade,
      closedColor: Theme.of(context).scaffoldBackgroundColor,
      openColor: Colors.transparent,
      closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)),
      closedElevation: 0,
      transitionDuration: const Duration(milliseconds: 500),
      openBuilder: (BuildContext context, VoidCallback _) {
        return LaunchDetailPage(launchData: launchData,);
      },
      closedBuilder:
          (BuildContext context, VoidCallback openContainer) {
        return  Animate(
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
                boxShadow: const [
                  BoxShadow(
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: Offset(0, 0),
                      color: Colors.white30)
                ]),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Animate(
                          effects: const [
                            FadeEffect(
                                duration: Duration(milliseconds: 500),
                                delay: Duration(milliseconds: 700)),
                          ],
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              launchData.links?.patch?.small ??
                                  "https://www.spacex.com/static/images/share.jpg",
                              fit: BoxFit.cover,
                            ),
                          ))),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 2,
                    child: launchInfoItems(openContainer),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      tappable: false,
    );

  }

  Widget launchInfoItems(var openContainer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          launchData.name!,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        if ((launchData.detailsLocale ?? "").isNotEmpty)
          Text(
            launchData.detailsLocale!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        if ((launchData.detailsLocale ?? "").isEmpty)
          FutureBuilder(
              future: translator.translate(launchData.details ?? "",
                  from: "en", to: "tr"),
              initialData: launchData.details ?? "",
              builder: (context, snapsot) {
                if (!snapsot.hasData) {
                  return const SizedBox();
                }

                launchData.detailsLocale = snapsot.data.toString();

                return Text(
                  launchData.detailsLocale ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                );
              }),
        const SizedBox(
          height: 8,
        ),
        Text("Numara: ${launchData.flightNumber.toString()}"),
        Text("Referans: ${launchData.id ?? ""}"),
        Text(
            "Tarih: ${DateFormat("dd MMMM yyyy", "tr_TR").format(DateTime.fromMillisecondsSinceEpoch(launchData.dateUnix! * 1000))}"),
        Text(
            "Saat: ${DateFormat("HH:mm", "tr_TR").format(DateTime.fromMillisecondsSinceEpoch(launchData.dateUnix! * 1000))}"),
        const SizedBox(
          height: 8,
        ),
        launchInfoBottomRow(),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: double.infinity,
          height: 30,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white),
            onPressed: openContainer,
            child: const Text("Görüntüle"),
          ),
        )
      ],
    );
  }

  Widget launchInfoBottomRow() {
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

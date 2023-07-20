import 'package:an_spacex/models/launch_data.dart';
import 'package:an_spacex/widgets/custom_animate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchItem extends StatelessWidget {
  final LaunchData launchData;
  final bool showName;

  const LaunchItem({Key? key, required this.launchData, this.showName = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      primary: false,
      children: [
        !showName
            ? const SizedBox()
            : CustomAnimate(
                effects: const [
                  FadeEffect(
                      duration: Duration(milliseconds: 500),
                      delay: Duration(milliseconds: 100)),
                  SlideEffect(
                      delay: Duration(milliseconds: 100),
                      duration: Duration(milliseconds: 500),
                      begin: Offset(-.5, 0),
                      end: Offset(0, 0))
                ],
                child: ListTile(
                  leading: const Icon(FontAwesomeIcons.shuttleSpace),
                  subtitle: const Text("Görev İsmi"),
                  title: Text(
                    launchData.name ?? "",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
              ),
        CustomAnimate(
          effects: const [
            FadeEffect(
                duration: Duration(milliseconds: 500),
                delay: Duration(milliseconds: 200)),
            SlideEffect(
                delay: Duration(milliseconds: 200),
                duration: Duration(milliseconds: 500),
                begin: Offset(-.5, 0),
                end: Offset(0, 0))
          ],
          child: ListTile(
            leading: const Icon(FontAwesomeIcons.circleInfo),
            subtitle: const Text("Görev Durumu"),
            title: Text(
              launchData.success == null
                  ? "Belirsiz"
                  : launchData.success!
                      ? "Başarılı"
                      : "Başarısız",
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
        ),
        CustomAnimate(
          effects: const [
            FadeEffect(
                duration: Duration(milliseconds: 500),
                delay: Duration(milliseconds: 300)),
            SlideEffect(
                delay: Duration(milliseconds: 300),
                duration: Duration(milliseconds: 500),
                begin: Offset(-.5, 0),
                end: Offset(0, 0))
          ],
          child: ListTile(
            leading: const Icon(FontAwesomeIcons.rocket),
            subtitle: const Text("Uçuş Numarası"),
            title: Text(
              launchData.flightNumber.toString(),
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
        ),
        CustomAnimate(
          effects: const [
            FadeEffect(
                duration: Duration(milliseconds: 500),
                delay: Duration(milliseconds: 400)),
            SlideEffect(
                delay: Duration(milliseconds: 400),
                duration: Duration(milliseconds: 500),
                begin: Offset(-.5, 0),
                end: Offset(0, 0))
          ],
          child: ListTile(
            leading: const Icon(FontAwesomeIcons.solidMessage),
            subtitle: const Text("Detay"),
            title: Text(
              launchData.detailsLocale ?? "Belirtilmedi",
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
        ),
        CustomAnimate(
          effects: const [
            FadeEffect(
                duration: Duration(milliseconds: 500),
                delay: Duration(milliseconds: 500)),
            SlideEffect(
                delay: Duration(milliseconds: 500),
                duration: Duration(milliseconds: 500),
                begin: Offset(-.5, 0),
                end: Offset(0, 0))
          ],
          child: ListTile(
            leading: const Icon(FontAwesomeIcons.calendar),
            subtitle: const Text("Tarih"),
            title: Text(
              DateFormat("dd MMMM yyyy", "tr_TR").format(
                  DateTime.fromMillisecondsSinceEpoch(
                      launchData.dateUnix! * 1000)),
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
        ),
        CustomAnimate(
          effects: const [
            FadeEffect(
                duration: Duration(milliseconds: 500),
                delay: Duration(milliseconds: 600)),
            SlideEffect(
                delay: Duration(milliseconds: 600),
                duration: Duration(milliseconds: 500),
                begin: Offset(-.5, 0),
                end: Offset(0, 0))
          ],
          child: ListTile(
            leading: const Icon(FontAwesomeIcons.solidClock),
            subtitle: const Text("Saat"),
            title: Text(
              DateFormat("HH:mm", "tr_TR").format(
                  DateTime.fromMillisecondsSinceEpoch(
                      launchData.dateUnix! * 1000)),
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomAnimate(
              effects: const [
                FadeEffect(
                    duration: Duration(milliseconds: 500),
                    delay: Duration(milliseconds: 700)),
                SlideEffect(
                    delay: Duration(milliseconds: 700),
                    duration: Duration(milliseconds: 500),
                    begin: Offset(0, -.5),
                    end: Offset(0, 0))
              ],
              child: Column(
                children: [
                  const Icon(
                    FontAwesomeIcons.userAstronaut,
                    size: 40,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "${launchData.crew!.length} astronot",
                  )
                ],
              ),
            ),
            CustomAnimate(
              effects: const [
                FadeEffect(
                    duration: Duration(milliseconds: 500),
                    delay: Duration(milliseconds: 700)),
                SlideEffect(
                    delay: Duration(milliseconds: 700),
                    duration: Duration(milliseconds: 500),
                    begin: Offset(0, -.5),
                    end: Offset(0, 0))
              ],
              child: Column(
                children: [
                  const Icon(
                    FontAwesomeIcons.shuttleSpace,
                    size: 40,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "${launchData.ships!.length} mekik",
                  )
                ],
              ),
            ),
            CustomAnimate(
              effects: const [
                FadeEffect(
                    duration: Duration(milliseconds: 500),
                    delay: Duration(milliseconds: 700)),
                SlideEffect(
                    delay: Duration(milliseconds: 700),
                    duration: Duration(milliseconds: 500),
                    begin: Offset(0, -.5),
                    end: Offset(0, 0))
              ],
              child: Column(
                children: [
                  const Icon(
                    FontAwesomeIcons.rocket,
                    size: 40,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "${launchData.capsules!.length} kapsül",
                  )
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        socialButtons(launchData),
        if (launchData.links?.flickr?.original != null &&
            launchData.links!.flickr!.original!.isNotEmpty)
          flickrImages(launchData.links!.flickr!, context),
      ],
    );
  }

  Widget socialButtons(LaunchData launchData) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (launchData.links?.reddit?.launch != null)
          ElevatedButton.icon(
              onPressed: () {
                launchUrl(Uri.parse(launchData.links!.reddit!.launch!));
              },
              icon: const Icon(
                FontAwesomeIcons.reddit,
                color: Colors.orange,
              ),
              label: const Text("Reddit'te Görüntüle")),
        if (launchData.links?.youtubeId != null)
          ElevatedButton.icon(
              onPressed: () {
                launchUrl(Uri.parse(
                    "https://www.youtube.com/watch?v=${launchData.links!.youtubeId}"));
              },
              icon: const Icon(
                FontAwesomeIcons.youtube,
                color: Colors.red,
              ),
              label: const Text("Youtube da Görüntüle")),
        if (launchData.links?.wikipedia != null)
          ElevatedButton.icon(
              onPressed: () {
                launchUrl(Uri.parse(launchData.links!.wikipedia!));
              },
              icon: const Icon(
                FontAwesomeIcons.wikipediaW,
                color: Colors.black,
              ),
              label: const Text("Wikipedia'da Görüntüle")),
      ],
    );
  }

  Widget flickrImages(Flickr flickr, BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(FontAwesomeIcons.flickr),
          title: Text(
            "Flickr Fotoğrafları",
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: (flickr.original ?? []).map((e) {
              return FullScreenWidget(
                backgroundIsTransparent: true,
                  disposeLevel: DisposeLevel.Medium,
                  child: Container(
                    width: 200,
                    margin: const EdgeInsets.all(8),
                    child: Hero(
                      tag: "${flickr.original!.indexOf(e)}",
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          e,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ));
            }).toList(),
          ),
        ),
      ],
    );
  }
}

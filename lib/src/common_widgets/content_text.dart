import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class ContentText extends StatelessWidget {
  const ContentText({
    super.key,
    required this.text,
    this.isContentTextMini = false,
  });
  final String text;
  final bool isContentTextMini;

  @override
  Widget build(BuildContext context) {
    return Linkify(
      maxLines: isContentTextMini ? 4 : null,
      text: text,
      style: Theme.of(context).textTheme.bodyLarge,
      overflow: isContentTextMini ? TextOverflow.ellipsis : TextOverflow.clip,
      softWrap: true,
      linkStyle: const TextStyle(
        decoration: TextDecoration.none,
      ),
      options: const LinkifyOptions(
        humanize: true,
        removeWww: false,
      ),
      onOpen: (link) async {
        final Uri url = Uri.parse(link.url);
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          throw 'Could not launch $link';
        }
      },
    );
  }
}

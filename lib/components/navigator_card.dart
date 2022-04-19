import 'package:flutter/material.dart';
import 'package:pomodoro/constants/constant.dart';
import 'package:pomodoro/viewmodels/settings_provider.dart';
import 'package:provider/provider.dart';

class NavigatorCard extends StatelessWidget {
  const NavigatorCard({
    Key? key,
    required this.icon,
    required this.onPress,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback onPress;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, _) {
        final bgColor2 = settings.theme == 'dark' ? kBgClr2Dark : kBgClr2;
        final titleColor = Colors.white.withAlpha(190);
        final subtitleColor =
            settings.theme == 'dark' ? kTextClr2Dark : kTextClr2;
        return Padding(
          padding:
              const EdgeInsets.only(left: 16.0, right: 16, top: 8, bottom: 8),
          child: Card(
            elevation: 5,
            color: bgColor2.withOpacity(0.8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            child: ListTile(
              onTap: onPress,
              contentPadding: const EdgeInsets.all(16),
              leading: Icon(
                icon,
                color: subtitleColor,
                size: 36,
              ),
              title: Text(
                title,
                style: TextStyle(color: titleColor, fontSize: 18),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                child: Text(
                  subtitle,
                  style: TextStyle(
                    color: subtitleColor,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

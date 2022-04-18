import 'package:flutter/material.dart';
import 'package:pomodoro/constants/constant.dart';
import 'package:pomodoro/viewmodels/settings_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  static String routeName = '/settings';
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void showThemeModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: kBgClr4,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      builder: (BuildContext context) {
        return Consumer<SettingsProvider>(
          builder: (context, settings, _) => Container(
            padding: const EdgeInsets.all(16),
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Choose a theme',
                      style: TextStyle(
                        color: kTextClr,
                        fontSize: 16,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
                RadioListTile(
                  title: const Text('Dark'),
                  value: 'dark',
                  groupValue: settings.theme,
                  onChanged: (String? val) {
                    if (val != null) settings.theme = val;
                  },
                ),
                const Divider(
                  color: kTextClr,
                ),
                RadioListTile(
                  title: const Text('Light'),
                  value: 'light',
                  groupValue: settings.theme,
                  onChanged: (String? val) {
                    if (val != null) settings.theme = val;
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showAlarmToneModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: kBgClr4,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      builder: (BuildContext context) {
        return Consumer<SettingsProvider>(
          builder: (context, settings, _) => Container(
            padding: const EdgeInsets.all(16),
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Choose a alarm tone!',
                      style: TextStyle(
                        color: kTextClr,
                        fontSize: 16,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
                RadioListTile(
                  title: const Text('Morning birds'),
                  value: 'morning-birds',
                  groupValue: settings.alarmTone,
                  onChanged: (String? val) {
                    if (val != null) settings.alarmTone = val;
                  },
                ),
                const Divider(
                  color: kTextClr,
                ),
                RadioListTile(
                  title: const Text('Ocean waves'),
                  value: 'ocean-waves',
                  groupValue: settings.alarmTone,
                  onChanged: (String? val) {
                    if (val != null) settings.alarmTone = val;
                  },
                ),
                const Divider(
                  color: kTextClr,
                ),
                RadioListTile(
                  title: const Text('Telephone'),
                  value: 'telephone',
                  groupValue: settings.alarmTone,
                  onChanged: (String? val) {
                    if (val != null) settings.alarmTone = val;
                  },
                ),
                const Divider(
                  color: kTextClr,
                ),
                RadioListTile(
                  title: const Text('default'),
                  value: 'default',
                  groupValue: settings.alarmTone,
                  onChanged: (String? val) {
                    if (val != null) settings.alarmTone = val;
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBgClrNoOp,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<SettingsProvider>(
            builder: (context, settings, _) => ListView(
              children: [
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Go home'),
                  ),
                ),
                SwitchListTile(
                  // tileColor: kBgClr2,
                  secondary: const Icon(Icons.notifications),
                  contentPadding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  title: const Text(
                    'Enable Notifications',
                    style: TextStyle(color: kTextClr),
                  ),
                  subtitle: const Text(
                    'Check to enable notifications when a session event occurs',
                    style: TextStyle(color: Colors.black),
                  ),
                  value: settings.notificationEnabled,
                  onChanged: (bool newValue) {
                    settings.notificationEnabled = newValue;
                  },
                ),
                const Divider(
                  color: kTextClr,
                ),
                SwitchListTile(
                  secondary: const Icon(Icons.schedule),
                  contentPadding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  title: const Text(
                    'Enable auto break session',
                    style: TextStyle(color: kTextClr),
                  ),
                  subtitle: const Text(
                    'Enables automatic start of break session',
                    style: TextStyle(color: Colors.black),
                  ),
                  value: settings.autoBreakEnabled,
                  onChanged: (bool newValue) {
                    settings.autoBreakEnabled = newValue;
                  },
                ),
                const Divider(
                  color: kTextClr,
                ),
                ListTile(
                  onTap: () {
                    showAlarmToneModal(context);
                  },
                  leading: const Icon(Icons.alarm),
                  title: const Text(
                    'Alarm tone',
                    style: TextStyle(color: kTextClr),
                  ),
                  subtitle: const Text(
                    'Sets your favorite alarm tone',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: Text(
                    settings.alarmTone,
                    style: const TextStyle(
                        color: Colors.brown, fontStyle: FontStyle.italic),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
                const Divider(
                  color: kTextClr,
                ),
                ListTile(
                  onTap: () {
                    showThemeModal(context);
                  },
                  leading: const Icon(Icons.color_lens),
                  title: const Text(
                    'Theme',
                    style: TextStyle(color: kTextClr),
                  ),
                  subtitle: const Text(
                    'Change your app theme',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: Text(
                    settings.theme,
                    style: const TextStyle(
                        color: Colors.brown, fontStyle: FontStyle.italic),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

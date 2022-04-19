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
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Consumer<SettingsProvider>(
          builder: (context, settings, _) {
            Color textColor =
                settings.theme == 'dark' ? kTextClrDark : kTextClr;
            return Container(
              decoration: BoxDecoration(
                color: settings.theme == 'dark' ? kBgClr2Dark : kBgClr4,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Choose a theme',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close,
                            color: settings.theme == 'dark'
                                ? Colors.white
                                : Colors.black),
                      )
                    ],
                  ),
                  RadioListTile(
                    activeColor: textColor,
                    title: Text(
                      'Dark',
                      style: TextStyle(color: textColor),
                    ),
                    value: 'dark',
                    groupValue: settings.theme,
                    onChanged: (String? val) {
                      if (val != null) settings.theme = val;
                    },
                  ),
                  Divider(
                    color: textColor,
                  ),
                  RadioListTile(
                    activeColor: textColor,
                    title: Text('Light', style: TextStyle(color: textColor)),
                    value: 'light',
                    groupValue: settings.theme,
                    onChanged: (String? val) {
                      if (val != null) settings.theme = val;
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void showAlarmToneModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      builder: (BuildContext context) {
        return Consumer<SettingsProvider>(
          builder: (context, settings, _) {
            Color textColor =
                settings.theme == 'dark' ? kTextClrDark : kTextClr;
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: settings.theme == 'dark' ? kBgClr2Dark : kBgClr4,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Choose a alarm tone!',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close, color: textColor),
                      )
                    ],
                  ),
                  RadioListTile(
                    activeColor: textColor,
                    title: Text(
                      'Morning birds',
                      style: TextStyle(color: textColor),
                    ),
                    value: 'morning-birds',
                    groupValue: settings.alarmTone,
                    onChanged: (String? val) {
                      if (val != null) settings.alarmTone = val;
                    },
                  ),
                  Divider(color: textColor),
                  RadioListTile(
                    activeColor: textColor,
                    title:
                        Text('Ocean waves', style: TextStyle(color: textColor)),
                    value: 'ocean-waves',
                    groupValue: settings.alarmTone,
                    onChanged: (String? val) {
                      if (val != null) settings.alarmTone = val;
                    },
                  ),
                  Divider(color: textColor),
                  RadioListTile(
                    activeColor: textColor,
                    title:
                        Text('Telephone', style: TextStyle(color: textColor)),
                    value: 'telephone',
                    groupValue: settings.alarmTone,
                    onChanged: (String? val) {
                      if (val != null) settings.alarmTone = val;
                    },
                  ),
                  Divider(color: textColor),
                  RadioListTile(
                    activeColor: textColor,
                    title: Text('default', style: TextStyle(color: textColor)),
                    value: 'default',
                    groupValue: settings.alarmTone,
                    onChanged: (String? val) {
                      if (val != null) settings.alarmTone = val;
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Provider.of<SettingsProvider>(context).theme == 'dark'
            ? kBgClrNoOpDark
            : kBgClrNoOp,
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
                    child: const Text('Go Back'),
                  ),
                ),
                SwitchListTile(
                  // tileColor: Provider.of<SettingsProvider>(context).theme == 'dark' ? kBgClr2Dark : kBgClr2,
                  secondary: Icon(Icons.notifications,
                      color:
                          Provider.of<SettingsProvider>(context).theme == 'dark'
                              ? kTextClrDark
                              : kTextClr),
                  contentPadding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  title: Text(
                    'Enable Notifications',
                    style: TextStyle(
                        color: Provider.of<SettingsProvider>(context).theme ==
                                'dark'
                            ? kTextClrDark
                            : kTextClr),
                  ),
                  subtitle: Text(
                    'Check to enable notifications when a session event occurs',
                    style: TextStyle(
                        color: Provider.of<SettingsProvider>(context).theme ==
                                'dark'
                            ? Colors.white
                            : Colors.black),
                  ),
                  value: settings.notificationEnabled,
                  onChanged: (bool newValue) {
                    settings.notificationEnabled = newValue;
                  },
                ),
                Divider(
                  color: Provider.of<SettingsProvider>(context).theme == 'dark'
                      ? kTextClrDark
                      : kTextClr,
                ),
                SwitchListTile(
                  secondary: Icon(Icons.schedule,
                      color:
                          Provider.of<SettingsProvider>(context).theme == 'dark'
                              ? kTextClrDark
                              : kTextClr),
                  contentPadding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  title: Text(
                    'Enable auto break session',
                    style: TextStyle(
                        color: Provider.of<SettingsProvider>(context).theme ==
                                'dark'
                            ? kTextClrDark
                            : kTextClr),
                  ),
                  subtitle: Text(
                    'Enables automatic start of break session',
                    style: TextStyle(
                        color: Provider.of<SettingsProvider>(context).theme ==
                                'dark'
                            ? Colors.white
                            : Colors.black),
                  ),
                  value: settings.autoBreakEnabled,
                  onChanged: (bool newValue) {
                    settings.autoBreakEnabled = newValue;
                  },
                ),
                Divider(
                  color: Provider.of<SettingsProvider>(context).theme == 'dark'
                      ? kTextClrDark
                      : kTextClr,
                ),
                ListTile(
                  onTap: () {
                    showAlarmToneModal(context);
                  },
                  leading: Icon(Icons.alarm,
                      color:
                          Provider.of<SettingsProvider>(context).theme == 'dark'
                              ? kTextClrDark
                              : kTextClr),
                  title: Text(
                    'Alarm tone',
                    style: TextStyle(
                        color: Provider.of<SettingsProvider>(context).theme ==
                                'dark'
                            ? kTextClrDark
                            : kTextClr),
                  ),
                  subtitle: Text(
                    'Sets your favorite alarm tone',
                    style: TextStyle(
                        color: Provider.of<SettingsProvider>(context).theme ==
                                'dark'
                            ? Colors.white
                            : Colors.black),
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
                Divider(
                  color: Provider.of<SettingsProvider>(context).theme == 'dark'
                      ? kTextClrDark
                      : kTextClr,
                ),
                ListTile(
                  onTap: () {
                    showThemeModal(context);
                  },
                  leading: Icon(
                    Icons.color_lens,
                    color:
                        Provider.of<SettingsProvider>(context).theme == 'dark'
                            ? kTextClrDark
                            : kTextClr,
                  ),
                  title: Text(
                    'Theme',
                    style: TextStyle(
                        color: Provider.of<SettingsProvider>(context).theme ==
                                'dark'
                            ? kTextClrDark
                            : kTextClr),
                  ),
                  subtitle: Text(
                    'Change your app theme',
                    style: TextStyle(
                        color: Provider.of<SettingsProvider>(context).theme ==
                                'dark'
                            ? Colors.white
                            : Colors.black),
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

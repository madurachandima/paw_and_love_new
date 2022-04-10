import 'package:flutter/material.dart';
import 'package:paw_and_love/Config/color_config.dart';

class DogVaccineNotification extends StatelessWidget {
  final List notifications;
  const DogVaccineNotification({Key? key, required this.notifications})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Alerts'),
      content: SingleChildScrollView(
        child: ListBody(
          children: notifications
              .map((e) => Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 0,
                  child: Text(
                      "Your dog need to get vaccinate for ${e.entries.first.value.toString()}")))
              .toList(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'close',
            style: TextStyle(color: ColorConfig.textColorDark),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    ;
  }
}

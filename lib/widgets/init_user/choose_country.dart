import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nouns_flutter/controllers/initialize_user.dart';
import 'package:nouns_flutter/pallette.dart';
import 'package:country_picker/country_picker.dart';

class ChooseCountry extends StatefulWidget {
  final void Function() goToNext;
  const ChooseCountry({required this.goToNext, super.key});

  @override
  State<ChooseCountry> createState() => _ChooseCountryState();
}

class _ChooseCountryState extends State<ChooseCountry> {
  final InitializeUserController _initializeUserController = Get.find();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: _textEditingController,
            readOnly: true,
            onTap: () {
              showCountryPicker(
                context: context,
                onSelect: (Country country) {
                  _initializeUserController.country = country.countryCode;
                  _textEditingController.text =
                      "${country.flagEmoji} ${country.name}";
                },
              );
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 8, bottom: 16),
            child: Text("Select a country to be ranked in",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: darkGreyTextColor,
                    fontSize: constraints.maxHeight * 0.08)),
          ),
          Obx(() => ElevatedButton(
              onPressed: _initializeUserController.country.isNotEmpty
                  ? () {
                      widget.goToNext();
                    }
                  : null,
              child: const Text('Ok')))
        ],
      ));
    });
  }
}

import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/icon_park_twotone.dart';
import 'package:wpfamilylastseen/src/app/pages/add_number/add_number_controller.dart';
import 'package:wpfamilylastseen/src/app/widgets/default_progress_indicator.dart';
import 'package:wpfamilylastseen/src/app/widgets/home_wigets.dart';
import '../constants/colors.dart';
import 'home_page_popups.dart';

class AddNewNumberPageWidget extends StatelessWidget {
  final TextEditingController nameController, numberController;
  final bool hasSelectedItemBuilder;
  final Function? buildDropdownSelectedItemBuilder,
      buildDropdownItemWithLongText,
      buildDropdownItem;
  final Function()? jumpNext;
  final AddNumberController controller;
  const AddNewNumberPageWidget({
    Key? key,
    required this.nameController,
    required this.numberController,
    required this.hasSelectedItemBuilder,
    required this.buildDropdownSelectedItemBuilder,
    required this.buildDropdownItemWithLongText,
    required this.buildDropdownItem,
    required this.jumpNext,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double dropdownButtonWidth = 140;

    return Center(
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              standartTitle("addNumber".tr()),
              const SizedBox(height: 16.0),
              standartCaption("newPhoneCaption".tr()),
              const SizedBox(height: 24.0),
              _nameTextField(),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  _phoneCode(dropdownButtonWidth, context, controller),
                  _phoneTextField(),
                ],
              ),
              const SizedBox(height: 24.0),
              _policy(),
              const SizedBox(height: 16.0),
              _nextButton(
                context,
              ),
              const SizedBox(height: 32.0),
              _closeButton(
                context,
              )
            ],
          ),
        ),
      ),
    );
  }

  TextFieldy _nameTextField() {
    return TextFieldy(
      hint: "namedNumber".tr(),
      controller: nameController,
      type: TextInputType.text,
      icon: const Iconify(
        IconParkTwotone.edit_name,
        color: Colorize.icon,
      ),
    );
  }

  SizedBox _phoneCode(
    double dropdownButtonWidth,
    BuildContext context,
    AddNumberController controller,
  ) {
    return SizedBox(
      width: dropdownButtonWidth,
      child: CountryPickerDropdown(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        itemHeight: null,
        isDense: false,
        selectedItemBuilder: hasSelectedItemBuilder == true
            ? (Country country) => buildDropdownSelectedItemBuilder!(
                country, dropdownButtonWidth - 30)
            : null,
        itemBuilder: (Country country) => hasSelectedItemBuilder == true
            ? buildDropdownItemWithLongText!(country, dropdownButtonWidth - 30)
            : buildDropdownItem!(country, dropdownButtonWidth - 30),
        initialValue: controller.country!.toUpperCase(),
        onValuePicked: (value) {
          
          controller.statusCode(value.phoneCode);
        },
      ),
    );
  }

  Expanded _phoneTextField() {
    return Expanded(
      child: TextFieldy(
        type: TextInputType.number,
        controller: numberController,
        hint: '533 111 2233',
      ),
    );
  }

  Text _policy() {
    return Text(
      "trackingPolicy".tr(),
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 12.0, color: Colorize.icon),
    );
  }

  SizedBox _nextButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: CupertinoButton(
        borderRadius: BorderRadius.circular(8.0),
        color: Colorize.primary,
        onPressed: jumpNext,
        child: Text(
          "contin".tr(),
          style: const TextStyle(color: Colorize.black, fontSize: 16.0),
        ),
      ),
    );
  }

  Center _closeButton(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text("close".tr().toUpperCase(),
            style: const TextStyle(color: Colorize.textSec)),
      ),
    );
  }
}

class ProductListWidget extends StatelessWidget {
  final AddNumberController controller;
  final Function() onPressed;
  const ProductListWidget({
    Key? key,
    required this.controller,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              standartTitle('successfulAddNumberCaption'.tr()),
              const SizedBox(height: 50.0),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CupertinoButton(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colorize.primary,
                  // Numara ekleme yeri
                  onPressed: () {
                    controller.addNumberControl(controller.purchaseProduct!);
                  },
                  child: controller.isNumaraAdded
                      ? Text(
                          "startTracking".tr(),
                          style: const TextStyle(
                            color: Colorize.black,
                            fontSize: 16.0,
                          ),
                        )
                      : DefaultProgressIndicator(
                          color: Colors.white,
                        ),
                ),
              ),
              const SizedBox(height: 32.0),
              Center(
                child: TextButton(
                  onPressed: onPressed,
                  child: Text('back'.tr(),
                      style: TextStyle(color: Colorize.textSec)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

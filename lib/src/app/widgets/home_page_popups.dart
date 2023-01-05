import 'dart:ui';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/eva.dart';
import 'package:iconify_flutter/icons/icon_park_twotone.dart';
import 'package:wpfamilylastseen/src/app/pages/home/home_controller.dart';
import 'package:wpfamilylastseen/src/app/widgets/default_progress_indicator.dart';
import 'package:wpfamilylastseen/src/domain/entities/last_seen_numbers.dart';
import '../constants/colors.dart';
import 'home_wigets.dart';

popUpContainer(BuildContext context, Widget child) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
            builder: (context, setState) {
              return BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 4.0,
                  sigmaY: 4.0,
                ),
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 32.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colorize.black,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: child,
                  ),
                ),
              );
            },
          ));
}

standartTitle(String text) => Text(text,
    style: const TextStyle(
        fontSize: 22.0, fontWeight: FontWeight.w500, color: Colorize.text));

standartCaption(String text) =>
    Text(text, style: const TextStyle(fontSize: 12.0, color: Colorize.textSec));

successPopUp(BuildContext context) => popUpContainer(
      context,
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          standartTitle("successful".tr()),
          const SizedBox(height: 16.0),
          standartCaption("successfulAddNumberCaption".tr()),
          const SizedBox(height: 24.0),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: CupertinoButton(
              borderRadius: BorderRadius.circular(8.0),
              color: Colorize.primary,
              onPressed: () {},
              child: Text(
                "okay".toUpperCase(),
                style: const TextStyle(color: Colorize.black, fontSize: 16.0),
              ),
            ),
          ),
        ],
      ),
    );

failedPopUp(BuildContext context) => popUpContainer(
      context,
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          standartTitle("unsuccessful".tr()),
          const SizedBox(height: 16.0),
          standartCaption("unsuccessfulCaption".tr()),
          const SizedBox(height: 24.0),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: CupertinoButton(
              borderRadius: BorderRadius.circular(8.0),
              color: Colorize.red,
              onPressed: () => Navigator.pop(context),
              child: Text(
                "okay".toUpperCase(),
                style: const TextStyle(color: Colorize.black, fontSize: 16.0),
              ),
            ),
          ),
        ],
      ),
    );

editPhonePopUp(
  BuildContext context,
  LastSeenNumbers phone,
  bool notification,
  HomeController controller,
  Size size,
  bool isFavorite,
) =>
    popUpContainer(context, StatefulBuilder(
      builder: (context, setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            standartTitle("numberSettings".tr()),
            const SizedBox(height: 20.0),
            Container(
              width: size.width,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colorize.layer,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Iconify(Eva.bell_fill, color: Colorize.icon),
                    // To Do Burası dile eklenecek
                    Text(
                      "favorite".tr(),
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Switch(
                      value: isFavorite,
                      onChanged: (value) {
                        setState(() {
                          isFavorite = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              width: size.width,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colorize.layer,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Iconify(Eva.bell_fill, color: Colorize.icon),
                    Text(
                      "onlineNotification".tr(),
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Switch(
                      value: notification,
                      onChanged: (value) {
                        setState(() {
                          notification = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            TextFieldy(
              hint: "",
              icon: const Iconify(IconParkTwotone.edit_name,
                  color: Colorize.icon),
              controller: controller.nameController,
              type: null,
              suffix: null,
              enabled: true,
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CupertinoButton(
                borderRadius: BorderRadius.circular(8.0),
                color: Colorize.primary,
                onPressed: () {
                  controller.editNumber(
                      controller.nameController.text,
                      !notification ? "0" : "1",
                      phone.id.toString(),
                      !isFavorite ? "0" : "1");
                },
                child: Text(
                  "okay".tr(),
                  style: const TextStyle(color: Colorize.black, fontSize: 16.0),
                ),
              ),
            ),
            const Divider(color: Colorize.layer, height: 32.0),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CupertinoButton(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colorize.layer,
                  onPressed: () {
                    controller.removeNumber(phone.id.toString());
                  },
                  child: controller.isDeleted
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Iconify(Carbon.trash_can,
                                size: 20.0, color: Colorize.red),
                            const SizedBox(width: 8.0),
                            Text(
                              "removeNumber".tr(),
                              style: const TextStyle(
                                  color: Colorize.red, fontSize: 16.0),
                            ),
                          ],
                        )
                      : DefaultProgressIndicator()),
            ),
            const SizedBox(height: 16.0),
            standartCaption("removeNumberCaption".tr()),
            const SizedBox(height: 8.0),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "close".tr().toUpperCase(),
                style: const TextStyle(color: Colorize.textSec),
              ),
            ),
          ],
        );
      },
    ));

newPhoneAddPopUp(BuildContext context, addingFieldName, addingFieldNumber,
    onPhoneCodePicked, Function()? onPressed,
    {bool filtered = false,
    bool sortedByIsoCode = false,
    bool hasPriorityList = false,
    bool hasSelectedItemBuilder = false}) {
  double dropdownButtonWidth = 140;
  double dropdownItemWidth = dropdownButtonWidth - 30;
  double dropdownSelectedItemWidth = dropdownButtonWidth - 30;

  return popUpContainer(
    context,
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        standartTitle("addNumber".tr()),
        const SizedBox(height: 16.0),
        standartCaption("newPhoneCaption".tr()),
        const SizedBox(height: 24.0),
        // TextFieldy(
        //     type: TextInputType.text,
        //     controller: addingFieldName,
        //     hint: AppLocalizations.of(context).namedNumber,
        //     icon:
        //         const Iconify(IconParkTwotone.edit_name, color: Colorize.icon)),
        const SizedBox(height: 8.0),
        Row(
          children: [
            SizedBox(
              width: dropdownButtonWidth,
              child: CountryPickerDropdown(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                itemHeight: null,
                isDense: false,
                selectedItemBuilder: hasSelectedItemBuilder == true
                    ? (Country country) => _buildDropdownSelectedItemBuilder(
                        country, dropdownSelectedItemWidth)
                    : null,
                itemBuilder: (Country country) => hasSelectedItemBuilder == true
                    ? _buildDropdownItemWithLongText(country, dropdownItemWidth)
                    : _buildDropdownItem(country, dropdownItemWidth),
                initialValue:
                    Localizations.override(context: context).locale.countryCode,
                onValuePicked: onPhoneCodePicked,
              ),
            ),
            // Expanded(
            //     child: TextFieldy(
            //   type: TextInputType.number,
            //   controller: addingFieldNumber,
            //   hint: '533 111 22 33',
            // )),
          ],
        ),
        const SizedBox(height: 24.0),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: CupertinoButton(
            borderRadius: BorderRadius.circular(30.0),
            color: Colorize.primary,
            onPressed: onPressed,
            child: Text(
              "startTracking".tr(),
              style: const TextStyle(color: Colorize.black, fontSize: 16.0),
            ),
          ),
        ),
        const SizedBox(height: 24.0),
        Text(
          "trackingPolicy".tr(),
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12.0, color: Colorize.icon),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("close".tr().toUpperCase(),
                  style: const TextStyle(color: Colorize.textSec))),
        ),
      ],
    ),
  );
}

Widget _buildDropdownItem(Country country, double dropdownItemWidth) =>
    SizedBox(
      width: dropdownItemWidth,
      child: Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          const SizedBox(
            width: 8.0,
          ),
          Expanded(child: Text("+${country.phoneCode}(${country.isoCode})")),
        ],
      ),
    );
Widget _buildDropdownSelectedItemBuilder(
        Country country, double dropdownItemWidth) =>
    SizedBox(
        width: dropdownItemWidth,
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                CountryPickerUtils.getDefaultFlagImage(country),
                const SizedBox(width: 8.0),
                Expanded(
                    child: Text(
                  country.name,
                  style: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                )),
              ],
            )));

Widget _buildDropdownItemWithLongText(
        Country country, double dropdownItemWidth) =>
    SizedBox(
      width: dropdownItemWidth,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(child: Text(country.name)),
          ],
        ),
      ),
    );

showDatePopUp(context, currentDate, onDateTimeChanged) => popUpContainer(
      context,
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            child: CupertinoDatePicker(
              initialDateTime: currentDate,
              dateOrder: DatePickerDateOrder.dmy,
              maximumDate: DateTime.now(),
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: onDateTimeChanged,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: CupertinoButton(
              borderRadius: BorderRadius.circular(8.0),
              color: Colorize.primary,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "filter".tr(),
                style: const TextStyle(color: Colorize.black, fontSize: 16.0),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("close".toUpperCase(),
                  style: const TextStyle(color: Colorize.textSec))),
        ],
      ),
    );

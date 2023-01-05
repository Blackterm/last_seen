import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/akar_icons.dart';
import 'package:wpfamilylastseen/src/app/pages/add_number/add_number_controller.dart';
import 'package:wpfamilylastseen/src/data/repositories/data_home_page_repository.dart';
import '../../constants/colors.dart';
import '../../widgets/packages_widgets.dart';

class AddNumberView extends View {
  @override
  State<StatefulWidget> createState() {
    return _AddNumberViewState(AddNumberController(DataHomePageRepository()));
  }
}

class _AddNumberViewState
    extends ViewState<AddNumberView, AddNumberController> {
  _AddNumberViewState(AddNumberController controller) : super(controller);

  bool hasSelectedItemBuilder = false;

  @override
  Widget get view {
    return Scaffold(
      key: globalKey,
      body: ControlledWidgetBuilder<AddNumberController>(
          builder: (context, controller) {
        return PageView(
          controller: controller.pageController,
          onPageChanged: controller.pagejumpController,
          physics: const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
          children: [
            ProductSalesView(
              controller: controller,
              pageController: controller.pageController,
              pageIndex: controller.pageIndex,
            ),
            AddNewNumberPageWidget(
              nameController: controller.nameController,
              numberController: controller.numberController,
              hasSelectedItemBuilder: hasSelectedItemBuilder,
              buildDropdownSelectedItemBuilder:
                  _buildDropdownSelectedItemBuilder,
              buildDropdownItemWithLongText: _buildDropdownItemWithLongText,
              buildDropdownItem: _buildDropdownItem,
              jumpNext: () {
                controller.addNumberCheck();
              },
              controller: controller,
            ),
            ProductListWidget(
              controller: controller,
              onPressed: () => controller.pageController
                  .jumpToPage(controller.pageIndex - 1),
            ),
          ],
        );
      }),
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

  Row options(String text) => Row(
        children: [
          const Iconify(
            AkarIcons.circle_check_fill,
            color: Colorize.primary,
            size: 18.0,
          ),
          const SizedBox(width: 8.0),
          Text(text),
        ],
      );
}

class ProductSalesView extends StatelessWidget {
  final PageController pageController;
  final int pageIndex;
  final AddNumberController controller;
  const ProductSalesView({
    super.key,
    required this.pageController,
    required this.pageIndex,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    EdgeInsets padding = MediaQuery.of(context).padding;
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      child: Container(
        height: size.height,
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: padding.top + 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              standartTitle("pricesOptionsTitle".tr()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16.0),
                  options("freeTrialLabel1".tr()),
                  const SizedBox(height: 8.0),
                  options("freeTrialLabel2".tr()),
                  const SizedBox(height: 8.0),
                  options("freeTrialLabel3".tr()),
                ],
              ),
              SizedBox(
                height: padding.top + 20,
              ),
              controller.products.length != 0
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: GridView.builder(
                        primary: false,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1 / 1,
                          crossAxisCount: 3,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: controller.products.length,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            controller.purchaseControl(
                                controller.products[index].productDetails !=
                                        null
                                    ? controller
                                        .products[index].productDetails!.id
                                    : controller.products[index].sku!,
                                controller.products[index].isDemo);
                          },
                          borderRadius: BorderRadius.circular(16.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colorize.primary,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    (controller.products[index]
                                                .productDetails ==
                                            null
                                        ? controller.products[index].name!
                                        : controller.products[index]
                                            .productDetails!.title
                                            .toUpperCase()),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                      (controller.products[index]
                                                  .productDetails ==
                                              null
                                          ? controller.products[index].line1!
                                          : controller.products[index]
                                              .productDetails!.description
                                              .toUpperCase()),
                                      style: const TextStyle(fontSize: 10.0)),
                                  Text(
                                    (controller.products[index]
                                                .productDetails ==
                                            null
                                        ? 'free'.tr()
                                        : controller.products[index]
                                            .productDetails!.price
                                            .toUpperCase()),
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : SpinKitPouringHourGlass(
                      color: Colorize.primary,
                      size: size.height * 0.06,
                    ),
              Spacer(),
              const SizedBox(height: 16.0),
              standartCaption("pricesOptionsCaption".tr()),
              SizedBox(
                height: 10,
              ),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("close".tr().toUpperCase(),
                      style: const TextStyle(color: Colorize.textSec)),
                ),
              ),
              SizedBox(
                height: padding.bottom + 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  standartCaption(String text) => Text(text,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 12.0, color: Colorize.textSec));

  standartTitle(String text) => Text(text,
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontSize: 22.0, fontWeight: FontWeight.w500, color: Colorize.text));
}

Row options(String text) => Row(
      children: [
        const Iconify(AkarIcons.circle_check_fill, color: Colorize.primary),
        const SizedBox(width: 8.0),
        Text(text),
      ],
    );

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:country_codes/country_codes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wpfamilylastseen/src/app/pages/add_number/add_number_presenter.dart';
import 'package:wpfamilylastseen/src/domain/entities/add_number.dart';
import 'package:wpfamilylastseen/src/domain/entities/last_seen_product.dart';
import 'package:wpfamilylastseen/src/domain/entities/purchase_control.dart';
import 'package:wpfamilylastseen/src/domain/entities/purchase_local_verification_data.dart';
import 'package:wpfamilylastseen/src/domain/entities/user_purchase_detail.dart';
import '../../../data/helpers/notification_service.dart';
import '../../../domain/entities/last_seen_settings.dart';
import '../../../domain/repositories/home_page_repository.dart';
import '../../widgets/default_loading_view.dart';
import '../../widgets/default_notification_banner.dart';
import '../home/home_view.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

class AddNumberController extends Controller {
  final AddNumberPresenter _presenter;

  AddNumberController(HomePageRepository homePageRepository)
      : _presenter = AddNumberPresenter(homePageRepository);

  SharedPreferences? sharedPreferences;

  String? country;
  String? countryCode;
  String? deviceImei;

  String? purchaseProduct;

  int pageIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  bool isListFetched = false;
  bool isNumaraAdded = true;
  bool? useDemo;
  bool? userUsingDemo;

  AddNumber? addNumber;
  List<LastSeenProduct>? lastSeenProduct;
  var deviceToken;

  List<String>? appStoreControlList = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  InAppPurchase? inAppPurchase;
  PurchaseParam? purchaseParam;
  PurchaseControl? purchaseControlList;
  LastSeenSettings? lastSeenSettings;

  PurchaseLocalVerificationData? purchaseTokenControl;

  ProductDetailsResponse? productDetailResponse;

  List<ApiGoogleProduct> products = [];

  UserPurchaseDetail? userPurchaseDetail;

  late StreamSubscription<List<PurchaseDetails>> _subscription;

  @override
  void onInitState() async {
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.getString('deviceImei') != null
        ? deviceImei = sharedPreferences!.getString('deviceImei')
        : null;
    await sharedPreferences!.getBool('useDemo') != null
        ? useDemo = sharedPreferences!.getBool('useDemo')
        : null;

    inAppPurchase = InAppPurchase.instance;

    deviceToken = await NotifService.getToken();

    final Stream<List<PurchaseDetails>> purchaseUpdated =
        inAppPurchase!.purchaseStream;
    _subscription = purchaseUpdated.listen(
      (List<PurchaseDetails> purchaseDetailsList) {
        _listenToPurchaseUpdated(purchaseDetailsList);
      },
    );
    _presenter.getSettings(deviceImei!);

    CountryDetails details = CountryCodes.detailsForLocale();

    country = details.alpha2Code;
    countryCode = details.dialCode!.substring(1);
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        PurchaseLocalVerificationData a =
            PurchaseLocalVerificationData.fromJson(jsonDecode(
                purchaseDetails.verificationData.localVerificationData));
        _presenter.getGetPurchaseControl(
            purchaseDetails.productID, a.purchaseToken!);

        purchaseProduct = purchaseDetails.productID;

        userPurchaseDetail = UserPurchaseDetail(
          error: purchaseDetails.error.toString(),
          pendingCompletePurchase:
              purchaseDetails.pendingCompletePurchase.toString(),
          productID: purchaseDetails.productID.toString(),
          purchaseID: purchaseDetails.purchaseID.toString(),
          status: purchaseDetails.status.toString(),
          transactionDate: purchaseDetails.transactionDate.toString(),
          source: purchaseDetails.verificationData.source,
          localVerificationData:
              purchaseDetails.verificationData.localVerificationData,
          serverVerificationData:
              purchaseDetails.verificationData.serverVerificationData,
        );
        DefaultLoadingDialog(
          text: "userpurchasecontrol".tr(),
          context: getContext(),
        ).show();
        refreshUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          DefaultNotificationBanner(
                  icon: Icon(Icons.error_outline),
                  text: "somethingswentwrong".tr(),
                  color: Colors.red,
                  context: getContext())
              .show();
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          PurchaseLocalVerificationData a =
              PurchaseLocalVerificationData.fromJson(jsonDecode(
                  purchaseDetails.verificationData.localVerificationData));

          purchaseProduct = purchaseDetails.productID;

          _presenter.getGetPurchaseControl(
              purchaseDetails.productID, a.purchaseToken!);

          userPurchaseDetail = UserPurchaseDetail(
            error: purchaseDetails.error.toString(),
            pendingCompletePurchase:
                purchaseDetails.pendingCompletePurchase.toString(),
            productID: purchaseDetails.productID.toString(),
            purchaseID: purchaseDetails.purchaseID.toString(),
            status: purchaseDetails.status.toString(),
            transactionDate: purchaseDetails.transactionDate.toString(),
            source: purchaseDetails.verificationData.source,
            localVerificationData:
                purchaseDetails.verificationData.localVerificationData,
            serverVerificationData:
                purchaseDetails.verificationData.serverVerificationData,
          );

          DefaultLoadingDialog(
            text: "userpurchasecontrol".tr(),
            context: getContext(),
          ).show();

          refreshUI();
        }
      }
    }
  }

  @override
  void initListeners() {
    _presenter.addNumbersOnNext = (AddNumber? response) async {
      if (response == null) return;
      if (!isListFetched) {
        if (response.name != null) {
          isNumaraAdded = true;
          userUsingDemo != null
              ? userUsingDemo == true
                  ? sharedPreferences!.setBool("useDemo", true)
                  : null
              : null;
          refreshUI();
          Navigator.pushAndRemoveUntil(
              (getContext()),
              CupertinoPageRoute(builder: (context) => HomeView()),
              (route) => false);
          return;
        }
      }
    };
    _presenter.settingsOnNext = (LastSeenSettings? response) {
      if (response == null) return;
      if (!isListFetched) {
        lastSeenSettings = response;
        refreshUI();
        _presenter.getProducts(deviceImei!);
      }
    };

    _presenter.getProductOnNext = (List<LastSeenProduct>? response) async {
      if (response == null) return;
      if (!isListFetched) {
        lastSeenProduct = response;

        for (var i = 0; i < lastSeenProduct!.length; i++) {
          lastSeenProduct![i].isDemo == false
              ? appStoreControlList!.add(lastSeenProduct![i].sku!)
              : null;
        }

        productDetailResponse = await inAppPurchase!
            .queryProductDetails(appStoreControlList!.toSet());

        response.forEach((fakeProduct) {
          if (fakeProduct.isDemo == false) {
            products.add(
              ApiGoogleProduct(
                name: fakeProduct.name,
                sku: fakeProduct.sku,
                line1: fakeProduct.line1,
                isDemo: fakeProduct.isDemo,
                is_inapp: fakeProduct.is_inapp,
                trackHour: fakeProduct.trackHour,
                productDetails: productDetailResponse!.productDetails
                    .firstWhere(
                        (subElement) => subElement.id == fakeProduct.sku),
              ),
            );
          } else {
            if (lastSeenSettings != null) {
              lastSeenSettings!.isShowDemo != 0
                  ? products.add(
                      ApiGoogleProduct(
                          name: fakeProduct.name,
                          sku: fakeProduct.sku,
                          line1: fakeProduct.line1,
                          isDemo: fakeProduct.isDemo,
                          is_inapp: fakeProduct.is_inapp,
                          trackHour: fakeProduct.trackHour,
                          productDetails: null),
                    )
                  : null;
              return;
            }
            return;
          }
        });

        /*productDetailResponse = await inAppPurchase!
            .queryProductDetails(appStoreControlList!.toSet())
            .then((value) {
          response.forEach((fakeProduct) {
            if (fakeProduct.isDemo == false) {
              products.add(
                ApiGoogleProduct(
                  name: fakeProduct.name,
                  sku: fakeProduct.sku,
                  line1: fakeProduct.line1,
                  isDemo: fakeProduct.isDemo,
                  is_inapp: fakeProduct.is_inapp,
                  trackHour: fakeProduct.trackHour,
                  productDetails: productDetailResponse!.productDetails
                      .firstWhere(
                          (subElement) => subElement.id == fakeProduct.sku),
                ),
                
              );
              refreshUI();
            } else {
              products.add(
                ApiGoogleProduct(
                    name: fakeProduct.name,
                    sku: fakeProduct.sku,
                    line1: fakeProduct.line1,
                    isDemo: fakeProduct.isDemo,
                    is_inapp: fakeProduct.is_inapp,
                    trackHour: fakeProduct.trackHour),
              );
              refreshUI();
            }
          });
          refreshUI();
        });*/

        refreshUI();
      }
    };

    _presenter.getPurchaseControlOnNext = (PurchaseControl? response) async {
      if (response == null) return;
      if (!isListFetched) {
        if (response.error == 0) {
          Navigator.pop(getContext());
          pageController.jumpToPage(pageIndex + 1);
        } else {
          Navigator.pop(getContext());
          DefaultNotificationBanner(
                  icon: Icon(Icons.error_outline),
                  text: "somethingswentwrong".tr(),
                  color: Colors.red,
                  context: getContext())
              .show();
        }

        refreshUI();
      }
    };

    _presenter.addNumbersOnError = (e) {
      DefaultNotificationBanner(
              icon: Icon(Icons.error_outline),
              text: "somethingswentwrong".tr(),
              color: Colors.red,
              context: getContext())
          .show();
      isNumaraAdded = true;
      refreshUI();
    };

    _presenter.settingsOnError = (e) {
      print(e);
    };
  }

  void addNumberControl(String sku) {
    _presenter.postAddNumber(
        sku,
        nameController.text,
        numberController.text,
        countryCode!,
        deviceToken,
        userPurchaseDetail != null
            ? userPurchaseDetail!.toJson().toString()
            : {}.toString(),
        deviceImei!);
    isNumaraAdded = false;
    refreshUI();
  }

  void statusCode(String value) {
    countryCode = value;
    refreshUI();
  }

  void pagejumpController(value) {
    pageIndex = value;
    refreshUI();
  }

  void addNumberCheck() {
    if (nameController.text.isNotEmpty &&
        numberController.text.isNotEmpty &&
        numberController.text.length > 9) {
      pageController.jumpToPage(pageIndex + 1);
    } else {
      nameController.text.isEmpty
          ? Fluttertoast.showToast(msg: 'pleasefillinallfields'.tr())
          : numberController.text.length < 10
              ? Fluttertoast.showToast(msg: 'lessthan10characters'.tr())
              : null;
    }
  }

  void purchaseControl(String Id, bool isDemo) async {
    if (isDemo) {
      if (useDemo!) {
        DefaultNotificationBanner(
                icon: Icon(Icons.error_outline),
                text: "freeversionbefore".tr(),
                color: Colors.red,
                context: getContext())
            .show();
        return;
      } else {
        purchaseProduct = Id;
        userUsingDemo = true;
        refreshUI();
        pageController.jumpToPage(pageIndex + 1);

        return;
      }
    } else {
      final currentProduct = productDetailResponse!.productDetails
          .firstWhere((element) => element.id == Id);

      var serverProduct =
          lastSeenProduct!.firstWhere((element) => element.sku == Id);

      var purchaseParam = null;
      if (Platform.isAndroid) {
        purchaseParam = await GooglePlayPurchaseParam(
            productDetails: currentProduct, changeSubscriptionParam: null);
      } else {
        purchaseParam = await PurchaseParam(
          productDetails: currentProduct,
        );
        return;
      }

      if (serverProduct.is_inapp!) {
        inAppPurchase!.buyNonConsumable(purchaseParam: purchaseParam);
        return;
      } else {
        inAppPurchase!
            .buyConsumable(purchaseParam: purchaseParam, autoConsume: true);
        return;
      }
    }
  }
}

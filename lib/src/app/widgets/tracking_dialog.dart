import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wpfamilylastseen/src/app/pages/home/home_controller.dart';
import '../constants/colors.dart';

class TrackingDialog extends StatelessWidget {
  final Function() slowlyFollow;
  final Function() fastFollow;
  final HomeController controller;
  TrackingDialog({
    Key? key,
    required this.slowlyFollow,
    required this.fastFollow,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EdgeInsets padding = MediaQuery.of(context).padding;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: padding.top,
                    ),
                    SizedBox(height: size.height * 0.12),
                    Text(
                      "trackingTitle".tr(),
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w500,
                          color: Colorize.text),
                    ),
                    SizedBox(height: size.height * 0.12),
                    controller.lastSeenSettings!.use_speedy != 0
                        ? Column(
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(8.0),
                                onTap: fastFollow,
                                child: Container(
                                  width: size.width,
                                  height: size.height * 0.07,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colorize.primary,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "fastFollow".tr(),
                                      style: const TextStyle(
                                          color: Colorize.black,
                                          fontSize: 16.0),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Text("fastContent".tr(),
                                  style: const TextStyle(
                                      fontSize: 12.0, color: Colorize.textSec)),
                            ],
                          )
                        : Container(),
                    SizedBox(height: size.height * 0.12),
                    controller.lastSeenSettings!.use_slowly != 0
                        ? Column(
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(8.0),
                                onTap: slowlyFollow,
                                child: Container(
                                  width: size.width,
                                  height: size.height * 0.07,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colorize.primary,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "slowlyFollow".tr(),
                                      style: const TextStyle(
                                          color: Colorize.black,
                                          fontSize: 16.0),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Text("slowlyContent".tr(),
                                  style: const TextStyle(
                                      fontSize: 12.0, color: Colorize.textSec)),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("close".tr().toUpperCase(),
                    style: const TextStyle(color: Colorize.textSec))),
          ),
          SizedBox(
            height: padding.bottom,
          ),
        ],
      ),
    );
  }
}

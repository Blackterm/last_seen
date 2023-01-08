import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class TrackingDialog extends StatelessWidget {
  const TrackingDialog({
    Key? key,
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
                      'Lütfen takip etmek için aşağıdaki seçeneklerden birini seçiniz. 🤗 👇',
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w500,
                          color: Colorize.text),
                    ),
                    SizedBox(height: size.height * 0.12),
                    InkWell(
                      borderRadius: BorderRadius.circular(8.0),
                      onTap: () {},
                      child: Container(
                        width: size.width,
                        height: size.height * 0.07,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colorize.primary,
                        ),
                        child: Center(
                          child: Text(
                            "Hızlı Takip",
                            style: const TextStyle(
                                color: Colorize.black, fontSize: 16.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                        "Hızlı takip edebilmek için kullandığınız WhatsApp uygulamasının karekodunu yönlendilirdiğiniz sayfaya okutmanız gerekiyor. Okuma işlemi başarılı tamamladıktan sonra artık dilediğiniz numarayı anlık olarak takip edebileceksiniz.🥳 ",
                        style: const TextStyle(
                            fontSize: 12.0, color: Colorize.textSec)),
                    SizedBox(height: size.height * 0.12),
                    InkWell(
                      borderRadius: BorderRadius.circular(8.0),
                      onTap: () {},
                      child: Container(
                        width: size.width,
                        height: size.height * 0.07,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colorize.primary,
                        ),
                        child: Center(
                          child: Text(
                            "Yavaş Takip",
                            style: const TextStyle(
                                color: Colorize.black, fontSize: 16.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                        "Numarayı takip edebilmek için ortalama 2-3 hafta kadar kadar beklemeniz gerekmektedir ardından yavaş takip ile takip etmek istediğiniz numarayı takip edebileceksiniz. 😍",
                        style: const TextStyle(
                            fontSize: 12.0, color: Colorize.textSec)),
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

import 'package:calc_triangle/constant/assets_const.dart';
import 'package:calc_triangle/localization/translate_helper.dart';
import 'package:calc_triangle/theme/app_color_codes.dart';
import 'package:calc_triangle/ui/pages/color_change/color_change_p.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;

    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Spacer(),
            Image.asset(AssetsConst.welcomeImage),
            Text(
              TranslateHelper.appName,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1!.color,
                letterSpacing: 2.0,
                fontSize: 38.0,
                fontWeight: FontWeight.bold,
                shadows: isDark == true
                //тень взависимости от темы
                    ? <Shadow>[
                        const Shadow(
                          offset: Offset(5.0, 5.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(25, 255, 255, 255),
                        ),
                        const Shadow(
                          offset: Offset(5.0, 5.0),
                          blurRadius: 5.0,
                          color: Color.fromARGB(25, 0, 0, 255),
                        ),
                      ]
                    : <Shadow>[
                        const Shadow(
                          offset: Offset(5.0, 5.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(25, 0, 0, 0),
                        ),
                        const Shadow(
                          offset: Offset(5.0, 5.0),
                          blurRadius: 5.0,
                          color: Color.fromARGB(25, 0, 0, 255),
                        ),
                      ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                TranslateHelper.appNameSub,
                textAlign: TextAlign.center,
                style: TextStyle(
                    letterSpacing: 1.5,
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(0.8)),
              ),
            ),
            const Divider(
              color: Colors.grey,
              height: 30,
              indent: 50,
              endIndent: 50,
            ),
            const Spacer(
              flex: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: RawMaterialButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ColorChangePage())),
                child: Text(
                  TranslateHelper.chooseTheme,
                  style: isDark == true
                      ? const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          letterSpacing: 4,
                          fontWeight: FontWeight.bold,
                        )
                      : const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          letterSpacing: 4,
                          fontWeight: FontWeight.bold,
                        ),
                ),
                elevation: 5.0,
                constraints:
                    BoxConstraints(minWidth: size.width * 0.9, minHeight: 42.0),
                padding: const EdgeInsets.all(kDefaultPadding),
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(kDefaultRadius / 2))),
                fillColor: Theme.of(context).textTheme.bodyText1!.color,
              ),
            )
          ],
        ),
      ),
    );
  }
}

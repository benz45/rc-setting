import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:rc_setting/components/window_buttons.dart';
import 'package:rc_setting/pages/info_page.dart';
import 'package:rc_setting/pages/setting_display_page.dart';
import 'package:rc_setting/pages/setting_general_page.dart';
import 'package:rc_setting/pages/setting_sound_page.dart';
import 'package:rc_setting/provider/menu_provider.dart';
import 'package:provider/provider.dart';

class RightSide extends StatefulWidget {
  const RightSide({
    super.key,
  });

  @override
  State<RightSide> createState() => _RightSideState();
}

class _RightSideState extends State<RightSide> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          WindowTitleBarBox(
            child: Row(
              children: [
                Expanded(child: MoveWindow()),
                const WindowButtons(),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 32,
            width: double.infinity,
            child: const PageViewContent(),
          )
        ],
      ),
    );
  }
}

class PageViewContent extends StatefulWidget {
  const PageViewContent({super.key});

  @override
  State<PageViewContent> createState() => _PageViewContentState();
}

class _PageViewContentState extends State<PageViewContent>
    with TickerProviderStateMixin {
  late MenuProvider _menuProvider;

  @override
  void initState() {
    super.initState();
    _menuProvider = context.read<MenuProvider>();
    _menuProvider.init(this);
  }

  @override
  Widget build(BuildContext context) {
    MenuProvider menuProvider = Provider.of<MenuProvider>(context);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        PageView(
          controller: menuProvider.pageViewController,
          children: const <Widget>[
            SettingGeneralPage(
              key: PageStorageKey('SettingGeneralPage'),
            ),
            SettingDisplayPage(
              key: PageStorageKey('SettingDisplayPage'),
            ),
            SettingSoundPage(
              key: PageStorageKey('SettingSoundPage'),
            ),
            InfoPage(
              key: PageStorageKey('InfoPage'),
            ),
          ],
        ),
      ],
    );
  }
}

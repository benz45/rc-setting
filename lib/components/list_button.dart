import 'package:flutter/material.dart';
import 'package:rc_setting/config/menu_list_config.dart';
import 'package:rc_setting/provider/menu_provider.dart';
import 'package:rc_setting/theme.dart';
import 'package:provider/provider.dart';

class ListButton extends StatelessWidget {

  const ListButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    MenuProvider menuProvider = context.watch<MenuProvider>();
    return ListView.builder(
      itemCount: menuListConfig.length,
      itemBuilder: (context, index) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            backgroundColor: menuProvider.selectedIndex == index
                ? darkTheme.hintColor
                : Colors.black12,
          ),
          onPressed: () {
            menuProvider.updateCurrentPageIndex(index);
          },
          child: Text(menuListConfig[index]),
        );
      },
    );
  }
}

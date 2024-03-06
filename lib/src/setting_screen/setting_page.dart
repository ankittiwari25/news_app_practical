import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/src/setting_screen/setting_controller.dart';
import 'package:news_app/utils/app_color.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    SettingController themeController = Get.put(SettingController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.light_gray,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: AppColor.white,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Settings",
                      style: TextStyle(fontSize: 24, color: AppColor.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(80),
                          child: Image.network(
                            'https://wallpaperaccess.com/full/2637581.jpg',
                            fit: BoxFit.fill,
                            height: 80,
                            width: 80,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Shoeb Shaikh',
                              style: TextStyle(
                                color: AppColor.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              'Shoeb Shaikh@gmail.com',
                              style: TextStyle(
                                color: AppColor.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Sign Out',
                              style: TextStyle(
                                color: AppColor.dark_orange,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Obx(() {
                      return getRadioItem(
                          name: 'Dark Mode',
                          defaultValue: themeController.isDarkMode.value,
                          onChanged: (update) {
                            themeController.toggleTheme(update);
                          });
                    }),
                    getDivider(),
                    getRadioItem(
                        name: 'Notifications',
                        defaultValue: false,
                        onChanged: (update) {
                          // themeController.toggleTheme(update);
                        })
                  ],
                ),
              ),
              getTitle('Account'),
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    getRedirectItem(name: "Edit Account"),
                    getDivider(),
                    getRedirectItem(name: "Change Password"),
                    getDivider(),
                    getRedirectItem(name: "Language"),
                  ],
                ),
              ),
              getTitle('Privacy and Security'),
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    getRadioItem(
                        name: 'Private Account',
                        defaultValue: false,
                        onChanged: (update) {
                          // themeController.toggleTheme(update);
                        }),
                    getDivider(),
                    getRedirectItem(name: "Privacy and Security Help"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getRadioItem({required String name, required bool defaultValue, required Function(bool) onChanged}) {
    return Row(
      children: [
        Text(
          name,
          style: const TextStyle(color: AppColor.black, fontSize: 12, fontWeight: FontWeight.w500),
        ),
        Spacer(),
        SizedBox(
          width: 60,
          height: 20,
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: CupertinoSwitch(
              value: defaultValue,
              onChanged: (bool value) {
                onChanged(value);
              },
            ),
          ),
        )
      ],
    );
  }

  Widget getRedirectItem({
    required String name,
  }) {
    return Row(
      children: [
        Text(
          name,
          style: TextStyle(
            color: AppColor.black,
            fontSize: 12,
          ),
        ),
        Spacer(),
        Icon(
          Icons.chevron_right,
          size: 18,
          color: AppColor.black,
        )
      ],
    );
  }

  Widget getDivider() {
    return const Divider(
      height: 18,
      thickness: 1,
      color: AppColor.light_gray,
    );
  }

  Widget getTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColor.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:filepicker_windows/filepicker_windows.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rc_setting/business/encrypter_business.dart';
import 'package:rc_setting/business/page_business.dart';
import 'package:rc_setting/components/box_detail.dart';
import 'package:rc_setting/components/snack_bar_alert.dart';
import 'package:rc_setting/constant/directory_constant.dart';
import 'package:rc_setting/images_path.dart';
import 'package:rc_setting/model/access_token_model.dart';
import 'package:rc_setting/provider/activate_provider.dart';
import 'package:rc_setting/service/google_sheet_service.dart';
import 'package:rc_setting/theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class SettingGeneralPage extends StatefulWidget {
  const SettingGeneralPage({super.key});

  @override
  State<SettingGeneralPage> createState() => _SettingGeneralPageState();
}

class _SettingGeneralPageState extends State<SettingGeneralPage> {
  String? _settingPath;
  String? _settingConfigPath;
  String? _userDomain;
  String? fullScreenWidth;
  bool isLoadingSearchToken = false;
  bool isLoadingDeleteAccessToken = false;
  bool isViewToken = false;
  final searchTokenController = TextEditingController();
  String searchTokenState = '';
  late ActivateProvider _activateProvider;
  late SnackBarAlert _snackBarAlert;
  late EncrypterBusiness _encrypterBusiness;
  final GoogleSheetService _googleSheetService = GoogleSheetService();

  @override
  void initState() {
    super.initState();
    PageBusiness(context, widget.key).mounted(() {});
    localSettingPath();
    _encrypterBusiness = EncrypterBusiness();
    isLoadingSearchToken = false;
    searchTokenController.addListener(
        () => setState(() => searchTokenState = searchTokenController.text));
    _activateProvider = context.read<ActivateProvider>();
    _snackBarAlert = SnackBarAlert(context);
  }

  @override
  void dispose() {
    searchTokenController.dispose();
    super.dispose();
  }

  void localSettingPath() async {
    Map<String, String> envVars = Platform.environment;
    if (Platform.isWindows) {
      _userDomain = envVars['USERDOMAIN'];
    }

    final directory = await getApplicationDocumentsDirectory();
    final path =
        Directory('${directory.path}/$DOCUMENTS_DIRECTORY_FOLDER_NAME');
    if (!await path.exists()) {
      path.create();
    }
    _settingPath = path.path;
    if (_settingPath != null) {
      localSettingTempPath();
      getActivate();
    }
    setState(() {});
  }

  void localSettingTempPath() async {
    final file = File('$_settingPath/$PATH_CONFIG_FILE_NAME');
    final isExits = await file.exists();
    if (isExits) {
      final pathConfigContent = await file.readAsString();
      _settingConfigPath = pathConfigContent;
    }

    setState(() {});
  }

  void onViewToken() {
    setState(() {
      isViewToken = !isViewToken;
    });
  }

  void getActivate() async {
    final File activateFile = File('$_settingPath/$ACTIVATE_FILE_NAME');
    final bool isActivateFileExist = await activateFile.exists();
    if (isActivateFileExist) {
      final String encrypted = await activateFile.readAsString();
      final String token = _encrypterBusiness.decrypt(encrypted);
      try {
        final jwt = JWT.verify(
            token, SecretKey('${dotenv.env['JWT_ACTIVATE_SECRET']}'));
        final localToken = jwt.payload['token'] as String;
        final localUpdatedAt = jwt.payload['updatedAt'] as String;
        final localUpdatedBy = jwt.payload['updatedBy'] as String;
        AccessTokenModel? tokenObj =
            await _googleSheetService.fetchAccessTokenByToken(localToken);
        if (tokenObj != null) {
          if (localUpdatedAt != tokenObj.updatedAt ||
              localUpdatedBy != tokenObj.updatedBy) {
            final jwt = JWT(tokenObj);
            final newToken =
                jwt.sign(SecretKey('${dotenv.env['JWT_ACTIVATE_SECRET']}'));
            if (_settingPath != null) {
              final file = File('${_settingPath!}/$ACTIVATE_FILE_NAME');
              final String newTokenEncrypted =
                  _encrypterBusiness.encrypt(newToken);
              await file.writeAsString(newTokenEncrypted);
            }
          }
          _activateProvider.setActivated(tokenObj);
        }
      } on JWTExpiredException {
        print('jwt expired');
      } on JWTException catch (ex) {
        print(ex.message);
      }
    }
  }

  void postAccessTokenByToken(String token) async {
    setState(() => isLoadingSearchToken = true);
    try {
      AccessTokenModel? accessToken =
          await _googleSheetService.updateAccessToken(token, _userDomain ?? '');
      if (accessToken == null) {
        _snackBarAlert.snackBarAlertError('ไม่พบรหัสโค้ดนี้');
        setState(() => isLoadingSearchToken = false);
      } else {
        final jwt = JWT(accessToken);
        final token =
            jwt.sign(SecretKey('${dotenv.env['JWT_ACTIVATE_SECRET']}'));
        _activateProvider.setActivated(accessToken);
        if (_settingPath != null) {
          final file = File('${_settingPath!}/$ACTIVATE_FILE_NAME');
          final String tokenRncrypted = _encrypterBusiness.encrypt(token);
          await file.writeAsString(tokenRncrypted);
        }
        setState(() => isLoadingSearchToken = false);
        _snackBarAlert.snackBarAlertSuccess('ใช้รหัสโค้ดสำเร็จ');
        searchTokenController.text = '';
      }
    } on Exception catch (e) {
      var message = e.toString();
      if (message.contains('not found')) {
        _snackBarAlert.snackBarAlertError('ไม่พบรหัสโค้ดนี้');
      } else {
        _snackBarAlert.snackBarAlertError(message);
      }
      setState(() => isLoadingSearchToken = false);
    }
  }

  void onSelect() async {
    final file = OpenFilePicker();
    file.filterSpecification = {'file': EXE_FILE_NAME};
    final result = file.getFile();
    if (result != null && _settingPath != null) {
      final file = File('${_settingPath!}/$PATH_CONFIG_FILE_NAME');
      final path = result.path.split(EXE_FILE_NAME)[0];
      await file.writeAsString(path);
      setState(() {
        _settingConfigPath = path;
      });
    }
  }

  void onDelete() async {
    setState(() {
      isLoadingDeleteAccessToken = true;
    });
    final token = await _activateProvider.getCahceToken();
    try {
      if (_userDomain != null && token != null) {
        await _googleSheetService.deleteAccessToken(token, _userDomain!);
        _activateProvider.removeActivated();
        final file = File('${_settingPath!}/$ACTIVATE_FILE_NAME');
        await file.delete();
      }
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      isLoadingDeleteAccessToken = false;
    });
  }

  void onSubmitUseToken() {
    setState(() => isLoadingSearchToken = true);
    if (searchTokenState.isNotEmpty) {
      postAccessTokenByToken(searchTokenState);
    }
  }

  renderTextFieldAccessToken() {
    if (!_activateProvider.isActivated) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 22),
            child: const Divider(
              height: 0.1,
              color: Colors.white10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('ปลดล็อกการใช้งานเต็มรูปแบบ',
                    style: TextStyle(fontSize: 12)),
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  height: 28,
                  width: 28,
                  child: Image.asset(
                    s3Logo,
                    color: const Color.fromARGB(255, 255, 213, 77),
                    fit: BoxFit.contain,
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: TextFormField(
                    controller: searchTokenController,
                    decoration: const InputDecoration(
                      focusColor: customDarkGold,
                      hoverColor: customDarkGold,
                      fillColor: customDarkGold,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            10,
                          ),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            10,
                          ),
                        ),
                        borderSide: BorderSide(
                          color: customDarkGold,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            10,
                          ),
                        ),
                        borderSide: BorderSide(
                          color: customDarkGold,
                          width: 2,
                        ),
                      ),
                      labelStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                      labelText: 'กรอกรหัสโค้ดเพื่อปลดล็อก',
                      hintStyle: TextStyle(fontSize: 5, height: 12.0),
                      counterStyle: TextStyle(fontSize: 12, height: 12.0),
                      isDense: true,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: customDarkGold,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      fixedSize: const Size(120, 30)),
                  onPressed: isLoadingSearchToken || searchTokenState.isEmpty
                      ? null
                      : onSubmitUseToken,
                  child: isLoadingSearchToken
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'ปลดล็อก',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: searchTokenState.isEmpty
                                      ? customDarkPrimaryColor
                                      : customDarkBackgroundColor),
                            )
                          ],
                        ),
                ),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 6, left: 4),
            child: Text(
              'ใช้โค้ดเพื่อใช้งานเต็มรูปแบบ สามารถใช้ 1 โค้ด/เครื่อง เท่านั้น',
              style: TextStyle(fontSize: 10, color: Colors.white70),
            ),
          )
        ],
      );
    }
    return const SizedBox();
  }

  Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    _snackBarAlert.snackBarAlertSuccess('Copy สำเร็จ');
  }

  @override
  Widget build(BuildContext context) {
    ActivateProvider activateProvider = Provider.of<ActivateProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(bottom: 12),
              child: const Text('ทั่วไป'),
            ),
            Column(
              children: [
                BoxDetail(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('สถานะการใช้งาน',
                                  style: TextStyle(fontSize: 12)),
                              Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.black38,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(7),
                                      )),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(right: 8),
                                          height: 28,
                                          width: 28,
                                          child: Image.asset(
                                            s3Logo,
                                            color: activateProvider.isActivated
                                                ? const Color.fromARGB(
                                                    255, 255, 213, 77)
                                                : const Color.fromARGB(
                                                    255, 87, 87, 87),
                                          ),
                                        ),
                                        Text(
                                            activateProvider.isActivated
                                                ? 'เต็มรูปแบบ'
                                                : 'ใช้งานฟรี',
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      activateProvider.isActivated
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              child: BoxDetail(
                                  light: true,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 6),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Access Token',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Colors.white60),
                                                    ),
                                                    FutureBuilder(
                                                        future: activateProvider
                                                            .getCahceToken(),
                                                        builder: (BuildContext
                                                                context,
                                                            snapshot) {
                                                          return Row(
                                                            children: [
                                                              Text(
                                                                isViewToken
                                                                    ? snapshot
                                                                        .data
                                                                        .toString()
                                                                    : '**************${snapshot.data?.substring(14)}',
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    height: 2,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              isViewToken
                                                                  ? Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              8),
                                                                      child:
                                                                          InkWell(
                                                                        onTap: () =>
                                                                            copyToClipboard(snapshot.data!),
                                                                        child: const Icon(
                                                                            Icons
                                                                                .content_copy_rounded,
                                                                            size:
                                                                                15,
                                                                            color:
                                                                                customDarkPrimaryColor),
                                                                      ))
                                                                  : const SizedBox()
                                                            ],
                                                          );
                                                        })
                                                  ]),
                                            ),
                                            TextButton(
                                              onPressed: onViewToken,
                                              child: Text(
                                                isViewToken ? 'Hide' : 'View',
                                                style: const TextStyle(
                                                    fontSize: 12),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 18),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 6),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        'Username',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.white60),
                                                      ),
                                                      FutureBuilder(
                                                          future: activateProvider
                                                              .getCahceUsername(),
                                                          builder: (BuildContext
                                                                  context,
                                                              snapshot) {
                                                            return Text(
                                                                snapshot.data ??
                                                                    '',
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    height: 2,
                                                                    color: Colors
                                                                        .white));
                                                          }),
                                                    ]),
                                              ),
                                              TextButton(
                                                onPressed: onDelete,
                                                child:
                                                    isLoadingDeleteAccessToken
                                                        ? const SizedBox(
                                                            width: 14,
                                                            height: 14,
                                                            child: CircularProgressIndicator(
                                                                strokeWidth: 2,
                                                                color:
                                                                    customDarkAccentColor),
                                                          )
                                                        : const Text(
                                                            'Logout',
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            )
                          : const SizedBox(),
                      renderTextFieldAccessToken(),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 22),
                  child: const Divider(
                    height: 0.1,
                    color: Colors.white10,
                  ),
                ),
                Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('แอปพลิเคชันเกม', style: TextStyle(fontSize: 14)),
                        Text(' (ต้องระบุ)',
                            style: TextStyle(
                                fontSize: 14, color: customDarkAccentColor)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: BoxDetail(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _settingConfigPath != null
                              ? Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 8),
                                      child: Icon(
                                        Icons.check_circle,
                                        color: customDarkSuccessColor,
                                        size: 24.0,
                                        semanticLabel:
                                            'Text to announce in accessibility modes',
                                      ),
                                    ),
                                    Text(
                                      '${_settingConfigPath!}......',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white70),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                )
                              : const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 8),
                                      child: Icon(
                                        Icons.warning_amber,
                                        color: customDarkWarning,
                                        size: 24.0,
                                        semanticLabel:
                                            'Text to announce in accessibility modes',
                                      ),
                                    ),
                                    Text(
                                      'กรูณาเลือกแอปพลิเคชันเกม (RebirthClient.exe)',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white70),
                                    ),
                                  ],
                                ),
                          TextButton(
                            onPressed: onSelect,
                            child: Text(
                              _settingConfigPath != null
                                  ? 'เปลี่ยน'
                                  : 'เลือกไฟล์',
                              style: const TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      )),
                    ),
                    const Row(
                      children: [
                        SizedBox(
                          width: 250,
                          child: Text(
                            'ใช้ระบุตำแหน่งของแอปพลิเคชันเกม (Rebirth RC) เพื่อให้การตั้งค่าได้รับการกำหนดอย่างถูกต้อง',
                            style:
                                TextStyle(fontSize: 12, color: Colors.white70),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:rc_setting/business/encrypter_business.dart';
import 'package:rc_setting/config/option_config.dart';
import 'package:rc_setting/constant/directory_constant.dart';
import 'package:rc_setting/model/setting_model.dart';
import 'package:path_provider/path_provider.dart';

class DirectoryBusiness {
  late EncrypterBusiness _encrypterBusiness;
  DirectoryBusiness() {
    _encrypterBusiness = EncrypterBusiness();
  }

  Future<ConfigModel?> getResourseConfig() async {
    Directory directory = await getApplicationDocumentsDirectory();
    Directory settingDirectory = Directory('${directory.path}/$DOCUMENTS_DIRECTORY_FOLDER_NAME');
    if (!await settingDirectory.exists()) {
      settingDirectory.create();
    }
    String settingDirectoryPath = settingDirectory.path;
    if (settingDirectoryPath != null) {
      File resourseFile = File('$settingDirectoryPath/$RESOURSE_FILE_NAME');
      bool isResourseFileExits = await resourseFile.exists();
      if (!isResourseFileExits) {
        String jsonString = json.encode(defaultConfig);
        resourseFile.writeAsString(_encrypterBusiness.encrypt(jsonString));
        return defaultConfig;
      } else {
        String? encrypted = await resourseFile.readAsString();
        if (encrypted != null) {
          String? decrypted = _encrypterBusiness.decrypt(encrypted);
          if (decrypted != null) {
            ConfigModel setting = ConfigModel.fromJson(json.decode(decrypted));
            return setting;
          }
        }
      }
    }
  }

  Future updateResourseFile(ConfigModel? config) async {
    if (config == null) return;
    Directory directory = await getApplicationDocumentsDirectory();
    Directory settingDirectory = Directory('${directory.path}/$DOCUMENTS_DIRECTORY_FOLDER_NAME');
    if (!await settingDirectory.exists()) {
      settingDirectory.create();
    }
    String settingDirectoryPath = settingDirectory.path;
    if (settingDirectoryPath != null) {
      File resourseFile = File('$settingDirectoryPath/$RESOURSE_FILE_NAME');
      bool isResourseFileExits = await resourseFile.exists();
      if (isResourseFileExits) {
        String jsonString = json.encode(config);
        resourseFile.writeAsString(_encrypterBusiness.encrypt(jsonString));
        return config;
      }
    }
  }

  Future<String?> getContentPathConfig() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final Directory pathDirectory =
        Directory('${directory.path}/$DOCUMENTS_DIRECTORY_FOLDER_NAME');
    if (await pathDirectory.exists() && pathDirectory.path != null) {
      final String settingPath = pathDirectory.path;
      final File patchConfigFile = File('$settingPath/$PATH_CONFIG_FILE_NAME');
      final isTempFileExits = await patchConfigFile.exists();
      if (isTempFileExits) {
        final pathConfigContent = await patchConfigFile.readAsString();
        return pathConfigContent;
      }
    }
  }

  Future<File?> getXMLOptionFile() async {
    String? pathConfigContent = await getContentPathConfig();
    if (pathConfigContent != null) {
      pathConfigContent = pathConfigContent.replaceAll(r'\', r'/');
      final File xmlOptionFile = File('${pathConfigContent}${OPTION_XML_FILE_NAME}');
      final isExistXMLOptionFile = await xmlOptionFile.exists();
      if (isExistXMLOptionFile) {
        return xmlOptionFile;
      }
    }
  }

  void createLogFile(String log) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final Directory pathDirectory =
        Directory('${directory.path}/$DOCUMENTS_DIRECTORY_FOLDER_NAME');
    if (await pathDirectory.exists() && pathDirectory.path != null) {
      final String settingPath = pathDirectory.path;
      final logFile = File('$settingPath/$ERROR_LOG_FILE_NAME');
      await logFile.writeAsString(log);
    }
  }
}


import 'package:gsheets/gsheets.dart';
import 'package:flutter/services.dart';
import 'package:gsheet_api/model/user.dart';

class UserSheetsAPI {
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "gsheets-341804",
  "private_key_id": "636e1bf508d9fadd01d386be8f3b2f51cdadeccc",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCP2zBWIM+IP/sR\nqwm6mXNEsv7hdPZtt4emd6UYbgjppqzpMRO5g69LZjiRPE3ZlOVdUoMgNs34bx/C\nL5lW2SMIbmxIOkPSYvGyTz4TaC2pTr22guJwvhDJyQTqNQdjn0tnZLvmp3wH7z3X\nqxb8SlGLLSowdlxCw7aK17ji1i61YRhW6Kx6AaLuW1hxSwRxmZWN4+4BDk+XXW1W\nAokOrVKn18PltwL8jpNr6K2ky5QnGxZEVhJVJJ0dFRc/LtX2h/WnYVT8lLKLHPmF\nYR/JSu8nsutbVn1cbDh0TLhaQfvfYlPiflFaGow0eJMXHMSYIwCfyz/150weqsYL\ndbee5oJdAgMBAAECggEAE6qcA5JNvOs+SC6RUGzNCN3NoYXrcJlwFo5xyBK27jZm\nmiSm9SwvCUhKwHQ1kmLcLnNq0LsdUnLirRnzxR8/PlZWQFOS1Q7Iyx8xNdb+sxA8\nOFjRWydoxSVRojEotvJejR6E36YS+0S2OCdAJ7KDTlsY0vJDb68w4+9U69HrJcmR\nUYcbm8AQJORXAqF5gqo9tbhOegLtOtlKJxJq/iUugE2hluSz734tunydhA45PkGU\npC0MhLRKny67tKpvpG6JQMzxf2hN7ysqhWLW+qt7Te/4WDv0G4CeFzlse/1s0JQQ\nBWoR3u+ksp4uT2rXBp3F8L+muBt5WL3uzZUmDibNYQKBgQDJaOJehWrUXzEw80yh\nbh6tFHng4FJ+ZiOyW1iVTIGbZsbOrQHft1cKs8H/zpyWzKrh2mT18x/M22O8bEfh\nKeccGzdXleDdxbwuYR58Gn6ggB+zxTIqHE+Y5FwNIBEq5mTgnL0HA4+7oM1ypOL0\n4JtxRYz9ynxfg5wT6Hzuytox8QKBgQC22N5QC5mJ4qB+Axn/ofQEuEZCCTiIEOir\nLqaFhZ6akTlc+9azoUakksSLgFQ9h2OByEGGKtI3NLmLTQTrqOSFDCa5WDFqAjiz\nPSMZPwkrJACzbjAzqgo0j5F4zGMcQy7zQHAXjKFtLZhFRiXMMHwhD11uvHLlvfOM\n2S7w0mxrLQKBgCXRrf/1qXOrVD9O0CrX1KbHW4NgW90kLLvG70FJlmSpzdbtIZby\nhEOcMWdpUnn2gHfcXGzadDQxVe8BnhWnmp/qdF/b4teB064ZynGfP/u/UzScaKkD\nm+anqqlERjT6AiMzC0OP5aNjtHA8ielVa5q/ZpQZO3Vr7xjF5P+p04LhAoGAKPCy\nBlYykK8PpGdpYNWQX6YrBQovgDfZAMs3OdpLQuyVXX59+kZ4HM1H+LxJIGW6IAsI\nsNPRsc66ZLhgC6wLTscDvKhEmCnbLDbaLwLwOJqdFY/sdwTxuAcVWWjaIC/iyVB6\nSKuSUXHOEGS+fdO1V2mrT+oeB9baO4U9f2p+IBkCgYBzv8v3s3Y2DxK8Oim3FxTI\nDBY2pM+PIJn6rhTbGeh5KRJc2K+zOb+KsEGz7A0iFeSirmvd2WFVI1B6wxuiJPu4\nXv8sJyBiKmm0n6Zkl27UOkP7I7MqMRE4d37EJ0bVAx1O8rQW+sDKSwjXKXEfjpKR\nTMjZktxdXT12HC3xHO4Rmg==\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@gsheets-341804.iam.gserviceaccount.com",
  "client_id": "103100809582813934728",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheets-341804.iam.gserviceaccount.com"
}''';
  static final _sheetID = '1fKLP1cDHrpD2JPIe7TRTVCzCMRgqCtnYtyMNAu1UT4s';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;
  static Worksheet? _dataSheet;

  static Future init() async {
    try {
      final sheet = await _gsheets.spreadsheet(_sheetID);
      _userSheet = await _getWorkSheet(sheet, title: 'Results');
      _dataSheet = await _getWorkSheet(sheet, title: 'Data');

      final FirstRow = Userfield.getField();
      _userSheet!.values.insertRow(1, FirstRow);

      UserSheetsAPI.updateResultsSheet();
    } catch (e) {
      print('Init Error: $e');
    }
  }

  static Future<Worksheet> _getWorkSheet(
    Spreadsheet sheet, {
    required String title,
  }) async {
    try {
      return await sheet.addWorksheet(title);
    } catch (e) {
      return sheet.worksheetByTitle(title)!;
    }
  }

  static Future<int> getRowCount() async {
    if (_dataSheet == null) return 0;
    final lastROW = await _dataSheet!.values.lastRow();
    return lastROW == null ? 0 : int.parse(lastROW.first);
  }

  static Future updateResultsSheet() async {
    int rowCount = await getRowCount();
    int i = 0;
    String status;
    List<User> dataList = await getAll();
    // if (dataList == null) return;
    for (i = 1; i < rowCount; i++) {
      if (dataList[i].Marks! >= 40) {
        status = 'Pass';
      } else {
        status = 'Fail';
      }
      final addList = {
        Userfield.ID: dataList[i].ID,
        Userfield.ID: dataList[i].Name,
        Userfield.ID: dataList[i].Marks,
        Userfield.Status: status,
      };
      // print(Userfield.ID.toString());
      UserSheetsAPI.insert([addList]);
    }
  }

  static Future<List<User>> getAll() async {
    if (_dataSheet == null) return <User>[];

    final users = await _dataSheet!.values.map.allRows();

    return users == null ? <User>[] : users.map(User.fromJson).toList();
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    _userSheet!.values.map.appendRows(rowList);
  }
}

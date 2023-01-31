import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../authentication/helpers/dio/dio_api.dart';
import '../models/currency_model.dart';
import '../models/school_features_model.dart';

class GeneralService {
  Future<CurrencyModel> getCurrency(int currencyId) async {
    var response = await DioApi().dio.get(dotenv.env['api'].toString() +
        "general/currency/" +
        currencyId.toString());

    Map<String, dynamic> decodedList = jsonDecode(json.encode(response.data));

    if (response.statusCode == 200) {
      return CurrencyModel.fromJson(decodedList);
    } else {
      throw Exception('Unable to get currency.');
    }
  }

  Future<List<SchoolFeaturesModel>> getFeatures() async {
    var response = await DioApi()
        .dio
        .get(dotenv.env['api'].toString() + "general/features/");

    if (response.statusCode == 200) {
      List decodedList = jsonDecode(json.encode(response.data));
      List<SchoolFeaturesModel> features = decodedList
          .map(
            (dynamic item) => SchoolFeaturesModel.fromJson(item),
          )
          .toList();

      return features;
    } else {
      throw Exception('Unable to get currency.');
    }
  }
}

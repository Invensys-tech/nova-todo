import 'package:flutter_application_1/entities/partner-entity.dart';
import 'package:flutter_application_1/services/auth.service.dart';
import 'package:flutter_application_1/utils/supabase.clients.dart';

class PartnerRepository {
  Future<Partner> createPartner(Map<String, dynamic> data) async {
    try {
      // final response = await supabaseClient
      //     .from(Entities.PARTNER.dbName)
      //     .insert({
      //       "name": data['name'],
      //       "phone_number": data['phone_number'],
      //       "user_id": data['user_id'],
      //     });

      // final responseData = await supabaseClient
      //     .from(Entities.PARTNER.dbName)
      //     .select('*');
      // final lastItem = responseData[responseData.length - 1];
      // return Partner.fromJson(lastItem);

      final inserted =
          await supabaseClient
              .from(Entities.PARTNER.dbName)
              .insert({
                "name": data['name'],
                "phone_number": data['phone_number'],
                "user_id": data['user_id'],
              })
              .select()
              .single(); // this ensures you get just the inserted row

      return Partner.fromJson(inserted);
    } catch (e) {
      print('Error in creating partner: $e');
      rethrow;
    }
  }

  Future<List<Partner>> fetchPartners() async {
    final data = await supabaseClient
        .from(Entities.PARTNER.dbName)
        .select('*')
        .eq("user_id", 1);

    print(data);
    return data.map((e) => Partner.fromJson(e)).toList();
  }

  Future<Partner> fetchPartnerById(dynamic id) async {
    final data = await supabaseClient
        .from(Entities.PARTNER.dbName)
        .select('*')
        .eq("id", id);

    return Partner.fromJson(data[0]);
  }
}

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDb {
  static const String dbName = 'tbl_user';

  Future<PostgrestResponse> getUserEmailExist() async {
    final response = await Supabase.instance.client
        .from(dbName)
        .select('email', const FetchOptions(count: CountOption.exact));

    return response;
  }
}

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDb {
  static const String tblName = 'tbl_user';

  Future<PostgrestResponse> getUserEmailExist(String email) async {
    final response = await Supabase.instance.client
        .from(tblName)
        .select('id, email, phone, first_name, last_name, user_photo, bg_theme',
            const FetchOptions(count: CountOption.exact))
        .eq('email', email);

    return response;
  }

  Future<void> insertDataUser(String email, String phone, String firstName,
      String lastName, String photoUrl, String bgTheme) async {
    final supabaseInstance = await Supabase.instance.client;

    await supabaseInstance.from(tblName).insert({
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'user_photo': photoUrl,
      'bg_theme': bgTheme,
    });
  }
}

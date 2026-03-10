import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/route_model.dart';

class RouteRemoteDatasource {
  RouteRemoteDatasource(this._supabase);

  final SupabaseClient _supabase;

  Future<List<RouteModel>> fetchAllOfficial() async {
    final data = await _supabase
        .from('routes')
        .select()
        .eq('is_official', true)
        .order('name');
    return (data as List)
        .map((json) => RouteModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<RouteModel?> fetchById(String id) async {
    final data = await _supabase
        .from('routes')
        .select()
        .eq('id', id)
        .maybeSingle();
    if (data == null) return null;
    return RouteModel.fromJson(data);
  }

  Future<String> downloadGpx(String gpxUrl) async {
    final response = await http.get(Uri.parse(gpxUrl));
    if (response.statusCode != 200) {
      throw Exception('GPX 下載失敗 (${response.statusCode})');
    }
    return utf8.decode(response.bodyBytes);
  }
}

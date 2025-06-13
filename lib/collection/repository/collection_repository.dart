import 'dart:convert';

import 'package:cache/cache.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

import '../../utils/utils.dart';
import '../collection.dart';

class CollectionRepository {
  CollectionRepository({
    required this.cacheClient,
    required this.connectivity,
  });

  final CacheClient cacheClient;
  final Connectivity connectivity;

  /// Loads from assets when online (and caches), otherwise from cache.
  Future<List<CollectionModel>> loadData() async {
    final connResult = await connectivity.checkConnectivity();
    final isOnline = !connResult.contains(ConnectivityResult.none);

    if (isOnline) {
      // 1️⃣ Fetch from assets
      final jsonString =
          await rootBundle.loadString('assets/my_collection_mock.json');

      // 2️⃣ Cache the raw JSON string
      cacheClient.write<String>(key: AppKeys.collectionsCacheKey, value: jsonString);

      // 3️⃣ Decode & return
      final List<dynamic> list = json.decode(jsonString);
      return list
          .map((e) => CollectionModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      // 💤 Offline: read from cache
      final cached = cacheClient.read<String>(key: AppKeys.collectionsCacheKey);
      if (cached != null && cached.isNotEmpty) {
        final List<dynamic> list = json.decode(cached);
        return list
            .map((e) => CollectionModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        // no data cached yet
        throw Exception('No offline data available');
      }
    }
  }
}

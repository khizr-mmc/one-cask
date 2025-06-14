import 'dart:convert';

import 'package:cache/cache.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

import '../../utils/utils.dart';
import '../collection.dart';

class CollectionRepository {
  CollectionRepository({required this.cacheClient, required this.connectivity});

  final CacheClient cacheClient;
  final Connectivity connectivity;

  /// Loads from assets when online (and caches), otherwise from cache.
  Future<List<CollectionModel>> loadData() async {
    final connResult = await connectivity.checkConnectivity();
    final isOnline = !connResult.contains(ConnectivityResult.none);

    if (isOnline) {
      final jsonString = await rootBundle.loadString(
        'assets/my_collection_mock.json',
      );

      cacheClient.write<String>(
        key: AppKeys.collectionsCacheKey,
        value: jsonString,
      );

      final List<dynamic> list = json.decode(jsonString);
      return list
          .map((e) => CollectionModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      final cached = cacheClient.read<String>(key: AppKeys.collectionsCacheKey);
      if (cached != null && cached.isNotEmpty) {
        final List<dynamic> list = json.decode(cached);
        return list
            .map((e) => CollectionModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('No offline data available');
      }
    }
  }

  Future<List<CollectionModel>> filterOffline({
    String? nameContains,
    int? minCount,
  }) async {
    final cached = cacheClient.read<String>(key: AppKeys.collectionsCacheKey);
    if (cached == null || cached.isEmpty) {
      throw Exception('No offline data available');
    }

    final List<dynamic> raw = json.decode(cached);
    final all = raw
        .map((e) => CollectionModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return all.where((item) {
      final matchName =
          nameContains == null ||
          (item.name?.toLowerCase().contains(nameContains.toLowerCase()) ??
              false);
      final matchCount =
          minCount == null || (item.count != null && item.count! >= minCount);
      return matchName && matchCount;
    }).toList();
  }
}

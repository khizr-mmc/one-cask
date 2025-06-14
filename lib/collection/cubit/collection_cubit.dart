import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_cask/collection/collection.dart';

import 'package:one_cask/utils/utils.dart';

part 'collection_state.dart';

class CollectionCubit extends Cubit<CollectionState> {
  CollectionCubit(this.repository) : super(CollectionState());
  final CollectionRepository repository;

  Future<void> getCollection() async {
    emit(
      state.copyWith(
        collectionApiState: const GeneralApiState<List<CollectionModel>>(
          apiCallState: APICallState.loading,
        ),
      ),
    );

    await repository
        .loadData()
        .then((collection) {
          emit(
            state.copyWith(
              collectionApiState: GeneralApiState<List<CollectionModel>>(
                apiCallState: APICallState.loaded,
                model: collection,
              ),
            ),
          );
        })
        .catchError((error) {
          emit(
            state.copyWith(
              collectionApiState: GeneralApiState<List<CollectionModel>>(
                apiCallState: APICallState.failure,
                errorMessage: error.toString(),
              ),
            ),
          );
        });
  }

  Future<void> filterCollection({String? name, int? minCount}) async {
    emit(
      state.copyWith(
        collectionApiState: const GeneralApiState<List<CollectionModel>>(
          apiCallState: APICallState.loading,
        ),
      ),
    );

    try {
      final conn = await repository.connectivity.checkConnectivity();
      final isOnline = !conn.contains(ConnectivityResult.none);

      List<CollectionModel> items;
      if (isOnline) {
        // online: fetch fresh list then filter in memory
        final all = await repository.loadData();
        items = all.where((item) {
          final matchName =
              name == null ||
              item.name?.toLowerCase().contains(name.toLowerCase()) == true;
          final matchCount =
              minCount == null ||
              (item.count != null && item.count! >= minCount);
          return matchName && matchCount;
        }).toList();
      } else {
        // offline: use your cache-based filter
        items = await repository.filterOffline(
          nameContains: name,
          minCount: minCount,
        );
      }
      emit(
        state.copyWith(
          collectionApiState: GeneralApiState<List<CollectionModel>>(
            apiCallState: APICallState.loaded,
            model: items,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          collectionApiState: GeneralApiState<List<CollectionModel>>(
            apiCallState: APICallState.failure,
            errorMessage: e.toString(),
          ),
        ),
      );
    }
  }
}

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
}
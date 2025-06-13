part of 'collection_cubit.dart';

class CollectionState extends Equatable {
  const CollectionState({
    this.collectionApiState = const GeneralApiState<List<CollectionModel>>(),
  });

  final GeneralApiState<List<CollectionModel>> collectionApiState;

  CollectionState copyWith({
    GeneralApiState<List<CollectionModel>>? collectionApiState,
  }) => CollectionState(
    collectionApiState: collectionApiState ?? this.collectionApiState,
  );

  @override
  List<Object> get props => [collectionApiState];
}
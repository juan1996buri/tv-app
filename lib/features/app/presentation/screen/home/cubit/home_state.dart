part of 'home_cubit.dart';

class HomeState {
  final List<ChannelEntity> channelList;
  final List<CategoryEntity> categoryList;
  final CategoryEntity categoryEntity;
  HomeState({
    required this.channelList,
    required this.categoryList,
    required this.categoryEntity,
  });

  HomeState copyWith({
    List<ChannelEntity>? channelList,
    List<CategoryEntity>? categoryList,
    CategoryEntity? categoryEntity,
  }) {
    return HomeState(
      channelList: channelList ?? this.channelList,
      categoryList: categoryList ?? this.categoryList,
      categoryEntity: categoryEntity ?? this.categoryEntity,
    );
  }
}

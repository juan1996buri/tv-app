part of 'home_cubit.dart';

class HomeState {
  final List<ChannelEntity> channelList;
  final List<CategoryEntity> categoryList;
  final CategoryEntity categoryEntity;
  final ChannelEntity channelEntity;
  HomeState({
    required this.channelList,
    required this.categoryList,
    required this.categoryEntity,
    required this.channelEntity,
  });

  HomeState copyWith({
    List<ChannelEntity>? channelList,
    List<CategoryEntity>? categoryList,
    CategoryEntity? categoryEntity,
    ChannelEntity? channelEntity,
  }) {
    return HomeState(
      channelList: channelList ?? this.channelList,
      categoryList: categoryList ?? this.categoryList,
      categoryEntity: categoryEntity ?? this.categoryEntity,
      channelEntity: channelEntity ?? this.channelEntity,
    );
  }
}

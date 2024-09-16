import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:tvapp/features/app/domain/entities/category_entity.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(
          HomeState(
            categoryList: categoryList,
            channelList: categoryList.first.channelList,
            categoryEntity: categoryList.first,
            channelEntity: categoryList.first.channelList.first,
          ),
        );

  void changeChannelList({required CategoryEntity categoryEntity}) {
    final itemSelected = state.categoryList
        .where(
          (element) => element.title == categoryEntity.title,
        )
        .toList();

    emit(
      state.copyWith(
        channelList: itemSelected.first.channelList,
        categoryEntity: categoryEntity,
      ),
    );
  }

  Future<void> loadJsonData() async {
    final String response = await rootBundle.loadString('assets/tv/db.json');

    final resp = channelEntityFromJson(response);
    emit(
      state.copyWith(
        channelList: resp,
      ),
    );
  }

  void changeChannelEntity({required ChannelEntity channelEntity}) {
    final newState = state.copyWith(channelEntity: channelEntity);
    emit(newState);
  }
}

Future<List<String>> loadM3UFile({required String url}) async {
  final String content = await rootBundle.loadString(url);
  List<String> urls = [];

  for (String line in content.split('\n')) {
    if (line.startsWith('http')) {
      urls.add(line.trim());
    }
  }
  return urls;
}

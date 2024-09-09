import 'package:bloc/bloc.dart';
import 'package:tvapp/features/app/domain/entities/category_entity.dart';

part 'video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  VideoPlayerCubit(ChannelEntity channelEntity)
      : super(
          VideoPlayerState(activePIPView: false),
        );

  void changeActivePIPView(bool activePIPView) {
    emit(state.copyWith(activePIPView: activePIPView));
  }
}

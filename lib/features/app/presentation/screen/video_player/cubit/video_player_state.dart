part of 'video_player_cubit.dart';

class VideoPlayerState {
  final bool activePIPView;

  VideoPlayerState({
    required this.activePIPView,
  });

  VideoPlayerState copyWith({
    bool? activePIPView,
  }) {
    return VideoPlayerState(
      activePIPView: activePIPView ?? this.activePIPView,
    );
  }
}

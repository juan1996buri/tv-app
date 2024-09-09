import 'package:floating/floating.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show SystemChrome, DeviceOrientation, rootBundle;
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key, required this.urlVideo});
  final String urlVideo;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen>
    with WidgetsBindingObserver {
  Floating pip = Floating();
  bool isPipAvailable = false;
  late VideoPlayerController _controller;

  _checkPipAvailability() async {
    isPipAvailable = await pip.isPipAvailable;
    setState(() {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.hidden && isPipAvailable) {
      pip.enable(const ImmediatePiP(aspectRatio: Rational.landscape()));
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _checkPipAvailability();

    try {
      _controller = VideoPlayerController.networkUrl(
        Uri.parse(
          widget.urlVideo,
        ),
      );
      _controller.initialize().then(
        (_) {
          _controller.setLooping(true);
          _controller.play();
          setState(() {});
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  bool activeOptions = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        //fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: videoPlayerWidget(),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  activeOptions = !activeOptions;
                });
              },
            ),
          ),
          AnimatedPositioned(
            duration: Durations.medium1,
            right: 0,
            left: 0,
            top: activeOptions ? 0 : -kToolbarHeight,
            child: Container(
              height: kToolbarHeight,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      color: Colors.white,
                      Icons.keyboard_arrow_left,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      //Navigator.pop(context);
                      setState(() {
                        activeOptions = false;
                      });
                      pip.enable(
                        const ImmediatePiP(
                          aspectRatio: Rational.landscape(),
                        ),
                      );
                    },
                    icon: const Icon(
                      color: Colors.white,
                      Icons.fullscreen,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget videoPlayerWidget() {
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    );
  }
  // Widget videoPlayerWidget() {
  //   return _controller.value.isInitialized
  //       ? AspectRatio(
  //           aspectRatio: _controller.value.aspectRatio,
  //           child: VideoPlayer(_controller),
  //         )
  //       : VideoProgressIndicator(
  //           colors: const VideoProgressColors(
  //             backgroundColor: Colors.black,
  //             playedColor: Colors.grey,
  //           ),
  //           _controller,
  //           allowScrubbing: true,
  //           padding: EdgeInsets.zero,
  //         );
  // }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, // La orientación predeterminada
    ]);
    super.dispose();
  }
}

// ElevatedButton(
//                 onPressed: () {
//                   if (isPipAvailable) {
//                     pip.enable(
//                       const ImmediatePiP(
//                         aspectRatio: Rational.landscape(),
//                       ),
//                     );
//                   }
//                 },
//                 child: const Text("minimizar"),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   PIPView.of(context)!.presentBelow(
//                     const HomeScreen(),
//                   );
//                 },
//                 child: const Text("minimizar"),
//               )

// Widget videoPlayerWidget() {
//   return RotatedBox(
//     quarterTurns: 3,
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         if (_controller != null && _controller!.value.isInitialized)
//           AspectRatio(
//             key: UniqueKey(),
//             aspectRatio: _controller!.value.aspectRatio,
//             child: VideoPlayer(
//               _controller!,
//             ),
//           ),
//         if (_controller != null)
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: VideoProgressIndicator(
//               _controller!,
//               allowScrubbing: true,
//               padding: EdgeInsets.zero,
//             ),
//           ),
//       ],
//     ),
//   );
// }

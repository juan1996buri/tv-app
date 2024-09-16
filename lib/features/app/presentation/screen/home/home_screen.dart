import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart'
    show SystemChrome, DeviceOrientation, rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvapp/features/app/presentation/screen/home/cubit/home_cubit.dart';
import 'package:tvapp/features/app/presentation/screen/video_player/video_player_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

const _projectURL =
    "https://play.google.com/store/search?q=pub%3ATheDan98&c=apps&hl=es_EC";

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>().loadJsonData();
    });
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, // La orientación predeterminada
    ]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeCubit>().state;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Tv online ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              if (!await launchUrl(
                Uri.parse(
                  _projectURL,
                ),
              )) {
                throw Exception();
              }
            },
            child: const Text(
              "TheDan98 ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          )
        ],
        backgroundColor: Colors.white24,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // TabBar(
          //   tabAlignment: TabAlignment.start,
          //   automaticIndicatorColorAdjustment: false,
          //   isScrollable: true,
          //   indicatorWeight: 0.01,
          //   dividerHeight: 0,
          //   indicator: const BoxDecoration(color: Colors.transparent),
          //   controller: TabController(
          //     length: provider.categoryList.length,
          //     vsync: this,
          //   ),
          //   onTap: (value) {
          //     final categoryEntity =
          //         context.read<HomeCubit>().state.categoryList[value];
          //     context.read<HomeCubit>().changeChannelList(
          //           categoryEntity: categoryEntity,
          //         );
          //   },
          //   overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          //   tabs: List.generate(
          //     provider.categoryList.length,
          //     (index) {
          //       final categoryEntity = provider.categoryList[index];
          //       return Card(
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(
          //             5,
          //           ),
          //         ),
          //         elevation:
          //             provider.categoryEntity.title == categoryEntity.title
          //                 ? 2
          //                 : 0,
          //         child: Container(
          //           width: 100,
          //           padding:
          //               const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          //           child: Text(
          //             categoryEntity.title,
          //             textAlign: TextAlign.center,
          //             style: TextStyle(
          //               fontWeight: provider.categoryEntity.title ==
          //                       categoryEntity.title
          //                   ? FontWeight.bold
          //                   : FontWeight.normal,
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          // const SizedBox(height: 20),

          if (provider.channelList.isNotEmpty)
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: provider.channelList.length,
                itemBuilder: (context, index) {
                  final itemChannel = provider.channelList[index];
                  return Card(
                    color: itemChannel.title ==
                            context.watch<HomeCubit>().state.channelEntity.title
                        ? const Color.fromARGB(255, 139, 248, 193)
                        : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: ListTile(
                        onTap: () async {
                          context
                              .read<HomeCubit>()
                              .changeChannelEntity(channelEntity: itemChannel);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => VideoPlayerScreen(
                                urlVideo: itemChannel.url,
                              ),
                            ),
                          );
                        },
                        title: Text(
                          itemChannel.title,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: CircleAvatar(
                          child: CachedNetworkImage(
                            scale: 1.0,
                            fit: BoxFit.cover,
                            width: 60,
                            height: 60,
                            imageUrl: itemChannel.logo,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          else
            const Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}



// PopScope(
//           canPop: false,
//           onPopInvokedWithResult: (didPop, result) async {
//             // if (isPipAvailable &&
//             //     _controller != null &&
//             //     _controller!.value.isInitialized) {
//             //   // Activa el PiP antes de navegar hacia atrás
//             //   await pip.enable(
//             //     const ImmediatePiP(
//             //       aspectRatio: Rational.landscape(),
//             //     ),
//             //   );
//             // }
//             PIPView.of(context)!.presentBelow(videoPlayerWidget());
//             final navigator = Navigator.of(context);
//             navigator.pop();
//           },
//           child: PiPSwitcher(
//             childWhenDisabled: Scaffold(
//               appBar: AppBar(
//                 title: Text(provider.channelEntity.title),
//               ),
//               body: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   //Expanded(child: videoPlayerWidget()),
//                   Expanded(
//                     child: Stack(
//                       fit: StackFit.expand,
//                       children: [
//                         videoPlayerWidget(),
//                         if (_controller != null)
//                           Positioned(
//                             bottom: 0,
//                             left: 0,
//                             right: 0,
//                             child: VideoProgressIndicator(
//                               _controller!,
//                               allowScrubbing: true,
//                               padding: EdgeInsets.zero,
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       print("-------");
//                       if (isPipAvailable) {
//                         pip.enable(
//                           const ImmediatePiP(
//                             aspectRatio: Rational.landscape(),
//                           ),
//                         );
//                       }
//                     },
//                     child: const Text("minimizar"),
//                   )
//                 ],
//               ),
//               // floatingActionButton: FloatingActionButton(
//               //   onPressed: () {
//               //     setState(() {
//               //       _controller!.value.isPlaying
//               //           ? _controller!.pause()
//               //           : _controller!.play();
//               //     });
//               //   },
//               //   child: Icon(
//               //     _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
//               //   ),
//               // ),
//             ),
//             childWhenEnabled: videoPlayerWidget(),
//           ),
//         )
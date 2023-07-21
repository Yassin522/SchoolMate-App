import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:school_management_system/public/utils/constant.dart';
import 'package:school_management_system/student/controllers/RefrencesController.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

var _controller = Get.put(RefrencesController());
var urlVideo = _controller.VideosInfo.value;

// Widget videos() {
//   return SingleChildScrollView(
//     child: Padding(
//       padding: EdgeInsets.only(
//         left: 24.w,
//         right: 24.w,
//         top: 24.h,
//       ),
//       child: Column(
//           children: List.generate(urlVideo.length,
//               (index) => RefrencesVideoCard(url: urlVideo[index]))),
//     ),
//   );
// }

class Videos extends StatelessWidget {
  Videos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.only(
            left: 24.w,
            right: 24.w,
            top: 24.h,
          ),
          child: SizedBox(
            height: 700.h,
            width: 540.w,
            child: GetBuilder(
                init: RefrencesController(),
                builder: (controller) {
                  return FutureBuilder(
                    future: _controller.getVideos(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: Text('Loading...'));
                      } else if (_controller.isFiltred) {
                        if (_controller.filtredDataListVideo.value.isEmpty) {
                          return const Center(
                            child: Text('Nothings to show'),
                          );
                        } else {
                          return ListView.builder(
                            itemCount:
                                _controller.filtredDataListVideo.value.length,
                            itemBuilder: (BuildContext context, int index) {
                              return RefrencesVideoCard(
                                  url: _controller.VideosInfo.value[index].url);
                            },
                          );
                        }
                      } else {
                        return ListView.builder(
                          itemCount: _controller.VideosInfo.value.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RefrencesVideoCard(
                                url: _controller.VideosInfo.value[index].url);
                          },
                        );
                      }
                    },
                  );
                }),
          )),
    );
  }
}

class RefrencesVideoCard extends StatefulWidget {
  RefrencesVideoCard({
    Key? key,
    this.url,
  });

  final url;

  @override
  State<RefrencesVideoCard> createState() => _refrencesVideoCardState();
}

class _refrencesVideoCardState extends State<RefrencesVideoCard> {
  @override
  late YoutubePlayerController yController;

  @override
  void initState() {
    yController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.url)!,
      flags: YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
    super.initState();
  }

  Widget build(BuildContext context) {
    print(YoutubePlayer.convertUrlToId(widget.url).toString());
    print('#######################');
    print(yController.metadata.title.toString());
    return Container(
      height: 300.h,
      width: 380.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: primaryColor.withAlpha(30),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 230.h,
              width: 360.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: white,
              ),
              child: Center(
                child: YoutubePlayer(
                  controller: yController,
                  showVideoProgressIndicator: true,
                ),
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Text('${yController.metadata.title}'),
          ],
        ),
      ),
    );
  }
}

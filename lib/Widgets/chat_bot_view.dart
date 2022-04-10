import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paw_and_love/Config/color_config.dart';
import 'package:paw_and_love/Utils/snackbar.dart';
import 'package:paw_and_love/Widgets/customeCircularProgress.dart';
import 'package:paw_and_love/Widgets/custome_text_input_field.dart';
import 'package:paw_and_love/controller/users/dog_common_disses_controller.dart';

import 'package:sizer/sizer.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatBotView extends StatelessWidget {
  const ChatBotView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DogCommonDissesController _controller = Get.find();
    final _channel = WebSocketChannel.connect(
      //ws://pawandlowchatbot.herokuapp.com/reverse
      //wss://echo.websocket.org
      Uri.parse('ws://pawandlowchatbot.herokuapp.com/reverse'),
    );
    return AlertDialog(
      title: Row(
        children: [
          const Text('Chat bot'),
          const Spacer(),
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                _channel.sink.close();
                _controller.chatMesseges.clear();
              },
              icon: Icon(
                Icons.close,
                color: ColorConfig.errorRed,
                size: 40,
              )),
        ],
      ),
      content: SizedBox(
        height: 90.h,
        width: 95.w,
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream: _channel.stream,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                _controller.chatMesseges
                    .add(MessageModel(snapshot.data.toString(), false));
              }

              return snapshot.connectionState == ConnectionState.active
                  ? ListView.builder(
                      itemCount: _controller.chatMesseges.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: ((context, index) => !_controller
                              .chatMesseges[index].isSend!
                          ? Text(
                              _controller.chatMesseges[index].message
                                  .toString(),
                              textAlign: TextAlign.left,
                            )
                          : Text(
                              _controller.chatMesseges[index].message
                                  .toString(),
                              textAlign: TextAlign.right,
                              style: const TextStyle(color: ColorConfig.blue),
                            )))
                  : CustomeCircularProgress(
                      color: ColorConfig.orange,
                    );
            },
          ),
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: 60.w,
                height: 7.h,
                child: CustomeTextInputField(
                    textEditingController: _controller.chatTextController.value,
                    isPass: false,
                    hintText: "Youer Message",
                    lableText: "Youer Message",
                    textInputType: TextInputType.text,
                    textColor: ColorConfig.textColorDark,
                    isReadOnly: false),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  if (_controller.chatTextController.value.text != "") {
                    _channel.sink
                        .add(_controller.chatTextController.value.text);
                    _controller.chatMesseges.add(MessageModel(
                        _controller.chatTextController.value.text, true));
                    _controller.chatTextController.value.clear();
                  } else {
                    flutterToastMessage(
                        title: "Error",
                        message: "Yoyr message is empty",
                        position: SnackPosition.TOP,
                        backgroundColor: ColorConfig.successGreen);
                  }
                },
                child: Icon(
                  Icons.send,
                  size: 27.sp,
                  color: Colors.green,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

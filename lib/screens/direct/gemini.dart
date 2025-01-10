import 'package:flutter/material.dart';
import 'package:nmax/backend/gemini.dart';
import 'package:nmax/screens/direct/chat_widgets.dart';
import 'package:nmax/utils/styles.dart';

class Gemini extends StatefulWidget {
  const Gemini({super.key});

  @override
  State<Gemini> createState() => _GeminiState();
}

class _GeminiState extends State<Gemini> {
  List<Map<String, dynamic>> chatList = [];
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg1,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: chatList.isNotEmpty
                  ? ListView.builder(
                      reverse: true,
                      itemCount: chatList.length,
                      itemBuilder: (context, index) {
                        return geminiTextTile(chatList[index]['msg'], context,
                            chatList[index]['me']);
                      },
                    )
                  : SingleChildScrollView(
                      reverse: true,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          preset('Plan a trip'),
                          preset('Tell me a joke'),
                          preset('Tell me a crazy story'),
                        ],
                      ),
                    ),
            ),
            Container(
              width: AppSizing.getWidth(context) * 0.9,
              decoration: BoxDecoration(
                color: Colors.pinkAccent,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  controller: _controller,
                  style: AppTypography.body,
                  onSubmitted: (value) async {
                    if (value.isNotEmpty) {
                      setState(() {
                        _controller.clear();
                        chatList.insert(0, {
                          'msg': value,
                          'me': true,
                        });
                      });
                      var response = await sendPrompt(value);
                      setState(() {
                        chatList.insert(0, {
                          'msg': response,
                          'me': false,
                        });
                      });
                    }
                  },
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Ask anything',
                    hintStyle: AppTypography.sub,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget preset(String value) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          _controller.clear();
          chatList.insert(0, {
            'msg': value,
            'me': true,
          });
        });
        var response = await sendPrompt(value);
        setState(() {
          chatList.insert(0, {
            'msg': response,
            'me': false,
          });
        });
      },
      child: geminiTextTile(value, context, true),
    );
  }
}

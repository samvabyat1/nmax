import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nmax/backend/posting.dart';
import 'package:nmax/utils/outputs.dart';
import 'package:nmax/utils/styles.dart';

class AskScreen extends StatefulWidget {
  const AskScreen({super.key});

  @override
  State<AskScreen> createState() => _AskScreenState();
}

class _AskScreenState extends State<AskScreen> {
  List<String> tags = [];
  var _textcontroller = TextEditingController();
  var _askcontroller = TextEditingController();

  void _onTextChanged(String value) {
    if (value.endsWith(' ')) {
      setState(() {
        tags.add("#${value.split(' ').first.toLowerCase()}");
        _textcontroller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ask',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _askcontroller,
                onChanged: (value) => setState(() {
                  _askcontroller;
                }),
                maxLines: 7,
                style: AppTypography.body,
                decoration: InputDecoration(
                  hintText: 'Explain your query...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              space(25),
              Row(
                children: [
                  SizedBox(
                    width: AppSizing.getWidth(context) * 0.6,
                    child: Text(
                      'Add channel tags to reach your audience',
                      style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              space(10),
              Wrap(
                spacing: 10,
                children: tags
                    .map(
                      (e) => Chip(
                        color: WidgetStateProperty.resolveWith(
                          (states) => Colors.deepOrange,
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                        deleteIcon: Icon(
                          CupertinoIcons.xmark,
                          color: Colors.white,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.black),
                        ),
                        label: Text(
                          e,
                          style: AppTypography.body,
                        ),
                        onDeleted: () {
                          setState(() {
                            tags.remove(e);
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
              space(10),
              TextField(
                controller: _textcontroller,
                onChanged: _onTextChanged,
                style: AppTypography.body,
                decoration: InputDecoration(
                  hintText: 'Add channel tags...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              space(10),
              ElevatedButton.icon(
                onPressed: _askcontroller.text.isEmpty || tags.isEmpty
                    ? null
                    : () async {
                        showDialog(
                          context: context,
                          builder: (context) => Center(
                            child: SizedBox(
                              width: AppSizing.getWidth(context) * 0.4,
                              height: 1,
                              child: LinearProgressIndicator(),
                            ),
                          ),
                        );

                        try {
                          await sendChannelAsk(_askcontroller.text, tags);
                          showSnack(context, 'Your query is posted!');
                          setState(() {
                            _textcontroller.clear();
                            tags.clear();
                          });
                        } catch (e) {
                          showSnack(context, e.toString());
                        }

                        Navigator.pop(context);
                      },
                label: Text('Send'),
                icon: Icon(CupertinoIcons.paperplane),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey[900],
                  disabledForegroundColor: Colors.grey[500],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

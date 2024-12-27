import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nmax/screens/direct/gemini.dart';
import 'package:nmax/utils/styles.dart';

class DirectScreen extends StatelessWidget {
  const DirectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Direct',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        'https://images.unsplash.com/photo-1534271057238-c2c170a76672?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => Gemini(),
                    ),
                    child: AspectRatio(
                      aspectRatio: 3 / 2,
                      child: Container(
                        // height: 65,
                        width: double.maxFinite,
                        child: Center(
                          child: Wrap(
                            spacing: 5,
                            children: [
                              Text(
                                'Ask Gemini',
                                style: GoogleFonts.nothingYouCouldDo(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Icon(
                                Icons.auto_awesome,
                                color: Colors.pinkAccent,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              space(20),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(20),
                child: AspectRatio(
                  aspectRatio: 3 / 2,
                  child: Container(
                    // height: 65,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      // color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.grey.shade700,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Tap to chat',
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          color: Colors.white54,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

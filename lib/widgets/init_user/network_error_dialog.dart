import 'package:flutter/material.dart';
import 'package:nouns_flutter/pallette.dart';

class NetworkErrorDialog extends StatelessWidget {
  final void Function() retryConnection;
  const NetworkErrorDialog({required this.retryConnection, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
      ),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                color: whiteColor,
                height: 150,
                width: MediaQuery.of(context).size.width,
              ),
              Positioned(
                  top: -35,
                  right: 0,
                  left: 0,
                  child: Column(children: [
                    Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Image.asset(
                          'assets/images/InputUserName/ImageGroup_Boss_Frame_Icon1.png',
                          width: 100,
                          height: 100,
                        )),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Network Connection Failed',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: redColor),
                      ),
                    ),
                    Text(
                      'Please check your cellular or Wi-Fi  connection and retry',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 9),
                    )
                  ]))
            ],
          ),
          Container(
              margin: EdgeInsets.only(top: 12),
              child: ElevatedButton(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: const Text("Ok"),
                ),
                onPressed: retryConnection,
              ))
        ]),
      ),
    );
  }
}

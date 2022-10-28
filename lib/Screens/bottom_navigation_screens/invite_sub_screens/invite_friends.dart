import 'package:betting_app/helpers/constant.dart';
import 'package:betting_app/widgets/custom_round_button.dart';
import 'package:flutter/material.dart';

class InviteFriends extends StatelessWidget {
  const InviteFriends({super.key});
  static String id = '';
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        shadowColor: black,
        backgroundColor: black,
        title: Text(
          'Invite Friends',
          style: TextStyle(color: yellow),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                          leading: CircleAvatar(backgroundColor: white),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: CRoundButton(
                              active: true,
                              function: () {},
                              text: 'follow',
                              height: 30,
                              width: 80,
                              fontSize: 10,
                            ),
                          ),
                          trailing: CRoundButton(
                            active: true,
                            function: () {},
                            text: 'remove',
                            height: 30,
                            width: 80,
                            fontSize: 10,
                          ),
                          title: Text(
                            "@john Wick",
                            style: TextStyle(color: white),
                          )),
                    );
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            CRoundButton(
              function: () => Navigator.pop(context),
              text: 'Invite',
              active: true,
              color: yellow,
              textColor: black,
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(

          children: [
            Positioned(
              top: topPadding,
              child:
                  IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.back)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,

                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(3, 3),
                              ),
                            ]),
                        width: 100,
                        height: 100,
                        child: const Icon(Icons.person),
                      ),
                      Transform.translate(
                        offset: const Offset(5, 5),
                        child: const Badge(
                          backgroundColor: Colors.green,
                          smallSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Manal Ahmed', style: TextStyle(color: Colors.black87, fontSize: 24),),
                    Icon(Icons.edit),
                  ],
                ),
                const SizedBox(height: 50,),
                Text('profile'.toUpperCase(), style: const TextStyle(
                  fontSize: 18,fontWeight: FontWeight.w600,
                ),),
                Container(
                  width: double.maxFinite,
                    height: 1,
                  color: Colors.grey.shade800,
                ),
                customShowInfo(icon: Icons.person, infoName: 'UserName', data: 'Manal Ahmed'),
                customShowInfo(icon: Icons.contact_phone, infoName: 'Contact', data: '+20 123 123 1234'),
                customShowInfo(icon: Icons.email, infoName: 'Email', data: 'Manal.Ahmed@gmail.com'),
                customShowInfo(icon: Icons.location_city, infoName: 'location', data: 'El Shurok'),
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget customShowInfo({
  required IconData icon,
    required String infoName,
  required String data,
}) => Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon, size: 44),
        const SizedBox(width: 10,),
        Text(infoName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700,),),
        const Spacer(),
        Text(data, style: const TextStyle(fontSize: 14,),),
        const Spacer(),
      ],
    ),
);
}

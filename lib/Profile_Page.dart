import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: w,
            height: h*0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "img/splashScreen c.png"
                ),
                fit: BoxFit.cover,
              )
            ),
          ),
          SizedBox(height: 70,),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome",
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54
                  ),
                ),
                Text(
                  "doc@gmail.com",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[500]
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: w*0.02,),
          Container(
              width: w*0.5,
              height: h*0.08,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(34),
                  image: DecorationImage(
                    image: AssetImage(
                        "img/signin.jpg"
                    ),
                    fit: BoxFit.cover,
                  )
              ),
              child: Center(
                child: Text(
                  "Sign out",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )
          ),
          SizedBox(height: w*0.02,),
          RichText(text: TextSpan(
            text: "Sign up using the following method",
            style: TextStyle(
                color: Colors.grey[500],
                fontSize: 16
            ),

          )),
        ],
      ),
    );
  }
}

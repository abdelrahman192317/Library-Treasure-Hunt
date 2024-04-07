import 'package:flutter/material.dart';

import '../levels/levels.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(size.height * 0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.05),
              Row(
                children: [
                  Image.asset('assets/images/welcome.png',width: size.width * 0.6),
                  const Spacer(),
                  Image.asset('assets/images/heart.png', height: size.height * 0.03),
                  SizedBox(width: size.width * 0.01,),
                  Image.asset('assets/images/heart.png', height: size.height * 0.03),
                  SizedBox(width: size.width * 0.01,),
                  Image.asset('assets/images/heart.png', height: size.height * 0.03),
                ],
              ),
              const Spacer(),

              Text('برجاء إختيار مستوي الصعوبة',
                style: Theme.of(context).textTheme.titleLarge,),
              SizedBox(height: size.height * 0.02),

              SizedBox(
                width: size.width,
                height: size.height * 0.08,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () => Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const Levels(),
                  )),
                  child: const Text('سهل'),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              SizedBox(
                width: size.width,
                height: size.height * 0.08,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).canvasColor,
                  ),
                  onPressed: () => Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const Levels(),
                  )),
                  child: const Text('متوسط'),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              SizedBox(
                width: size.width,
                height: size.height * 0.08,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: () => Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const Levels(),
                  )),
                  child: const Text('صعب'),
                ),
              ),
              SizedBox(height: size.height * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}

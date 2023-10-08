// ignore_for_file: file_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../widgets/elevated_button.dart';

// minutes 25 Pomodoro Timer تطبيق بومودورو
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? repeatedFunction; // يُستخدم لإيقاف العد التنازلي مؤقتًا
  Duration duration = const Duration(minutes: 25); // القيمة الابتدائية

  startTimer() {
    setState(() {
      repeatedFunction = Timer.periodic(const Duration(minutes: 1), (timer) {
        setState(() {
          //  يُنقص واحد كل ثانية
          int newSeconds = duration.inSeconds - 1;
          duration = Duration(seconds: newSeconds);
          if (duration.inSeconds == 0) {
            repeatedFunction!.cancel();
            inRunning = false;
            duration = const Duration(minutes: 25); // القيمة الابتدائية
            //  لعرض رسالة للمستخدم عند انتهاء 25 دقيقة
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: const Color.fromARGB(255, 50, 65, 71),
                  title: const Text(
                    '👌تم انتهاء 25 دقيقة بنجاح',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  content: const Text(
                    'لقد مرت 25 دقيقة منذ بدء العد التنازلي بالتوفيق فيما هو قادم',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Center(
                        child: Text(
                          "موافق",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        });
      });
    });
  }

// يستخدم لعمل شرط  ان هو متفعل ام لا ولما يتفعل ينفذ شرط محدد
  bool inRunning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pomodoro Timer",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        backgroundColor: const Color.fromARGB(255, 50, 65, 71),
      ),
      backgroundColor: const Color.fromARGB(255, 33, 40, 43),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // مؤشر النسبة المئوية الدائرية
              CircularPercentIndicator(
                radius: 125,
                progressColor: const Color.fromARGB(255, 255, 85, 113),
                backgroundColor: Colors.grey,
                lineWidth: 10.0,
                percent: duration.inMinutes / 25,
                animation: true,
                animateFromLastPercent: true,
                animationDuration: 1000,
                center: Text(
                  "${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}",
                  style: const TextStyle(
                    fontSize: 77,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 60),
          inRunning
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButtonWidget(
                      onPressed: () {
                        if (repeatedFunction!.isActive) {
                          setState(() {
                            repeatedFunction!.cancel();
                          });
                        } else {
                          startTimer();
                        }
                      },
                      text: (repeatedFunction!.isActive) ? 'إيقاف' : 'استئناف',
                    ),
                    const SizedBox(width: 22),
                    ElevatedButtonWidget(
                      onPressed: () {
                        if (repeatedFunction != null) {
                          repeatedFunction!.cancel();
                        }
                        setState(() {
                          duration =
                              const Duration(minutes: 25); // القيمة الابتدائية
                          inRunning = false;
                        });
                      },
                      text: 'إلغاء',
                    )
                  ],
                )
              : ElevatedButton(
                  onPressed: () {
                    startTimer();
                    setState(() {
                      inRunning = true;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 25, 120, 197)),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(14)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9))),
                  ),
                  child: const Text(
                    "بدء الدراسة",
                    style: TextStyle(fontSize: 23),
                  ),
                ),
        ],
      ),
    );
  }
}

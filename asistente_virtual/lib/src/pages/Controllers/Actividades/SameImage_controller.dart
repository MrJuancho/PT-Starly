import 'package:flutter/cupertino.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class SameImageController{
  BuildContext? context;
  StopWatchTimer timerController = StopWatchTimer(mode: StopWatchMode.countUp);
  int elapsedMilliseconds = 0;
  //constructort de clase - puede requerir await si se necesita esperar algo
  Future init(BuildContext context) async {
    this.context = context;
  }

  void dispose() {
    timerController.dispose();
  }

  void startTimer() {
    timerController.onStartTimer();
  }

  void stopTimer() {
    elapsedMilliseconds = timerController.rawTime.value;
    timerController.onStopTimer();
    print(elapsedMilliseconds);
  }
}
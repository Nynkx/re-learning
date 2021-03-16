import 'package:flutter/cupertino.dart';

class _JumpingDot extends AnimatedWidget{
  _JumpingDot({Key key, Animation<double> animation}) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Container(
      height: animation.value,
      child: Text("."),
    );
  }
}

class JumpingDotIndicator extends StatefulWidget{
  final int numOfDots;
  final double startTweenVal = 0.0;
  final double endTweenVal = 8.0;

  JumpingDotIndicator({Key key, this.numOfDots}) : super(key:key);

  _JumpingDotIndicatorState createState() => _JumpingDotIndicatorState();

}

class _JumpingDotIndicatorState extends State<JumpingDotIndicator> with TickerProviderStateMixin{

  int numOfDots;
  List<AnimationController> controllers = List<AnimationController>();
  List<Animation<double>> animations = List<Animation<double>>();
  List<Widget> _widgets = List<Widget>();

  _JumpingDotIndicatorState({this.numOfDots});

  @override
  void initState() {
    super.initState();

    for(int i = 0; i < numOfDots; ++i){
      controllers.add(AnimationController(duration: Duration(milliseconds: 250), vsync: this));
      animations.add(
        Tween(begin: widget.startTweenVal, end: widget.endTweenVal)
            .animate(controllers[i])
            ..addStatusListener((status) {
              if(status == AnimationStatus.completed)
                controllers[i].reverse();
              if(i == numOfDots-1 && status == AnimationStatus.dismissed)
                controllers[i].forward();
              if(animations[i].value == widget.endTweenVal/2 && i < numOfDots- 1)
                controllers[i+1].forward();

        })
      );

      _widgets.add(
        Padding(
          padding: EdgeInsets.only(right: 1.0),
            child: _JumpingDot(animation: animations[i])
        )
      );
      controllers[0].forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _widgets,
      ),
    );
  }
}
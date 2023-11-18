import 'dart:convert';
import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:medify/Register/Models/ErrorsModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:oktoast/oktoast.dart';

ThemeData mainTheme = ThemeData(
  fontFamily: 'Quicksand',
);

//widgets
Widget horizontalScrollBox(Size size,
    {required List<Widget> list, Function()? onTap}) {
  return Column(
    children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 10,
            ),
          ]..addAll(list),
        ),
      ),
    ],
  );
}

Widget horizontalRoundButton(String text,
    {bool active = false, Function()? onTap, bool disable = false}) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: ShapeDecoration(
            color: active
                ? Colors.amber.withOpacity(0.4)
                : disable
                    ? Colors.grey.withOpacity(0.3)
                    : Colors.white,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(100))),
        height: 40,
        // width: 60,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Center(
              child: Text("$text",
                  style:
                      TextStyle(color: active ? Colors.white : Colors.black))),
        ),
      ),
    ),
  );
}

primaryButton(BuildContext context, Size size,
    {Function()? onpress,
    String? texto,
    double borderRadius = 20,
    Color? color,
    Color? textColor = Colors.white}) {
  return Container(
    height: 65,
    width: size.width * 0.9,
    padding: EdgeInsets.only(
      top: 5,
      left: 5,
      bottom: 5,
    ),
    margin: EdgeInsets.only(bottom: borderRadius),
    child: MaterialButton(
      elevation: 2,
      color: color,
      shape: StadiumBorder(),
      onPressed: onpress,
      child: Center(
        child: Text('$texto', style: TextStyle(color: textColor)),
      ),
    ),
  );
}

floadMessage(
    {String? titulo,
    String? mensaje,
    Duration? duration,
    ToastPosition? toastPosition,
    double? bigHeight,
    int? maxLine,
    double? borderRadius}) {
  showToastWidget(
    BounceInDown(
      duration: Duration(milliseconds: 1000),
      child: GestureDetector(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              // height: bigHeight ?? 50,
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, .03),
                      blurRadius: 5,
                      spreadRadius: 5,
                      offset: Offset(0, 2),
                    )
                  ],
                  color: Color.fromARGB(255, 44, 43, 43),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${(titulo ?? "Mensaje: ").trim()}" ?? "",
                                maxLines: bigHeight == null ? 1 : maxLine ?? 1,

                                //  overflow: TextOverflow.clip,
                                style: TextStyle(
                                  color: Colors.white,
                                ),

                                textAlign: TextAlign.center,
                              ),
                              Container(
                                width: MediaQuery.of(Get.context!).size.width /
                                    1.3,
                                child: Text(
                                  "${mensaje!.trim()}",
                                  overflow: TextOverflow.clip,
                                  style: const TextStyle(color: Colors.white),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    position: toastPosition ?? ToastPosition.bottom,
    duration: duration ?? const Duration(seconds: 4),
  );
}

alerta(BuildContext context,
    {bool? code = false,
    String? titulo,
    dynamic? contenido,
    Widget? acciones,
    bool? dismissible,
    bool? done,
    Widget? onpress,
    Color? colorTitulo,
    Color? colorContenido,
    bool weight = false}) {
  return showDialog(
      barrierDismissible: dismissible ?? true,
      barrierColor: Colors.black54,
      context: context,
      builder: (context) {
        return BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5.0,
              sigmaY: 5.0,
            ),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              // backgroundColor: Colors.blueGrey,
              title: Container(
                  decoration: ShapeDecoration(
                      color: Colors.black38,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      titulo ?? 'Alerta',
                      style: TextStyle(color: colorTitulo ?? Colors.grey),
                    )),
                  )),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        decoration: ShapeDecoration(
                            color: Colors.black38,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        child: SizedBox(
                          width: double.infinity,
                          // height: size.width>450?200: size.height * 0.22,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                code == true
                                    ? contenido
                                    : Text('$contenido',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color:
                                                colorContenido ?? Colors.grey,
                                            fontWeight: weight == false
                                                ? FontWeight.w400
                                                : FontWeight.bold))
                              ],
                            ),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: done == true
                                ? Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              child: const Icon(
                                                  Icons.arrow_back,
                                                  color: Colors.white),
                                              width: 50,
                                              height: 50,
                                              decoration: ShapeDecoration(
                                                  color: Colors.grey,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10))),
                                            )),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: onpress),
                                    ],
                                  )
                                : done == false
                                    ? Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  child: const Icon(
                                                      Icons.arrow_back,
                                                      color: Colors.white),
                                                  width: 50,
                                                  height: 50,
                                                  decoration: ShapeDecoration(
                                                      color: Colors.grey,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                )),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [acciones ?? Container()],
                                      ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
      });
}

load(BuildContext context, {bool colorSuave = false}) {
  // context = Get.context!;
  return showDialog(
      // barrierColor:
      // useSafeArea: tue,
      barrierColor: colorSuave == false
          ? const Color.fromRGBO(64, 62, 65, 0.5)
          : Colors.transparent,
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5.0,
          ),
          child: AlertDialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: Center(
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: double.infinity,
                child: (CircleAvatar(
                  radius: 30,
                  backgroundColor: Color.fromRGBO(64, 62, 65, 1),
                  child: Align(
                      alignment: Alignment.center,
                      child: Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.blue,
                          size: 25,
                        ),
                      )),
                )),
              ),
            ),
          ),
        );
      });
}

mensajeNegativo(
  context, {
  required Map respuesta,
}) {
  Size size = MediaQuery.of(Get.context!).size;
  // Navigator.pop(context);
  print(respuesta.toString() + 'Errors in Crear Usuario');
  dynamic res = json.encode(respuesta);

  print(res);
  var respModel = errorsFormModelFromJson(res);
  List<Widget> errors = [];

  try {
    respModel.errors!.forEach((key, value) {
      var index = errors.length / 2;
      errors
        ..add(Row(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.white,
              child: Center(
                child: Text(
                  // '${index.toString().replaceAll(new RegExp(r'.0'), '')}','
                  (index + 1).toString().replaceAll(".0", ""),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              width: size!.width / 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  value.join(),
                  overflow: TextOverflow.clip,
                ),
              ),
            ),
          ],
        ))
        ..add(Divider());
    });

    return alerta(
      context,
      code: true,
      done: true,
      contenido: Column(
        children: errors,
      ),
    );
  } catch (error) {
    return alerta(context, code: false, contenido: 'Error en el servidor');
  }
}

class MarqueeWidget extends StatefulWidget {
  final Widget child;
  final Axis direction;
  final Duration animationDuration, backDuration, pauseDuration;

  const MarqueeWidget({
    Key? key,
    required this.child,
    this.direction = Axis.horizontal,
    this.animationDuration = const Duration(milliseconds: 6000),
    this.backDuration = const Duration(milliseconds: 800),
    this.pauseDuration = const Duration(milliseconds: 800),
  }) : super(key: key);

  @override
  _MarqueeWidgetState createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController(initialScrollOffset: 50.0);
    WidgetsBinding.instance.addPostFrameCallback(scroll);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: widget.child,
      scrollDirection: widget.direction,
      controller: scrollController,
    );
  }

  void scroll(_) async {
    while (scrollController.hasClients) {
      await Future.delayed(widget.pauseDuration);
      if (scrollController.hasClients) {
        await scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: widget.animationDuration,
          curve: Curves.ease,
        );
      }
      await Future.delayed(widget.pauseDuration);
      if (scrollController.hasClients) {
        await scrollController.animateTo(
          0.0,
          duration: widget.backDuration,
          curve: Curves.easeOut,
        );
      }
    }
  }
}

Widget start() {
  return Icon(Icons.star_rate_rounded, color: Colors.yellow, shadows: const [
    BoxShadow(
        color: Colors.black12,
        offset: Offset(1, 1),
        blurRadius: 0,
        spreadRadius: 0)
  ]);
}

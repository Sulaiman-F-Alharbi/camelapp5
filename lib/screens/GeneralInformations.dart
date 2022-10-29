import 'package:flutter/material.dart';

const Mainbrown = Color.fromRGBO(204, 123, 76, 1);
// const Mainbrown = Color.fromRGBO(137, 115, 88, 1);
const Mainbeige = const Color.fromRGBO(255, 240, 199, 1);

class GetInfoWidget extends StatefulWidget {
  const GetInfoWidget({Key? key}) : super(key: key);

  @override
  State<GetInfoWidget> createState() => _GetInfoWidgetState();
}

class _GetInfoWidgetState extends State<GetInfoWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              image: AssetImage("assets/images/background6.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Container(
                    width: 350,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Mainbrown,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    alignment: const AlignmentDirectional(
                        0.1499999999999999, 0.19999999999999996),
                    child: Container(
                      width: 350,
                      child: Stack(
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(-0.06, -0.85),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/magahem_icon.png',
                                width: 330,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(0, 0.75),
                            child: Container(
                              width: 330,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Mainbeige,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              alignment: const AlignmentDirectional(
                                  0.19999999999999996, 0.19999999999999996),
                              child: const Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 10, 0),
                                  child: Text(
                                    'المجاهيم:\nوتسمى أيضا السود والملح والنجدية والجنوبية. المجاهيم وهي إبل سوداء حالكة السواد.\n وتقسم الى المجاهيم الدوسرية، والمجاهيم المرية. وتمتاز الدوسرية بجمال شكلها وصغر حجمها اذا ما قورنت بالمرية حيث أن الأخيرة أكبر حجما وأكثر ادرارا للحليب، وهي أضخم أنواع الإبل في الجزيرة وتختلف في المشية عن باقي الأنواع وموطنها الأصلي جنوب نجد (وادي الدواسر) وشرق الجزيرة.',
                                    textAlign: TextAlign.center,
                                    textDirection: TextDirection.rtl,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Container(
                    width: 350,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Mainbrown,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    alignment:
                        const AlignmentDirectional(0.25, 0.19999999999999996),
                    child: Container(
                      width: 350,
                      child: Stack(
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(0, 0.75),
                            child: Container(
                              width: 330,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Mainbeige,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 10, 10),
                                child: Text(
                                  'الشعل:\nأقل انتشارا من المجاهيم والوضح. تتميز بلون واحد يغطي كامل جسمها لونها يتراوح بين البني الباهت ولأصفر الداكن الضـــارب للبني والبني الضارب للحـــمرة\nالشعل هي ابل متوسطة الى عالية الانتاج من اللبن.\nحجمها كبير ويتراوح وزن الناقة البالغة بين 500 الى 700 كيلوجرام.',
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(0, -0.85),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/sheal_icon.png',
                                width: 330,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Container(
                    width: 350,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Mainbrown,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    alignment:
                        const AlignmentDirectional(0.25, 0.19999999999999996),
                    child: Stack(
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(0, 0.75),
                          child: Container(
                            width: 330,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Mainbeige,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Align(
                              alignment: AlignmentDirectional(0, -0.4),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 10, 0),
                                child: Text(
                                  'الوضح:\nوهي إبل بيضاء جميلة طويلة الأعناق ولكنها أقل حجماً من المجاهيم.\nهي ثاني أكثر الانواع انتشارا في مناطق المملكة المختلفة.\nالمغاتير هي ابل انتاجية تعرف بانتاجها العالي من اللبن ولكن أقل من المجاهيم بشكل عام.\nحجمها كبير ويتراوح وزن الناقة البالغة من 480 الى 700 كيلوجرام.',
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0, -0.85),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/images/wedeh_icon.png',
                              width: 330,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Container(
                    width: 350,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Mainbrown,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    alignment:
                        const AlignmentDirectional(0.25, 0.19999999999999996),
                    child: Stack(
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(0, 0.75),
                          child: Container(
                            width: 330,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Mainbeige,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10, 10, 10, 10),
                              child: Text(
                                'الشقح:\nأقل انتشارا من المجاهيم والوضح. ولونها أشقر ولون وبرها مائل للسواد. الشقح هي ابل متوسطة الى عالية الانتاج من اللبن.\nوحجمها كبير ووزن الناقة البالغة يتراوح بين 500 الى 700 كيلوجرم.',
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0, -0.85),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/images/sheqeh_icon.png',
                              width: 330,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Container(
                    width: 350,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Mainbrown,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    alignment:
                        const AlignmentDirectional(0.25, 0.19999999999999996),
                    child: Stack(
                      children: [
                        Align(
                          alignment: const AlignmentDirectional(0, 0.75),
                          child: Container(
                            width: 330,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Mainbeige,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10, 10, 10, 10),
                              child: Text(
                                'الحمر:\nتسمى بحمر النعم وهي أقل انتشارا من المجاهيم والوضح. ولونها أحمر وتتميز بعضها بوجود بياض في يديها. الحمر هي ابل متوسطة الى عالية الانتاج من اللبن.\nوحجمها كبير ووزن الناقة البالغة يتراوح بين 500 الى 700 كيلوجرم.',
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0, -0.85),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/images/homor_icon.png',
                              width: 330,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                  child: Container(
                    width: 350,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Mainbrown,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    alignment:
                        const AlignmentDirectional(0.25, 0.19999999999999996),
                    child: Container(
                      width: 350,
                      child: Stack(
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(0, 0.75),
                            child: Container(
                              width: 330,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Mainbeige,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 10, 10),
                                child: Text(
                                  'الصفر:\nأقل انتشارا من المجاهيم والوضح. ولونها بني مثل حبة القهوة الداكنة ولون وبرها أسود. والصفر هي ابل عالية الانتاج من اللبن.\nحجمها كبير ويتراوح وزن الناقة البالغة من 500 الى 700 كيلوجرام.',
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(0, -0.85),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/sofor_icon.png',
                                width: 330,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

Widget textFromField(
    {bool check = false,
    required TextEditingController textEditingController,
    required String hint,
    required String? Function(String?)? validator,
    required TextInputType textInputType}) {
  return TextFormField(
    obscureText: check ? true : false,
    controller: textEditingController,
    validator: validator,
    keyboardType: textInputType,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
          color: Colors.black, fontSize: 13, fontWeight: FontWeight.normal),
    ),
    style: const TextStyle(
        color: Colors.black, fontSize: 15, fontWeight: FontWeight.normal),
  );
}

Widget materialButton({
  required Function() function,
  required String data,
}) {
  return MaterialButton(
    onPressed: function,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    child: Text(
      data,
      style: const TextStyle(
          color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
    ),
  );
}

void navigator({required BuildContext context, required Widget widget}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void navigatorPushReplecement(
    {required BuildContext context, required Widget widget}) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}

Widget containerHome({
  String? image,
  required String title,
  required String desc,
  required Function() function,
  required Function() functionType,
}) {
  return InkWell(
    onTap: function,
    child: Container(
      width: double.infinity,
      height: 240,
      padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            height: 240,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Image.network(
              image ??
                  "https://cdn.theatlantic.com/thumbor/2_pcUPPR-NmuHg3WJYiPEn-9zdg=/0x0:4800x2700/960x540/media/img/mt/2023/01/Dumb_Questions_02/original.jpg",
              fit: BoxFit.fill,
            ),
          ),
          Container(
            width: double.infinity,
            height: 240,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10)),
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(desc,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.normal)),
              ],
            ),
          ),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: IconButton(
                onPressed: functionType,
                icon: const Icon(
                  Icons.delete,
                  size: 30,
                  color: Colors.white,
                )),
          )
        ],
      ),
    ),
  );
}

Widget correctAnswer({
  required int number,
  required String name,
}) {
  return Container(
    width: 130,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      children: [
        Expanded(
            flex: 1,
            child: Container(
              height: 35,
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(7),
                      bottomStart: Radius.circular(7))),
              alignment: Alignment.center,
              child: Text(
                "$number",
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            )),
        Expanded(
            flex: 2,
            child: Container(
              height: 35,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadiusDirectional.only(
                      topEnd: Radius.circular(7),
                      bottomEnd: Radius.circular(7))),
              alignment: Alignment.center,
              child: Text(
                name,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            )),
      ],
    ),
  );
}

Widget question({
  required String ques,
  required String option1,
  required String option2,
  required String option3,
  required String option4,
  required Function() function1,
  required Function() function2,
  required Function() function3,
  required Function() function4,
  required List<List> list,
  required int index,
}) {
  return SizedBox(
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$index. $ques",
            style: const TextStyle(
                color: Colors.black,
                fontSize: 19,
                fontWeight: FontWeight.normal),
          ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: function1,
            child: Row(
              children: [
                Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: list[index - 1][0] ? Colors.green : null,
                      border: list[index - 1][0]
                          ? null
                          : Border.all(color: Colors.grey)),
                  alignment: Alignment.center,
                  child: Text(
                    "A",
                    style: TextStyle(
                        color: list[index - 1][0] ? Colors.white : Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  option1,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: function2,
            child: Row(
              children: [
                Container(
                    alignment: AlignmentDirectional.center,
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: list[index - 1][1] ? Colors.red : null,
                        border: list[index - 1][1]
                            ? null
                            : Border.all(color: Colors.grey)),
                    child: Text(
                      "B",
                      style: TextStyle(
                          color:
                              list[index - 1][1] ? Colors.white : Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  option2,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: function3,
            child: Row(
              children: [
                Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                        color: list[index - 1][2] ? Colors.red : null,
                        shape: BoxShape.circle,
                        border: list[index - 1][2]
                            ? null
                            : Border.all(color: Colors.grey)),
                    alignment: Alignment.center,
                    child: Text(
                      "C",
                      style: TextStyle(
                          color:
                              list[index - 1][2] ? Colors.white : Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  option3,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: function4,
            child: Row(
              children: [
                Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                        color: list[index - 1][3] ? Colors.red : null,
                        shape: BoxShape.circle,
                        border: list[index - 1][3]
                            ? null
                            : Border.all(color: Colors.grey)),
                    alignment: Alignment.center,
                    child: Text(
                      "D",
                      style: TextStyle(
                          color:
                              list[index - 1][3] ? Colors.white : Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  option4,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

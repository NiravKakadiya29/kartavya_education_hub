import 'package:flutter/services.dart';
import '/const/consts.dart';

import 'HomePage.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 25),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            Get.to(HomePage());
          },
          child: const Text("Verify OTP"),
        ),
      ),
      backgroundColor: Color(0xffefeeee),
      appBar: AppBar(
        leading: BackButton(),
        title: 'OTP'.text.make(),
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  "./lib/assets/images/otp.png",
                  width: 350,
                ),
              ),
              Text(

                "Verification OTP",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              10.heightBox,
              Padding(
                padding: const EdgeInsets.only(right: 50.0, left: 50),
                child:
                    'We have sent the code verification to Your  Mobile Number'
                        .text
                        .color(Colors.black54)
                        .make(),
              ),
              10.heightBox,
              '+91-1234567890'.text.bold.make(),
              20.heightBox,
              Form(
                  child: Padding(
                padding: const EdgeInsets.only(right: 30.0, left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NeuBox(
                      distance: 20.0,
                      bgColor: 0xffefeeee,
                      topLeft: 0xffffffff,
                      bottomRight: 0xffd1d0d0,
                      blurRadius: 30.0,
                      borderRadius: 10.0,
                      width: 64.0,
                      height: 68.0,
                      child: TextFormField(
                        decoration: InputDecoration(border: InputBorder.none),
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        style: Theme.of(context).textTheme.headlineMedium,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    NeuBox(
                      distance: 20.0,
                      bgColor: 0xffefeeee,
                      topLeft: 0xffffffff,
                      bottomRight: 0xffd1d0d0,
                      blurRadius: 30.0,
                      borderRadius: 10.0,
                      width: 64.0,
                      height: 68.0,
                      child: TextFormField(
                        decoration: InputDecoration(border: InputBorder.none),
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        style: Theme.of(context).textTheme.headlineMedium,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    NeuBox(
                      distance: 20.0,
                      bgColor: 0xffefeeee,
                      topLeft: 0xffffffff,
                      bottomRight: 0xffd1d0d0,
                      blurRadius: 30.0,
                      borderRadius: 10.0,
                      width: 64.0,
                      height: 68.0,
                      child: TextFormField(
                        decoration: InputDecoration(border: InputBorder.none),
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        style: Theme.of(context).textTheme.headlineMedium,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    NeuBox(
                      distance: 20.0,
                      bgColor: 0xffefeeee,
                      topLeft: 0xffffffff,
                      bottomRight: 0xffd1d0d0,
                      blurRadius: 30.0,
                      borderRadius: 10.0,
                      width: 64.0,
                      height: 68.0,
                      child: TextFormField(
                        decoration: InputDecoration(border: InputBorder.none),
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        style: Theme.of(context).textTheme.headlineMedium,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

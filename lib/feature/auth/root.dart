import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lateef/feature/auth/auth_cubit.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../core/app_startup.dart';
import '../../core/navigation/navigation_service.dart';
import '../root/route/routes.dart';
import '../root/widgets/circle_logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 50.0),
                child:  CircleWidget(text: 'LOGO APP'),
              ),
              Form(
                key: formKey,
                child: BlocConsumer(
                  bloc: getIt<AuthCubit>(),
                  listener: (context, state) {
                    if (state is LoginLoading) {
                      context.loaderOverlay.show();
                    }
                    if (state is LoginSuccess) {
                      context.loaderOverlay.hide();
                      getIt<NavigationService>().to(routeName: RootRoutes.home);
                    }
                    if (state is LoginError) {
                      context.loaderOverlay.hide();
                      final snackBar = SnackBar(
                        content: Text(state.message),
                        backgroundColor: (Colors.red),
                        action: SnackBarAction(
                          label: 'dismiss',
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(30, 20, 30, 30),
                          child: TextFormField(
                            controller: usernameController,
                            keyboardType: TextInputType.text,
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Field is required";
                              }
                              return null;
                            },
                            decoration:
                                const InputDecoration(hintText: "USERNAME"),
                          ),
                        ),
                        Container(
                          //padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                          margin: const EdgeInsets.fromLTRB(30, 10, 30, 20),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Field is required";
                              }
                              return null;
                            },
                            decoration:
                                const InputDecoration(hintText: "PASSWORD"),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.fromLTRB(220, 0, 0, 30),
                            child: const Text('FORGET PASSWORD')),
                      ],
                    );
                  },
                ),
              ),
              InkWell(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    login();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 5.0, 0.0, 5.0),
                  margin: const EdgeInsets.fromLTRB(100, 20, 100, 40),
                  height: 35.0,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(18.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'SIGN IN',
                        style: TextStyle(
                            fontSize: 18.0.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 30.0.w,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  login() {
    getIt<AuthCubit>().login(
        username: usernameController.text, password: passwordController.text);
  }
}

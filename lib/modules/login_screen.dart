import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopapp/bloc/state.dart';
import 'package:shopapp/modules/layout_screen.dart';
import 'package:shopapp/modules/register_screen.dart';
import 'package:shopapp/network/local/cachehelper.dart';
import 'package:shopapp/shared/components.dart';

import '../bloc/cubit.dart';
import '../shared/constant.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        if (state is ShopAppSuccessLoginDataState) {
          if (state.model.status == true) {
            CacheHelper.saveData(key: 'token', value: state.model.data!.token)
                .then((value) {
              if (value) {
                token = state.model.data!.token!;
              }

              print('$token in login');

              myToast(
                  state: state.model.message, toastState: toastState.Success);
              navigateAndRemove(widget: LayoutScreen(), context: context);
            }).catchError((error) {
              print(error + 'Error in save token');
            });
            print(token);
          } else {
            myToast(state: state.model.message, toastState: toastState.Error);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white, //HexColor('FF8F0A'),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            const Image(
                              image: AssetImage('images/login.png'),
                              width: 200,
                              height: 200,
                            ),
                            Text(
                              'Login now to browse our hot offers',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(color: Colors.grey[400]),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      //Email
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Email Address is too short';
                          }
                        },
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: HexColor('FF8F0A'),
                            )),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: HexColor('FF8F0A'),
                            ),
                            labelText: 'Email Address',
                            labelStyle: TextStyle(
                              color: HexColor('FF8F0A'),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.elliptical(5, 5)))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //Password
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Password is too short';
                          }
                        },
                        obscureText: ShopAppCubit.get(context).isShowPassIcon,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: HexColor('FF8F0A'),
                          )),
                          prefixIcon: Icon(
                            Icons.password_outlined,
                            color: HexColor('FF8F0A'),
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: HexColor('FF8F0A'),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              ShopAppCubit.get(context).changePassIcon(
                                  isShow:
                                      ShopAppCubit.get(context).isShowPassIcon);
                            },
                            icon: Icon(
                              ShopAppCubit.get(context).passIcon,
                              color: HexColor('FF8F0A'),
                            ),
                          ),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.elliptical(5, 5))),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      if (state is ShopAppLoadingLoginDataState)
                        Center(
                          child: CircularProgressIndicator(
                            color: HexColor('FFAA47'),
                          ),
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: HexColor('FFAA47'),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              print(emailController.text);
                              print(passwordController.text);
                              ShopAppCubit.get(context).postLoginData(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          height: 40,
                          padding: EdgeInsetsDirectional.all(10),
                          child: Text(
                            'Login'.toUpperCase(),
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                          TextButton(
                            onPressed: () {
                              navigateTo(context, RegisteScreen());
                            },
                            child: Text(
                              'REGISTER',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: HexColor('FFAA47'),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

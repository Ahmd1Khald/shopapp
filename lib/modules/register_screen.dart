import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopapp/bloc/state.dart';
import 'package:shopapp/modules/login_screen.dart';
import 'package:shopapp/network/local/cachehelper.dart';
import 'package:shopapp/shared/components.dart';

import '../bloc/cubit.dart';
import '../shared/constant.dart';

class RegisteScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        if (state is ShopAppSuccessRegisterDataState) {
          if (state.model.status == true) {
            CacheHelper.saveData(key: 'token', value: state.model.data!.token)
                .then((value) {
              if (value) {
                token = CacheHelper.getDate(key: 'token');
              }
              token = state.model.data!.token!;
              myToast(
                  state: state.model.message, toastState: toastState.Success);
            }).catchError((error) {
              print('$error Error in save token');
            });
            print(token);
          } else {
            myToast(state: state.model.message, toastState: toastState.Error);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                icon: const Icon(Icons.chevron_left),
                color: HexColor('FFAA47'),
                iconSize: 40),
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
                      const Center(
                          child: Image(
                        image: AssetImage('images/registe.png'),
                        width: 200,
                        height: 200,
                      )),
                      Text(
                        'Registe now to browse our hot offers',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.grey[400]),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: nameController,
                              keyboardType: TextInputType.name,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Name Address is too short';
                                }
                              },
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: HexColor('FFAA47'),
                                  )),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: HexColor('FFAA47'),
                                  ),
                                  labelText: 'Name',
                                  labelStyle: TextStyle(
                                    color: HexColor('FFAA47'),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.elliptical(5, 5)))),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Phone is too short';
                                }
                              },
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: HexColor('FFAA47'),
                                  )),
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: HexColor('FFAA47'),
                                  ),
                                  labelText: 'Phone',
                                  labelStyle: TextStyle(
                                    color: HexColor('FFAA47'),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.elliptical(5, 5)))),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
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
                              color: HexColor('FFAA47'),
                            )),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: HexColor('FFAA47'),
                            ),
                            labelText: 'Email Address',
                            labelStyle: TextStyle(
                              color: HexColor('FFAA47'),
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
                            color: HexColor('FFAA47'),
                          )),
                          prefixIcon: Icon(
                            Icons.password_outlined,
                            color: HexColor('FFAA47'),
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: HexColor('FFAA47'),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              ShopAppCubit.get(context).changePassIcon(
                                  isShow:
                                      ShopAppCubit.get(context).isShowPassIcon);
                            },
                            icon: Icon(
                              ShopAppCubit.get(context).passIcon,
                              color: HexColor('FFAA47'),
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.elliptical(5, 5))),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      if (state is ShopAppLoadingRegisterDataState)
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          color: HexColor('FFAA47'),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              print(emailController.text);
                              print(passwordController.text);
                              print(nameController.text);
                              print(phoneController.text);
                              ShopAppCubit.get(context).postRegisterData(
                                  email: emailController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text,
                                  context: context);
                            }
                          },
                          padding: EdgeInsetsDirectional.all(10),
                          child: Text(
                            'registe'.toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                        ),
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

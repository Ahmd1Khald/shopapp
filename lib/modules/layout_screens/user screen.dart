import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopapp/shared/constant.dart';

import '../../bloc/cubit.dart';
import '../../bloc/state.dart';
import '../../shared/components.dart';

class UserScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ShopAppCubit.get(context).getUserData();
    //ShopAppCubit.get(context).getFavoritesModel();
    ShopAppCubit.get(context).getHomeData();
    ShopAppCubit.get(context).getCategoriesData();
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        if (state is ShopAppSuccessPutUpdateDataState) {
          if (state.model.status) {
            myToast(state: state.model.message, toastState: toastState.Success);
          } else {
            myToast(state: state.model.message, toastState: toastState.Error);
          }
        } else if (state is ShopAppErrorPutUpdateDataState) {
          myToast(state: 'Data is repeated', toastState: toastState.Error);
        }
      },
      builder: (context, state) {
        nameController.text =
            ShopAppCubit.get(context).userModelData!.data.name;
        emailController.text =
            ShopAppCubit.get(context).userModelData!.data.email;
        phoneController.text =
            ShopAppCubit.get(context).userModelData!.data.phone;

        return Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                        height: 250,
                        child: Center(
                          child: Image(
                            image: AssetImage('images/update.png'),
                            fit: BoxFit.cover,
                          ),
                        )),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            enabled: ShopAppCubit.get(context).enableUpdate,
                            cursorColor: mainColor,
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
                                border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.elliptical(5, 5)))),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            enabled: ShopAppCubit.get(context).enableUpdate,
                            cursorColor: mainColor,
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
                                border: const OutlineInputBorder(
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
                      enabled: ShopAppCubit.get(context).enableUpdate,
                      cursorColor: mainColor,
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
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.elliptical(5, 5)))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
//Password
                    const SizedBox(
                      height: 30,
                    ),
                    if (state is ShopAppLoadingRegisterDataState)
                      Center(
                        child: CircularProgressIndicator(
                          color: HexColor('FFAA47'),
                        ),
                      ),

                    Row(
                      children: [
                        Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            color: HexColor('FFAA47'),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                ShopAppCubit.get(context).getUpdateData(
                                  phone: phoneController.text,
                                  name: nameController.text,
                                  email: emailController.text,
                                );
                              }
                            },
                            padding: EdgeInsetsDirectional.all(10),
                            child: Text(
                              'Updata'.toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                        const Spacer(),
                        FloatingActionButton(
                          backgroundColor: mainColor,
                          onPressed: () {
                            ShopAppCubit.get(context).changeEnableUpdate();
                          },
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

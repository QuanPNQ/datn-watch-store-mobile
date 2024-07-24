import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mob/blocs/shipping_address/shipping_address_bloc.dart';
import 'package:flutter_mob/blocs/shipping_address/shipping_address_event.dart';
import 'package:flutter_mob/blocs/shipping_address/shipping_address_state.dart';
import 'package:flutter_mob/configs/colors.dart';
import 'package:flutter_mob/configs/constants.dart';
import 'package:flutter_mob/models/shipping_address/shipping_address.dart';
import 'package:flutter_mob/ui/components/app_bar/app_bar_title.dart';
import 'package:flutter_mob/ui/components/button/button_normal.dart';
import 'package:flutter_mob/ui/components/input/input_field.dart';
import 'package:flutter_mob/ui/components/scroll_behavior/scroll_behavior.dart';
import 'package:flutter_mob/utils/Loading_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NewShippingAddressScreen extends StatefulWidget {
  final ShippingAddress? shippingAddress;

  const NewShippingAddressScreen({super.key, this.shippingAddress});

  @override
  State<NewShippingAddressScreen> createState() => _NewShippingAddressState();
}

class _NewShippingAddressState extends State<NewShippingAddressScreen> {
  List<ShippingAddress> listShippingAddress = [];
  final TextEditingController editingNameController = TextEditingController();
  final TextEditingController editingPhoneController = TextEditingController();
  final TextEditingController editingAddressController =
      TextEditingController();
  final TextEditingController editingTitleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.shippingAddress != null) {
      editingNameController.text = widget.shippingAddress!.receiver;
      editingAddressController.text = widget.shippingAddress!.address;
      editingPhoneController.text = widget.shippingAddress!.phoneNumber;
      editingTitleController.text = widget.shippingAddress!.title ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShippingAddressBloc, ShippingAddressState>(
      listener: (context, state) async {
        if (state is ShippingAddressLoadingState) {
          LoadingHelper.showLoading(context);
        } else if (state is AddNewAddressSuccessState) {
          LoadingHelper.hideLoading(context);
          Navigator.pop(context, true);
        } else if (state is AddNewAddressErrorState) {
          LoadingHelper.hideLoading(context);
          Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (state is UpdateAddressSuccessState) {
          LoadingHelper.hideLoading(context);
          Navigator.pop(context, true);
        } else if (state is UpdateAddressErrorState) {
          LoadingHelper.hideLoading(context);
          Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (state is DeleteAddressSuccessState) {
          LoadingHelper.hideLoading(context);
          Navigator.pop(context, true);
        } else if (state is DeleteAddressErrorState) {
          LoadingHelper.hideLoading(context);
          Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.kPrimaryColor,
        body: SafeArea(
          child: Column(
            children: [
              AppBarTitle(
                  appTitle: widget.shippingAddress != null
                      ? StringName.updateShippingAddress
                      : StringName.newShippingAddress),
              Expanded(
                child: ScrollConfiguration(
                  behavior: CustomScrollBehavior(),
                  child: ListView(
                    children: [
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 6,
                              ),
                              InputField(
                                hintText: StringName.name,
                                controller: editingNameController,
                                validator: validateEmpty,
                              ),
                              SizedBox(height: 12),
                              InputField(
                                hintText: StringName.phone,
                                controller: editingPhoneController,
                                validator: validateEmpty,
                              ),
                              SizedBox(height: 12),
                              InputField(
                                hintText: StringName.address,
                                controller: editingAddressController,
                                validator: validateEmpty,
                              ),
                              SizedBox(height: 12),
                              InputField(
                                hintText: StringName.note,
                                controller: editingTitleController,
                              ),
                              SizedBox(height: 24),
                              if (widget.shippingAddress != null)
                                Column(
                                  children: [
                                    ButtonNormal(
                                      text: StringName.deleteAddress,
                                      onPressed: handleDelete,
                                      backgroundColor: AppColors.kPrimaryColor,
                                      borderColor: AppColors.kPrimaryColor,
                                      textColor: AppColors.buttonRed,
                                      height: 30,
                                      width: 200,
                                    ),
                                    SizedBox(height: 12),
                                  ],
                                ),
                              ButtonNormal(
                                text: StringName.complete,
                                onPressed: handleComplete,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  handleComplete() {
    if (_formKey.currentState?.validate() ?? false) {
      if (widget.shippingAddress != null) {
        BlocProvider.of<ShippingAddressBloc>(context).add(UpdateAddressEvent(
          shippingAddressId: widget.shippingAddress!.id,
          title: editingTitleController.text.isNotEmpty
              ? editingTitleController.text
              : null,
          address: editingAddressController.text,
          phoneNumber: editingPhoneController.text,
          receiver: editingNameController.text,
        ));
      } else {
        BlocProvider.of<ShippingAddressBloc>(context).add(AddNewAddressEvent(
          title: editingTitleController.text.isNotEmpty
              ? editingTitleController.text
              : null,
          address: editingAddressController.text,
          phoneNumber: editingPhoneController.text,
          receiver: editingNameController.text,
        ));
      }
    }
  }

  handleDelete() {
    BlocProvider.of<ShippingAddressBloc>(context).add(DeleteAddressEvent(
      shippingAddressId: widget.shippingAddress!.id,
    ));
  }

  String? validateEmpty(value) {
    if (value == null || value.isEmpty) {
      return StringName.notAllowEmpty;
    }
    return null;
  }
}

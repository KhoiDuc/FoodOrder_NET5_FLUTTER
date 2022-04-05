import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/bloc/Home/HomeBloc.dart';
import 'package:food_delivery/bloc/Profile/ProfileBloc.dart';
import 'package:food_delivery/bloc/Profile/ProfileState.dart';
import 'package:food_delivery/pages/adress/Address.dart';
import 'package:food_delivery/pages/login_signup/Login.dart';
import 'package:food_delivery/services/UserServices.dart';
import 'package:url_launcher/url_launcher.dart';
import 'change_password.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}
class _BodyState extends State<Body> {
  Future<void> _makeSocialMediaRequest(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  Widget _buildLoadeState(BuildContext context, ProfileLoadedState state) {
    return SingleChildScrollView(
      child:Column(
        children: [
          ProfilePic(),
          //SizedBox(height: 20),
          ProfileMenu(
            icon: Icon(Icons.person),
            text: state.userVM.username + "_" + state.userVM.name,
            press: () {},
          ),
          ProfileMenu(
            icon: Icon(Icons.location_on_outlined),
            text: 'Địa chỉ',
            press: () {
              //context.read<AddressBloc>().fetchAll();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddressScreen(
                        addressScreenCallBack: null,
                      )));
            },
          ),
          ProfileMenu(
            icon: Icon(Icons.lock_outline_rounded),
            text: 'Đổi mật khẩu',
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangePasswordScreen()));
            },
          ),
          ProfileMenu(
            icon: Icon(Icons.phone),
            text: '0392131844',
            press: () {},
          ),
          ProfileMenu(
            icon: Icon(Icons.email),
            text: 'Email hỗ trợ',
            press: () {
              //FOR EMAIL
              final Uri _emailLaunchUri = Uri(
                  scheme: 'mailto',
                  path: 'khoimessi99@gmail.com',
                  queryParameters: {'subject': 'Khách hàng'});
              setState(() {
                _makeSocialMediaRequest(_emailLaunchUri.toString());
              });
            },
          ),
          ProfileMenu(
            icon: Icon(Icons.adb),
            text: 'Hỗ trợ viên 0938751116',
            press: () {
              setState(() {
                _makePhoneCall('tel:0938751116');
              });
            },
          ),
          ProfileMenu(
            icon: Icon(Icons.logout),
            text: 'Đăng xuất',
            press: () async {
              UserServices userServices = UserServices();
              await userServices.logout();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }), (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildErrorState(ProfileErrorState state) {
    return Container(
      child: Center(child: Text(state.error)),
    );
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoadedState) {
          return _buildLoadeState(context, state);
        }
        if (state is ProfileLoadingState) {
          return _buildLoadingState();
        }
        if (state is ProfileErrorState) {
          return _buildErrorState(state);
        }
        throw "Unknow state";
      },
    );
  }
}

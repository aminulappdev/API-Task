import 'package:api_task/Data/Models/network_response.dart';
import 'package:api_task/Data/Models/profile_model.dart';
import 'package:api_task/Data/Services/network_caller.dart';
import 'package:api_task/Data/Utils/urls.dart';
import 'package:api_task/UI/Widgets/show_snackbar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool inProgress = false;
  ProfileModel? profileModel;

  @override
  void initState() {
    super.initState();
    profileDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Profile details',
          ),
        ),
        body: Visibility(
          visible: !inProgress,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                      image: DecorationImage(
                          image: NetworkImage(
                              profileModel?.data?.profilePicture ?? ''),
                          fit: BoxFit.scaleDown)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'First Name : ${profileModel?.data?.firstName ?? ''}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Last Name :  ${profileModel?.data?.lastName ?? ''}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Email :  ${profileModel?.data?.email ?? ''}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Role :  ${profileModel?.data?.role ?? ''}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Status :  ${profileModel?.data?.status ?? ''}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void profileDetails() async {
    inProgress = true;
    setState(() {});

    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.profileDetailsUrl);
    inProgress = false;
    setState(() {});

    if (response.isSuccess) {
      profileModel = ProfileModel.fromJson(response.responseData);
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universities/logic/event/dashboard_event.dart';

import '../../logic/bloc/dashboard_bloc.dart';
import '../../logic/state/dashboard_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: BlocConsumer<DashBoardBloc, DashBoardState>(
        listener: (context, state) {
          if (state == const InitialDashBoard()) {}
        },
        builder: (context, state) {
          if (state.runtimeType == const DashBoardError().runtimeType) {
            return const Center(
              child: Text(
                'Something went Wrong',
                style: TextStyle(fontSize: 20),
              ),
            );
          }

          if (state.runtimeType == const DashBoardLoading().runtimeType ||
              state.runtimeType == const InitialDashBoard().runtimeType) {
            context.read<DashBoardBloc>().add(InitializeDashBoard());
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: _profile(state).image, fit: BoxFit.cover),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 3)),
                ),
              ),
              Text(
                state.name!,
                style: const TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                'Age: ${state.age!}',
                style: const TextStyle(
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/universityPage');
                  },
                  child: const Text('Universities')),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/loginPage', ((route) => false));
                    FirebaseAuth.instance.signOut();
                  },
                  child: const Text('Logout')),
            ],
          );
        },
      ),
    );
  }

  Image _profile(DashBoardState state) {
    Image image;
    try {
      image = Image.network(
        state.imageURL!,
      );
    } catch (e) {
      image = Image.asset(
        'lib/assets/images/camera.png',
        width: 30,
        height: 30,
      );
    }
    return image;
  }
}

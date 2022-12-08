import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universities/logic/bloc/university_api_bloc.dart';
import 'package:universities/logic/event/university_api_event.dart';
import 'package:universities/logic/state/university_api_state.dart';

class UniversityPage extends StatelessWidget {
  const UniversityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Universities')),
      body: BlocConsumer<UniversityApiBloc, UniversityApiState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.runtimeType == UniversityApiErrorState().runtimeType) {
            return const Center(
              child: Text(
                'Something went Wrong',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            );
          }

          if (state.runtimeType ==
              const UniversityApiInitialState().runtimeType) {
            context
                .read<UniversityApiBloc>()
                .add(const UniversityApiInitializeEvent());
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }

          return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: state.universities!.length,
              shrinkWrap: true,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.school_rounded,
                      size: 35,
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: ((context) {
                            return SimpleDialog(
                                alignment: Alignment.center,
                                title: Center(
                                    child: Text(
                                  state.universities![index].name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 20),
                                )),
                                children: [
                                  Center(
                                    child: Text(
                                        'Country : ${state.universities![index].country} (${state.universities![index].alpha_two_code})'),
                                  ),
                                  Center(
                                    child: Text(
                                        'State : ${state.universities![index].state_province}'),
                                  ),
                                  Center(
                                    child: Text(
                                        'Domain : ${state.universities![index].domains[0]}'),
                                  ),
                                  Center(
                                    child: Text(
                                        'Web Page : ${state.universities![index].web_pages[0]}'),
                                  ),
                                ]);
                          }));
                    },
                    tileColor: Colors.grey.shade200,
                    title: Text(
                      state.universities![index].name,
                    ),
                  ),
                );
              }));
        },
      ),
    );
  }
}

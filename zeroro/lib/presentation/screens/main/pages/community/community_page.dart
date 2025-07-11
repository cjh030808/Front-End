import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zeroro/dependency_injection.dart';
import 'package:zeroro/presentation/routes/route_path.dart';
import '../../../../../core/constants.dart';
import 'bloc/community_bloc.dart';
import 'commponents/post_widget.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CommunityBloc>()..add(PostsInitialized()),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: const Text(
                  'Community',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                centerTitle: true,
              ),
              BlocBuilder<CommunityBloc, CommunityState>(
                builder: (context, state) {
                  return state.status == Status.success
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.postList.length,
                          itemBuilder: (context, index) {
                            return PostWidget(post: state.postList[index]);
                          },
                        )
                      : const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.push(RoutePath.newPost);
          },
          child: const Icon(Icons.mode_edit_outline),
        ),
      ),
    );
  }
}

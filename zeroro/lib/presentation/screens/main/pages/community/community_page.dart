import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zeroro/core/debug_print.dart';
import 'package:zeroro/presentation/routes/route_path.dart';
import '../../../../../core/constants.dart';
import 'bloc/community_bloc.dart';
import 'commponents/post_widget.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  
  @override
  void initState() {
    super.initState();
    context.read<CommunityBloc>().add(PostsInitialized());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: BlocConsumer<CommunityBloc, CommunityState>(
            listener: (context, state) {
              infoDebugPrint('state.shouldRefresh: ${state.shouldRefresh}');
              if (state.shouldRefresh) {
                context.read<CommunityBloc>().add(PostsInitialized());
              }
            },
            builder: (context, state) {
              return switch (state.status) {
                Status.success => CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      floating: true,
                      snap: true,
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
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return PostWidget(post: state.postList[index]);
                      }, childCount: state.postList.length),
                    ),
                  ],
                ),
                Status.error => const Text('Error'),
                _ => Center(child: const CircularProgressIndicator()),
              };
            },
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            onPressed: () {
              context.push(RoutePath.newPost);
            },
            child: const Icon(Icons.mode_edit_outline),
          ),
        ),
      ],
    );
  }
}

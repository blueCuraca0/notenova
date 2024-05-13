import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notenova/core/utils/constants.dart';
import 'package:notenova/core/utils/languages/generated/locale_keys.g.dart';
import 'package:notenova/features/tips/data/firebase_tips.dart';
import 'package:notenova/features/tips/presentation/state_management/tip_cubit.dart';
import 'package:notenova/features/tips/presentation/state_management/tip_states.dart';
import 'package:notenova/features/tips/presentation/widgets/tipbox.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<TipCubit>(
        create: (context) => TipCubit(FirebaseServiceTips()),
          child: const _HomePageInside()),
    );
  }
}


class _HomePageInside extends StatelessWidget{
  const _HomePageInside();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    context.read<TipCubit>().loadTips();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: MediaQuery.of(context).size.height * 0.2,
                pinned: true,
                backgroundColor: Theme.of(context).primaryColor,
                flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return FlexibleSpaceBar(
                      titlePadding: EdgeInsets.only(
                          top: constraints.maxHeight>110? constraints.maxHeight - 100: 0, bottom: constraints.maxHeight>110? 20: 0),
                      title: Row(
                        children: [
                          midSizedBoxWidth,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              midSizedBoxHeight,
                              Text(LocaleKeys.hello.tr(),
                                  style: Theme.of(context).textTheme.bodyLarge),
                              Text(LocaleKeys.lets_study.tr(), //TODO: make ! mark
                                  style: Theme.of(context).textTheme.bodySmall),
                              midSizedBoxHeight,
                            ],
                          ),
                          spacer,
                          const CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage('https://secure.gravatar.com/avatar/7381b9e7e146bf03b5ef62ce417b53a2.jpg?s=192&d=https%3A%2F%2Fa.slack-edge.com%2Fdf10d%2Fimg%2Favatars%2Fava_0024-192.png'),
                          ),
                          midSizedBoxWidth,
                        ],
                      ),
                      background:
                      ColoredBox(color: Theme.of(context).primaryColor),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      LocaleKeys.tips_and_tricks.tr(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                  ),
              ),
              ),
              ),
              BlocBuilder<TipCubit, TipState>(
                builder: (context, state) {
                  if (state is TipLoading) {
                    return SliverToBoxAdapter(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        color: Theme.of(context).primaryColorLight,
                        child: Center(
                          child: CircularProgressIndicator(color: Theme.of(context).primaryColorDark,),
                        ),
                      ),
                    );
                  }
                  else if (state is TipLoaded) {
                          return SliverList(delegate:
                          SliverChildBuilderDelegate((BuildContext context, int index){
                            return Container(
                            padding: lPadding,
                            color: Theme.of(context).primaryColorLight,
                            child: TipsBox(
                              tip: state.tips[index],
                            ),
                          );
                          },
                            childCount: state.tips.length,
                          ),
                          );
                        } else if (state is TipError){
                          return SliverToBoxAdapter(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              color: Theme.of(context).primaryColorLight,
                              child: Text(state.message),
                            ),
                          );
                        }
                        else{
                          return const SliverToBoxAdapter(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                  },
                  ),
              SliverToBoxAdapter(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
        ],
      ),
    );
  }
}



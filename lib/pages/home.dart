import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../utils/appbar.dart';

const String themeKey = 'theme';

class Home extends ConsumerWidget {
  final int themeNumber;
  final int selected_page;
  const Home(this.themeNumber, {required this.selected_page, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const PreferredSize(preferredSize: Size.fromHeight(50), child: Appbar()),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
            ),
            expandedHeight: MediaQuery.of(context).size.height / 3.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                    color: Colors.black26,
                ),
                child: const Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverList.list(children: [
            Padding(
                padding: const EdgeInsets.only(top : 2.0, left : 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Jump where you left", style: TextStyle(fontSize: 20),),
                    IconButton(onPressed: (){

                    }, icon: const Icon(Icons.menu)),
                    
                  ],
                ),
            ),
            Divider(height: 5,),
            Text("data"),
            Text("data"),
            Text("data"),
            Text("data"),
            Text("data"),
            Text("data"),
            Text("data"),
            Text("data"),
            Text("data"),
            Text("data"),
            Text("data"),
            Text("data"),
            Text("data"),
            Text("data"),
            Text("data"),
            Text("data"),
            Text("data"),
            Text("data"),
            Text("data"),
            Text("data"),
            Text("data"),
            Text("data"),
            Text("data"),
            Text("data"),
            Text("data"),
            Text("data"),
            Text("data"),
          ])
        ],
      ),
    );
  }

  Widget personTitle(){
    return 
  }
}
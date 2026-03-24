import 'package:bteams/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:bteams/core/theme/theme.dart';

class SelectShuffle extends StatelessWidget {
  const SelectShuffle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Selecione',
          style: TextStyle(fontFamily: 'SquareBold', fontSize: 20),
        ),
        centerTitle: true,
      ),
      backgroundColor: AppTheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(120, 158, 158, 158),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsetsGeometry.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Formação de Times',
                        style: TextStyle(fontSize: 35, fontFamily: 'Capital'),
                      ),
                      SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.createTeamBalanced,
                            );
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 2,
                          ),
                          child: Text(
                            'Equilibrada',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'Capital',
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.createTeamRandom,
                            );
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 2,
                          ),
                          child: Text(
                            'Aleatória',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'Capital',
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),
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
}

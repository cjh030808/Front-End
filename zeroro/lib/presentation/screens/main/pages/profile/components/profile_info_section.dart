import 'package:flutter/material.dart';
import 'package:zeroro/core/constants.dart';
import '../../../../../../core/theme/constant/app_color.dart';

class ProfileInfoSection extends StatelessWidget {
  const ProfileInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20) + EdgeInsets.only(top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // 프로필 사진
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 43,
                  backgroundColor: AppColors.primaryContainer,
                  backgroundImage: AssetImage("$baseImagePath/mock_image.jpg"),
                ),
              ),

              const SizedBox(width: 30),

              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '김오띠',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '@기모띠',
                    style: TextStyle(fontSize: 20, color: AppColors.secondary),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

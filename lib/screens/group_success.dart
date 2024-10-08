import 'package:flutter/material.dart';
import 'package:conta/config/theme.dart';
import 'package:conta/config/routes/router.dart';

class GroupSuccessScreen extends StatefulWidget {
  const GroupSuccessScreen({super.key});

  @override
  State<GroupSuccessScreen> createState() => _GroupSuccessScreenState();
}

class _GroupSuccessScreenState extends State<GroupSuccessScreen> {
  @override
  void initState() {
    super.initState();
    // Passar 4 segundos e ir para a tela home
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {  // Verifica se o widget ainda está montado
        Navigator.pushReplacementNamed(context, Routes.navigation);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: Image.asset(
              'assets/images/success_animate.gif',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.house_rounded,
                  color: Colors.yellow.shade700,
                  size: 100,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Viva!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textBigTitle,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Novo grupo criado',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textBigTitle,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Venha explorar seu novo grupo',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 32),
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.pushNamed(context, Routes.home);
                //   },
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: AppColors.primaryBlue,
                //     padding: const EdgeInsets.symmetric(
                //         horizontal: 50, vertical: 15),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(30),
                //     ),
                //   ),
                //   child: const Text(
                //     'Ir para o grupo',
                //     style: TextStyle(fontSize: 16, color: AppColors.textBigTitle),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

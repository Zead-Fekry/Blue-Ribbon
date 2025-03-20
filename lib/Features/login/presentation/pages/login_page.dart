 import 'package:flutter/material.dart';

 import '../../../../core/shared-widgets/spacing.dart';
import '../../../../core/styles/text_styles/app_text_styles.dart';
import '../../../signup/presentation/pages/register_page.dart';
import '../widgets/login_form.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [


                const SizedBox(
                  height: 15.0,
                ),
                Stack(
                  children: [
                    Center(
                      child: Text(
                        "Login",
                        style: TextStyles.font32BlueBold(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Padding(
                  padding:  EdgeInsets.symmetric(
                      horizontal: 30
                  ),
                  child:   LoginForm(),
                ),
              ],
            ),
          ),
          verticalSpace(10),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const RegisterPage() ));
            },
            child: Text(
               "Registration" ,
              style: TextStyles.font14BlueSemiBold(context),
            ),
          ),

        ],
      ),
    );
  }

}

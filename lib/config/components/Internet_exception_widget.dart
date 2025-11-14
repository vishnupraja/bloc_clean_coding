import 'package:flutter/material.dart';
import 'package:flutter_clean_coding/config/color/colors.dart';

class InternetExceptionWidget extends StatefulWidget {
  final VoidCallback callback;
  const InternetExceptionWidget({super.key, required this.callback});

  @override
  State<InternetExceptionWidget> createState() =>
      _InternetExceptionWidgetState();
}

class _InternetExceptionWidgetState extends State<InternetExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .15,
        ),
        const Icon(
          Icons.cloud_off,
          color: AppColors.red,
          size: 50,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Center(
            child: Text(
              "We are unable to show result. \nPlease check your internet connection.",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: AppColors.black, fontSize: 20),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .1,
        ),
        ElevatedButton(onPressed: widget.callback, child:   Center(
          child: Text(
            "RETRY",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodySmall

          ),
        ),)
      ],
    );
  }
}

import 'package:flutter/material.dart';

class CustomFutureBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final T? initialData;
  final Function(BuildContext context, Object? error)? onError;
  final Function(BuildContext context)? onLoading;
  final Function(BuildContext context, T data) onComplete;
  final Function(BuildContext context)? onEmpty;

  const CustomFutureBuilder(
      {super.key,
      required this.future,
      this.initialData,
      this.onError,
      this.onLoading,
      required this.onComplete,
      this.onEmpty});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      initialData: initialData,
      builder: (context, snapshot) {
        final status = snapshot.connectionState;

        if (snapshot.hasError) {
          if (onError != null) {
            return onError!(context, snapshot.error);
          }
        }

        if (status == ConnectionState.waiting) {
          if (onLoading != null) {
            return onLoading!(context);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }

        if (status == ConnectionState.done) {
          if (snapshot.hasData) {
            return onComplete(context, snapshot.data!);
          } else {
            if (onEmpty != null) {
              return onEmpty!(context);
            }
          }
        }

        return Container();
      },
    );
  }
}

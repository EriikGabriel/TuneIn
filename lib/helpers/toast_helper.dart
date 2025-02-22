// toast_helper.dart
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart'; // Certifique-se de importar a dependência correta

// Função para exibir um toast de sucesso
void showSuccessToast({
  required BuildContext context,
  required String title,
  required String content,
  Alignment alignment = Alignment.topCenter,
}) {
  toastification.show(
    context: context,
    type: ToastificationType.success,
    style: ToastificationStyle.flat,
    autoCloseDuration: const Duration(seconds: 3),
    title: Text(
      title,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    ),
    description: Text(content),
    alignment: alignment,
    animationDuration: const Duration(milliseconds: 100),
    icon: const Icon(Icons.check_circle),
    showIcon: true,
    primaryColor: Colors.green[900],
    backgroundColor: Colors.green,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(
        color: Color(0x07000000),
        blurRadius: 16,
        offset: Offset(0, 16),
        spreadRadius: 0,
      ),
    ],
    showProgressBar: true,
    closeOnClick: false,
    pauseOnHover: true,
    dragToClose: true,
    applyBlurEffect: true,
  );
}

// Função para exibir um toast de erro
void showErrorToast({
  BuildContext? context,
  required String title,
  required String content,
  AlignmentGeometry alignment = Alignment.bottomCenter,
}) {
  toastification.show(
    context: context,
    type: ToastificationType.error,
    style: ToastificationStyle.flat,
    autoCloseDuration: const Duration(seconds: 3),
    title: Text(
      title,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    ),
    description: Text(content),
    alignment: alignment,
    animationDuration: const Duration(milliseconds: 100),
    icon: const Icon(Icons.error),
    showIcon: true, // exibe ou oculta o ícone
    primaryColor: Colors.red[900],
    backgroundColor: Colors.red,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(
        color: Color(0x07000000),
        blurRadius: 16,
        offset: Offset(0, 16),
        spreadRadius: 0,
      ),
    ],
    showProgressBar: true,
    closeButtonShowType: CloseButtonShowType.onHover,
    closeOnClick: false,
    pauseOnHover: true,
    dragToClose: true,
    applyBlurEffect: true,
  );
}

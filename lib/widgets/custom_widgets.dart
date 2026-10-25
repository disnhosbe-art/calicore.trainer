import 'package:flutter/material.dart';

const Color appBg = Color(0xFF050D0D);
const Color appPanel = Color(0xFF101D1C);
const Color neonGreen = Color(0xFF9BFF32);
const Color mutedText = Color(0xFF9CAAA6);

class CaliButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final IconData icon;

  const CaliButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.icon = Icons.arrow_forward,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: neonGreen,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}

class CaliCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const CaliCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: appPanel,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: neonGreen.withOpacity(0.18),
        ),
      ),
      child: child,
    );
  }
}

class CaliStat extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const CaliStat({
    super.key,
    required this.title,
    required this.value,
    this.icon = Icons.bolt,
  });

  @override
  Widget build(BuildContext context) {
    return CaliCard(
      child: Column(
        children: [
          Icon(icon, color: neonGreen),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: mutedText,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

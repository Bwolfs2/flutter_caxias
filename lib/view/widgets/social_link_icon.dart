import 'package:flutter/material.dart';
import 'package:meetup_flutter_caxias/domain/entities/social_link.dart';

IconData socialLinkIcon(SocialLinkIconKind kind) {
  switch (kind) {
    case SocialLinkIconKind.calendar:
      return Icons.calendar_month_outlined;
    case SocialLinkIconKind.chat:
      return Icons.chat_bubble_outline;
    case SocialLinkIconKind.play:
      return Icons.play_circle_outline;
    case SocialLinkIconKind.code:
      return Icons.code;
    case SocialLinkIconKind.work:
      return Icons.work_outline;
  }
}

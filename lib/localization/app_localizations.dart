import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return AppLocalizations(Localizations.localeOf(context));
  }

  static const Map<String, Map<String, String>> _translations = {
    // =========================================================
    // ENGLISH
    // =========================================================
    'en': {
      'profile': 'MY PROFILE',
      'language': 'Language',
      'choose_language': 'Choose your language',
      'english': 'English',
      'arabic': 'Arabic',
      'french': 'French',
      'portuguese': 'Portuguese (Brazil)',
      'rating': 'Rate CaliCore',
      'rating_description': 'How would you rate your experience?',
      'submit_rating': 'Save rating',
      'play_store': 'Rate us on Google Play',
      'saved': 'Your rating has been saved.',
      'select_rating': 'Choose a rating first.',

      // Progress page
      'your_progress': 'YOUR PROGRESS',
      'progress_subtitle': 'Every rep brings you closer to your goal.',
      'workout_challenge': 'Workout Challenge',
      'completed': 'Completed',
      'workouts': 'workouts',
      'workouts_left': 'workouts left',
      'challenge_completed': 'Challenge completed!',
      'your_statistics': 'Your Statistics',
      'total_reps': 'Total Reps',
      'current_level': 'Current Level',
      'level_advanced': 'ADVANCED',
      'level_intermediate': 'INTERMEDIATE',
      'level_rising': 'RISING ATHLETE',
      'beginner': 'BEGINNER',
      'keep_pushing': 'Keep pushing!',
      'discipline_motivation': 'Discipline today, results tomorrow.',

      // Body weight
      'body_weight_check': 'Body Weight Check',
      'body_weight_subtitle': 'Check your BMI based on your height and weight.',
      'height_cm': 'Height (cm)',
      'current_weight_kg': 'Current weight (kg)',
      'check_my_weight': 'Check My Weight',
      'invalid_measurements': 'Please enter a valid height and weight.',
      'your_result': 'Your Result',
      'weight_below_range': 'Below healthy range',
      'weight_healthy_range': 'Healthy weight range',
      'weight_above_range': 'Above healthy range',
      'personal_guidance': 'Personal Guidance',
      'adult_weight_range':
      'This estimate uses adult BMI ranges and is not intended for children or teenagers.',
      'advice_below_range':
      'Consider speaking with a healthcare professional about your weight and nutrition.',
      'advice_healthy_range':
      'Your BMI is within the standard healthy range. Maintain balanced nutrition and regular exercise.',
      'advice_above_range':
      'Consider balanced nutrition and regular physical activity. A healthcare professional can offer personalized guidance.',
      'bmi_disclaimer':
      'BMI is only a screening tool. It does not directly measure body fat or determine your overall health.',

      // Profile page
      'your_journey': 'YOUR JOURNEY',
      'favorites': 'Favorites',
      'status': 'Status',
      'active': 'ACTIVE',
      'ready': 'READY',
      'saved_exercises': 'SAVED EXERCISES',
      'favorites_subtitle': 'Your favorite exercises in one place.',
      'no_favorites': 'No favorites yet',
      'no_favorites_subtitle':
      'Save your favorite exercises and find them here.',
      'remove_favorite': 'Remove favorite',
      'exercise_removed': 'Exercise removed from favorites',
      'app_support': 'APP & SUPPORT',
      'app_support_subtitle': 'Useful links for your CaliCore experience.',
      'privacy_policy': 'Privacy Policy',
      'privacy_subtitle': 'Read how your information is handled.',
      'privacy_not_configured':
      'Add your published Privacy Policy URL in ProfilePage.dart.',
      'open_link_error': 'Could not open the link.',
      'link_not_configured': 'The link is not configured yet.',
      'google_play_title': 'CaliCore on Google Play',
      'google_play_subtitle': 'View the app on Google Play.',
      'refresh_profile': 'Refresh Profile',
      'refresh_subtitle': 'Reload your saved profile and favorites.',
      'athlete_title': 'CALISTHENICS ATHLETE',
      'built_for_progress': 'BUILT FOR PROGRESS.',
      'close': 'Close',
      'cancel': 'Cancel',
      'save': 'Save',
      'retry': 'Try again',
    },

    // =========================================================
    // ARABIC
    // =========================================================
    'ar': {
      'profile': 'ملفي الشخصي',
      'language': 'اللغة',
      'choose_language': 'اختر اللغة',
      'english': 'الإنجليزية',
      'arabic': 'العربية',
      'french': 'الفرنسية',
      'portuguese': 'البرتغالية (البرازيل)',
      'rating': 'قيّم CaliCore',
      'rating_description': 'كيف تقيّم تجربتك؟',
      'submit_rating': 'حفظ التقييم',
      'play_store': 'قيّمنا على Google Play',
      'saved': 'تم حفظ تقييمك.',
      'select_rating': 'اختر التقييم أولاً.',

      // Progress page
      'your_progress': 'تقدمك',
      'progress_subtitle': 'كل تكرار يقرّبك من هدفك.',
      'workout_challenge': 'تحدي التمارين',
      'completed': 'مكتمل',
      'workouts': 'تمارين',
      'workouts_left': 'تمرين متبقٍ',
      'challenge_completed': 'لقد أكملت التحدي!',
      'your_statistics': 'إحصائياتك',
      'total_reps': 'مجموع التكرارات',
      'current_level': 'مستواك الحالي',
      'level_advanced': 'متقدم',
      'level_intermediate': 'متوسط',
      'level_rising': 'رياضي صاعد',
      'beginner': 'مبتدئ',
      'keep_pushing': 'واصل التقدم!',
      'discipline_motivation': 'الانضباط اليوم، والنتائج غدًا.',

      // Body weight
      'body_weight_check': 'فحص وزن الجسم',
      'body_weight_subtitle': 'تحقق من مؤشر كتلة جسمك حسب طولك ووزنك.',
      'height_cm': 'الطول (سم)',
      'current_weight_kg': 'الوزن الحالي (كغ)',
      'check_my_weight': 'تحقق من وزني',
      'invalid_measurements': 'يرجى إدخال طول ووزن صحيحين.',
      'your_result': 'النتيجة',
      'weight_below_range': 'أقل من النطاق الصحي',
      'weight_healthy_range': 'ضمن النطاق الصحي',
      'weight_above_range': 'أعلى من النطاق الصحي',
      'personal_guidance': 'نصائح خاصة بك',
      'adult_weight_range':
      'يعتمد هذا التقدير على نطاقات مؤشر كتلة الجسم للبالغين، ولا يُستخدم للأطفال أو المراهقين.',
      'advice_below_range':
      'يُفضّل استشارة مختص صحي بخصوص الوزن والتغذية.',
      'advice_healthy_range':
      'مؤشر كتلة جسمك ضمن النطاق الصحي المعتاد. حافظ على تغذية متوازنة وممارسة الرياضة بانتظام.',
      'advice_above_range':
      'حاول اتباع تغذية متوازنة وممارسة النشاط البدني بانتظام. يمكن لمختص صحي تقديم نصائح تناسبك.',
      'bmi_disclaimer':
      'مؤشر كتلة الجسم أداة أولية للتقييم فقط، ولا يقيس دهون الجسم مباشرة ولا يحدد صحتك بشكل كامل.',

      // Profile page
      'your_journey': 'رحلتك الرياضية',
      'favorites': 'المفضلة',
      'status': 'الحالة',
      'active': 'نشط',
      'ready': 'مستعد',
      'saved_exercises': 'التمارين المحفوظة',
      'favorites_subtitle': 'جميع تمارينك المفضلة في مكان واحد.',
      'no_favorites': 'لا توجد تمارين مفضلة بعد',
      'no_favorites_subtitle': 'أضف تمارينك المفضلة لتجدها هنا.',
      'remove_favorite': 'إزالة من المفضلة',
      'exercise_removed': 'تمت إزالة التمرين من المفضلة',
      'app_support': 'التطبيق والدعم',
      'app_support_subtitle': 'روابط مفيدة لتجربتك مع CaliCore.',
      'privacy_policy': 'سياسة الخصوصية',
      'privacy_subtitle': 'تعرّف على كيفية التعامل مع معلوماتك.',
      'privacy_not_configured':
      'أضف رابط سياسة الخصوصية المنشور في ProfilePage.dart.',
      'open_link_error': 'تعذّر فتح الرابط.',
      'link_not_configured': 'لم تتم إضافة الرابط بعد.',
      'google_play_title': 'CaliCore على Google Play',
      'google_play_subtitle': 'عرض التطبيق على Google Play.',
      'refresh_profile': 'تحديث الملف الشخصي',
      'refresh_subtitle': 'إعادة تحميل الملف الشخصي والمفضلة.',
      'athlete_title': 'رياضي كاليستينيكس',
      'built_for_progress': 'صُمّم لتحقيق التقدم.',
      'close': 'إغلاق',
      'cancel': 'إلغاء',
      'save': 'حفظ',
      'retry': 'حاول مرة أخرى',
    },

    // =========================================================
    // FRENCH
    // =========================================================
    'fr': {
      'profile': 'MON PROFIL',
      'language': 'Langue',
      'choose_language': 'Choisir votre langue',
      'english': 'Anglais',
      'arabic': 'Arabe',
      'french': 'Français',
      'portuguese': 'Portugais (Brésil)',
      'rating': 'Évaluer CaliCore',
      'rating_description': 'Comment évaluez-vous votre expérience ?',
      'submit_rating': 'Enregistrer la note',
      'play_store': 'Évaluez-nous sur Google Play',
      'saved': 'Votre note a été enregistrée.',
      'select_rating': 'Choisissez d’abord une note.',

      // Progress page
      'your_progress': 'VOTRE PROGRESSION',
      'progress_subtitle':
      'Chaque répétition vous rapproche de votre objectif.',
      'workout_challenge': 'Défi d’entraînement',
      'completed': 'Terminé',
      'workouts': 'entraînements',
      'workouts_left': 'entraînements restants',
      'challenge_completed': 'Défi terminé !',
      'your_statistics': 'Vos statistiques',
      'total_reps': 'Répétitions totales',
      'current_level': 'Niveau actuel',
      'level_advanced': 'AVANCÉ',
      'level_intermediate': 'INTERMÉDIAIRE',
      'level_rising': 'ATHLÈTE EN PROGRESSION',
      'beginner': 'DÉBUTANT',
      'keep_pushing': 'Continuez vos efforts !',
      'discipline_motivation':
      'La discipline aujourd’hui, les résultats demain.',

      // Body weight
      'body_weight_check': 'Contrôle du poids',
      'body_weight_subtitle':
      'Vérifiez votre IMC selon votre taille et votre poids.',
      'height_cm': 'Taille (cm)',
      'current_weight_kg': 'Poids actuel (kg)',
      'check_my_weight': 'Vérifier mon poids',
      'invalid_measurements':
      'Veuillez saisir une taille et un poids valides.',
      'your_result': 'Votre résultat',
      'weight_below_range': 'En dessous de la plage saine',
      'weight_healthy_range': 'Poids dans la plage saine',
      'weight_above_range': 'Au-dessus de la plage saine',
      'personal_guidance': 'Conseils personnalisés',
      'adult_weight_range':
      'Cette estimation utilise les plages d’IMC des adultes et ne convient pas aux enfants ni aux adolescents.',
      'advice_below_range':
      'Envisagez de consulter un professionnel de santé concernant votre poids et votre alimentation.',
      'advice_healthy_range':
      'Votre IMC se situe dans la plage saine habituelle. Continuez à manger équilibré et à faire de l’exercice régulièrement.',
      'advice_above_range':
      'Privilégiez une alimentation équilibrée et une activité physique régulière. Un professionnel de santé peut vous conseiller personnellement.',
      'bmi_disclaimer':
      'L’IMC est uniquement un outil de dépistage. Il ne mesure pas directement la masse grasse et ne détermine pas à lui seul votre état de santé.',

      // Profile page
      'your_journey': 'VOTRE PARCOURS',
      'favorites': 'Favoris',
      'status': 'Statut',
      'active': 'ACTIF',
      'ready': 'PRÊT',
      'saved_exercises': 'EXERCICES ENREGISTRÉS',
      'favorites_subtitle':
      'Tous vos exercices favoris au même endroit.',
      'no_favorites': 'Aucun favori pour le moment',
      'no_favorites_subtitle':
      'Enregistrez vos exercices favoris pour les retrouver ici.',
      'remove_favorite': 'Retirer des favoris',
      'exercise_removed': 'Exercice retiré des favoris',
      'app_support': 'APPLICATION ET ASSISTANCE',
      'app_support_subtitle':
      'Liens utiles pour votre expérience CaliCore.',
      'privacy_policy': 'Politique de confidentialité',
      'privacy_subtitle':
      'Découvrez comment vos informations sont utilisées.',
      'privacy_not_configured':
      'Ajoutez l’URL publiée de votre politique de confidentialité dans ProfilePage.dart.',
      'open_link_error': 'Impossible d’ouvrir le lien.',
      'link_not_configured': 'Le lien n’est pas encore configuré.',
      'google_play_title': 'CaliCore sur Google Play',
      'google_play_subtitle': 'Voir l’application sur Google Play.',
      'refresh_profile': 'Actualiser le profil',
      'refresh_subtitle': 'Recharger votre profil et vos favoris.',
      'athlete_title': 'ATHLÈTE DE CALISTHÉNIE',
      'built_for_progress': 'CONÇU POUR PROGRESSER.',
      'close': 'Fermer',
      'cancel': 'Annuler',
      'save': 'Enregistrer',
      'retry': 'Réessayer',
    },

    // =========================================================
    // PORTUGUESE (BRAZIL)
    // =========================================================
    'pt': {
      'profile': 'MEU PERFIL',
      'language': 'Idioma',
      'choose_language': 'Escolha seu idioma',
      'english': 'Inglês',
      'arabic': 'Árabe',
      'french': 'Francês',
      'portuguese': 'Português (Brasil)',
      'rating': 'Avalie o CaliCore',
      'rating_description': 'Como você avalia sua experiência?',
      'submit_rating': 'Salvar avaliação',
      'play_store': 'Avalie-nos no Google Play',
      'saved': 'Sua avaliação foi salva.',
      'select_rating': 'Escolha uma avaliação primeiro.',

      // Progress page
      'your_progress': 'SEU PROGRESSO',
      'progress_subtitle':
      'Cada repetição aproxima você do seu objetivo.',
      'workout_challenge': 'Desafio de treino',
      'completed': 'Concluído',
      'workouts': 'treinos',
      'workouts_left': 'treinos restantes',
      'challenge_completed': 'Desafio concluído!',
      'your_statistics': 'Suas estatísticas',
      'total_reps': 'Repetições totais',
      'current_level': 'Nível atual',
      'level_advanced': 'AVANÇADO',
      'level_intermediate': 'INTERMEDIÁRIO',
      'level_rising': 'ATLETA EM EVOLUÇÃO',
      'beginner': 'INICIANTE',
      'keep_pushing': 'Continue se esforçando!',
      'discipline_motivation':
      'Disciplina hoje, resultados amanhã.',

      // Body weight
      'body_weight_check': 'Verificação do peso corporal',
      'body_weight_subtitle':
      'Confira seu IMC com base na sua altura e peso.',
      'height_cm': 'Altura (cm)',
      'current_weight_kg': 'Peso atual (kg)',
      'check_my_weight': 'Verificar meu peso',
      'invalid_measurements':
      'Insira uma altura e um peso válidos.',
      'your_result': 'Seu resultado',
      'weight_below_range': 'Abaixo da faixa saudável',
      'weight_healthy_range': 'Dentro da faixa saudável',
      'weight_above_range': 'Acima da faixa saudável',
      'personal_guidance': 'Orientações personalizadas',
      'adult_weight_range':
      'Esta estimativa usa as faixas de IMC para adultos e não se destina a crianças ou adolescentes.',
      'advice_below_range':
      'Considere conversar com um profissional de saúde sobre seu peso e sua alimentação.',
      'advice_healthy_range':
      'Seu IMC está dentro da faixa saudável habitual. Mantenha uma alimentação equilibrada e pratique exercícios regularmente.',
      'advice_above_range':
      'Priorize uma alimentação equilibrada e atividade física regular. Um profissional de saúde pode oferecer orientações personalizadas.',
      'bmi_disclaimer':
      'O IMC é apenas uma ferramenta de triagem. Ele não mede diretamente a gordura corporal nem determina sua saúde geral.',

      // Profile page
      'your_journey': 'SUA JORNADA',
      'favorites': 'Favoritos',
      'status': 'Status',
      'active': 'ATIVO',
      'ready': 'PRONTO',
      'saved_exercises': 'EXERCÍCIOS SALVOS',
      'favorites_subtitle':
      'Seus exercícios favoritos em um só lugar.',
      'no_favorites': 'Nenhum favorito ainda',
      'no_favorites_subtitle':
      'Salve seus exercícios favoritos para encontrá-los aqui.',
      'remove_favorite': 'Remover dos favoritos',
      'exercise_removed': 'Exercício removido dos favoritos',
      'app_support': 'APLICATIVO E SUPORTE',
      'app_support_subtitle':
      'Links úteis para sua experiência com CaliCore.',
      'privacy_policy': 'Política de Privacidade',
      'privacy_subtitle':
      'Saiba como suas informações são utilizadas.',
      'privacy_not_configured':
      'Adicione a URL publicada da Política de Privacidade em ProfilePage.dart.',
      'open_link_error': 'Não foi possível abrir o link.',
      'link_not_configured': 'O link ainda não foi configurado.',
      'google_play_title': 'CaliCore no Google Play',
      'google_play_subtitle': 'Ver o aplicativo no Google Play.',
      'refresh_profile': 'Atualizar perfil',
      'refresh_subtitle': 'Recarregar seu perfil e seus favoritos.',
      'athlete_title': 'ATLETA DE CALISTENIA',
      'built_for_progress': 'FEITO PARA EVOLUIR.',
      'close': 'Fechar',
      'cancel': 'Cancelar',
      'save': 'Salvar',
      'retry': 'Tentar novamente',
    },
  };

  String text(String key) {
    final code = locale.languageCode;

    return _translations[code]?[key] ??
        _translations['en']?[key] ??
        key;
  }
}
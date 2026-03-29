// core
export 'core/theme/app_theme.dart';

// providers
export 'providers/auth_provider.dart';
export 'providers/dashboard_provider.dart';
export 'providers/task_provider.dart';
export 'providers/pomodoro_provider.dart';

// models
export 'data/models/user_model.dart';
export 'data/models/dashboard_model.dart';
export 'data/models/task_model.dart';
export 'data/models/pomodoro_model.dart';

// repositories
export 'data/repositories/dashboard_repository.dart';
export 'data/repositories/task_repository.dart';
export 'data/repositories/pomodoro_repository.dart';

// shared widgets
export 'shared/snackbars/app_snackbar.dart';
export 'shared/widgets/custom_button.dart';
export 'shared/widgets/custom_textfield.dart';
export 'shared/widgets/loading_indicator.dart';

// pages
export 'features/auth/pages/login_page.dart';
export 'features/auth/pages/register_page.dart';
export 'features/auth/pages/auth_wrapper.dart';
export 'features/auth/pages/onboarding_page.dart';

export 'features/auth/widgets/google_singnin_button.dart';

export 'features/dashboard/pages/dashboard_page.dart';
export 'features/dashboard/pages/dashboard_detail_page.dart';

// dashboard widgets
export 'features/dashboard/widgets/add_dashboard_dialog.dart';
export 'features/dashboard/widgets/dashboard_card.dart';

//pomodro
export 'features/pomodoro/pages/pomodoro_page.dart';
export 'features/pomodoro/widgets/timer_widget.dart';

//tasks
export 'features/tasks/widgets/add_task_dialog.dart';
export 'features/tasks/widgets/task_tile.dart';

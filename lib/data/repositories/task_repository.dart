class TaskRepository {

  final FirestoreService firestoreService;

  TaskRepository(this.firestoreService);

  Future<void> addTask(String dashboardId, String title) {
    return firestoreService.addTask(
      dashboardId: dashboardId,
      title: title,
    );
  }

}
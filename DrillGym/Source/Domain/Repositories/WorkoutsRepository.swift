import Foundation

protocol WorkoutRepository{
    func getWorkouts() -> [WorkoutModel]
    func getWorkout(by id: UUID) -> WorkoutModel
    func createWorkout(_ workout: WorkoutModel)
    func deletWorkout(by: UUID)
    func updateWorkout(_ workout: WorkoutModel)
}

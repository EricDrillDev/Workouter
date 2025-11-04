import Foundation

protocol WorkoutsRepository{
    func getWorkouts() throws -> [WorkoutModel]
    func getWorkoutBy(id: UUID) throws -> WorkoutModel
    func createWorkout(_ workout: WorkoutModel) throws
    func updateWorkout(_ workout: WorkoutModel) throws
    func deleteWorkoutBy(id: UUID) throws
}

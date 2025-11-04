import Foundation

final class WorkoutRepositoryImpl: WorkoutsRepository {
    private let localDataSource: WorkoutsDataSource
    
    init(localDataSource: WorkoutsDataSource) {
        self.localDataSource = localDataSource
    }
    
    func getWorkouts() throws -> [WorkoutModel] {
        let workouts = try localDataSource.getAll()
        return workouts.map { WorkoutMapper.toModel($0) }
    }
    
    func getWorkoutBy(id: UUID) throws -> WorkoutModel {
        let workout = try localDataSource.getBy(id: id)
        return WorkoutMapper.toModel(workout)
    }
    
    func createWorkout(_ workout: WorkoutModel) throws {
        try localDataSource.create(workout)
    }
    
    func updateWorkout(_ workout: WorkoutModel) throws {
        try localDataSource.update(workout)
    }
    
    func deleteWorkoutBy(id: UUID) throws {
        try localDataSource.deleteBy(id: id)
    }
}

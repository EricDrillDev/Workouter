import Foundation

protocol WorkoutsCreateUseCase{
    func create(_ workout: WorkoutModel) throws
}

protocol WorkoutsGetUseCase{
    func getAll() throws -> [WorkoutModel]
    func getBy(id: UUID) throws -> WorkoutModel
}

protocol WorkoutsUpdateUseCase{
    func update(_ workout: WorkoutModel) throws
}

protocol WorkoutsDeleteUseCase{
    func deleteBy(id: UUID) throws
}

final class WorkoutsUseCase: WorkoutsCreateUseCase, WorkoutsGetUseCase, WorkoutsUpdateUseCase, WorkoutsDeleteUseCase {
    private let repository: WorkoutsRepository
    
    init(repository: WorkoutsRepository) {
        self.repository = repository
    }
    
    func getBy(id: UUID) throws -> WorkoutModel {
        try repository.getWorkoutBy(id: id)
    }
    
    func getAll() throws -> [WorkoutModel] {
        try repository.getWorkouts()
    }
    
    func create(_ workout: WorkoutModel) throws {
        try repository.createWorkout(workout)
    }
    
    func update(_ workout: WorkoutModel) throws {
        try repository.updateWorkout(workout)
    }
    
    func deleteBy(id: UUID) throws {
        try repository.deleteWorkoutBy(id: id)
    }
}



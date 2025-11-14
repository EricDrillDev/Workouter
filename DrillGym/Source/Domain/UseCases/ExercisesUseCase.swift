import Foundation

protocol ExercisesGetUseCase{
    func getAll() throws -> [ExerciseModel]
}

protocol ExercisesCreateUseCase{
    func create(_ exercise: ExerciseModel) throws
}

protocol ExercisesUpdateUseCase{
    func update(_ exercise: ExerciseModel) throws
}

protocol ExercisesDeleteUseCase{
    func deleteBy(id: UUID) throws
}

final class ExercisesUseCase:ExercisesGetUseCase, ExercisesCreateUseCase, ExercisesUpdateUseCase, ExercisesDeleteUseCase{
    private let repository: ExercisesRepository
    
    init(repository: ExercisesRepository) {
        self.repository = repository
    }
    
    func getAll() throws -> [ExerciseModel] {
        try repository.getAll()
    }
    
    func create(_ exercise: ExerciseModel) throws {
        try repository.create(exercise)
    }
    
    func update(_ exercise: ExerciseModel) throws {
        try repository.update(exercise)
    }
    
    func deleteBy(id: UUID) throws {
        try repository.deleteBy(id: id)
    }
}

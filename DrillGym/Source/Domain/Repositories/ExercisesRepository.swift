import Foundation

protocol ExercisesRepository {
    func getAll() throws -> [ExerciseModel]
    func getBy(id: UUID) throws -> ExerciseModel
    func create(_ exercise: ExerciseModel) throws
    func update(_ exercise: ExerciseModel) throws
    func deleteBy(id: UUID) throws
}

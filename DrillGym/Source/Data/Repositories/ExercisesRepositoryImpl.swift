import Foundation

final class ExercisesRepositoryImpl: ExercisesRepository {
    private let localeDataSource: ExercisesDataSource
    
    init(_ locateDataSource: ExercisesDataSource) {
        self.localeDataSource = locateDataSource
    }
    
    func getAll() throws -> [ExerciseModel] {
        let exercises = try localeDataSource.getAll()
        return exercises.map { ExerciseMapper.toModel($0) }
    }
    
    func getBy(id: UUID) throws -> ExerciseModel {
        let exercise = try localeDataSource.getBy(id: id)
        return ExerciseMapper.toModel(exercise)
    }
    
    func create(_ exercise: ExerciseModel) throws {
        try localeDataSource.create(exercise)
    }
    
    func update(_ exercise: ExerciseModel) throws {
        try localeDataSource.update(exercise)
    }
    
    func deleteBy(id: UUID) throws {
        try localeDataSource.deleteBy(id: id)
    }
}

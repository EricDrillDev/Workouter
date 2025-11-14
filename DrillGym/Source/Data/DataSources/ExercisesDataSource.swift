import Foundation
import CoreData

protocol ExercisesDataSource{
    func create(_ model: ExerciseModel) throws
    func getBy(id: UUID) throws -> Exercise
    func getAll() throws -> [Exercise]
    func update(_ exercise: ExerciseModel) throws
    func deleteBy(id: UUID) throws
}

final class ExerciseLocalStorage: ExercisesDataSource{
    private let dbContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.dbContext = context
    }
    
    func create(_ model: ExerciseModel) throws {
        let _ = ExerciseMapper.toCoreEntity(model, context: dbContext)
        try dbContext.save()
    }
    
    func getBy(id: UUID) throws -> Exercise {
        let request = Exercise.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.predicate = predicate
        request.fetchLimit = 1
        let result = try dbContext.fetch(request)
        return result[0]
    }
    
    func getAll() throws -> [Exercise] {
        let request = Exercise.fetchRequest()
        return try dbContext.fetch(request)
    }
    
    func update(_ exercise: ExerciseModel) throws {
        let request = Exercise.fetchRequest()
        let predicat = NSPredicate(format: "id == %@", exercise.id as CVarArg )
        request.fetchLimit = 1
        request.predicate = predicat
        
        let entity = try dbContext.fetch(request).first
        entity?.name = exercise.name
        entity?.repeats = Int16(exercise.repeats)
        entity?.weight = Int16(exercise.weight)
        try dbContext.save()
    }
    
    func deleteBy(id: UUID) throws {
        let request = Exercise.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.predicate = predicate
        
        let entity = try dbContext.fetch(request).first
        dbContext.delete(entity!)
        try dbContext.save()
    }
}

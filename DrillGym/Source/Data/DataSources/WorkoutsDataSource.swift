import Foundation
import CoreData

protocol WorkoutsDataSource {
    func getAll() throws -> [Workout]
    func getBy(id: UUID) throws -> Workout
    func create(_ workout: WorkoutModel) throws
    func update(_ workout: WorkoutModel) throws
    func deleteBy(id: UUID) throws
}

final class WorkoutsLocalStorage: WorkoutsDataSource{
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func getAll() throws -> [Workout] {
        let request = Workout.fetchRequest()
        request.relationshipKeyPathsForPrefetching = ["exercises"]
        return try context.fetch(request)
    }
    
    func getBy(id: UUID) throws -> Workout {
        let request = Workout.fetchRequest()
        request.relationshipKeyPathsForPrefetching = ["exercises"]
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        request.predicate = predicate
        request.fetchLimit = 1
        return try context.fetch(request)[0]
    }
    
    func create(_ workout: WorkoutModel) throws {
        let _ = WorkoutMapper.toCoreEntity(workout, context: context)
        try context.save()
    }
    
    func update(_ workout: WorkoutModel) throws {
        let request = Workout.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", workout.id as CVarArg)
        request.predicate = predicate
        request.fetchLimit = 1
        
        let entity = try context.fetch(request)[0]
        entity.name = workout.name
        entity.desc = workout.description
        try context.save()
    }
    
    func deleteBy(id: UUID) throws {
        let request = Workout.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.predicate = predicate
        request.fetchLimit = 1
        
        let entity = try context.fetch(request)[0]
        context.delete(entity)
        try context.save()
    }
}

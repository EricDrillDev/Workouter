import CoreData

final class ExerciseMapper{
    private init() {}
    
    static func toCoreEntity(_ exercise: ExerciseModel, context: NSManagedObjectContext) -> Exercise {
        let entitie = Exercise(context: context)
        entitie.id = exercise.id
        entitie.name = exercise.name
        entitie.weight = Int16(exercise.weight)
        entitie.repeats = Int16(exercise.repeats) 
        return entitie
    }
    
    static func toModel(_ exercise: Exercise) -> ExerciseModel {
        ExerciseModel(
            id: exercise.id!,
            name: exercise.name!,
            repeats: Int(exercise.repeats),
            weight: Int(exercise.weight)
        )
    }
}

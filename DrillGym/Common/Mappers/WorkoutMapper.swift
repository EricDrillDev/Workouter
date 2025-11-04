import CoreData

final class WorkoutMapper{
    private init() {}
    
    static func toCoreEntity(_ workout: WorkoutModel, context: NSManagedObjectContext) -> Workout {
        let entitie = Workout(context: context)
        entitie.id = workout.id
        entitie.name = workout.name
        entitie.desc = workout.description
        entitie.date = workout.data
        entitie.time = Int16(workout.duration.components.seconds)
        return entitie
    }
    
    static func toModel(_ workout: Workout) -> WorkoutModel {
        let set = workout.exercises as? Set<Exercise> ?? []
        let exercises = set.sorted { $0.name ?? "" < $1.name ?? "" }
        
        return WorkoutModel(
            id: workout.id!,
            name: workout.name!,
            description: workout.desc!,
            data: workout.date!,
            duration: .seconds(workout.time),
            exercises: exercises.map { exercise in
                ExerciseMapper.toModel(exercise)
            }
        )
    }
}

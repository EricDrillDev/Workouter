public import Foundation
public import CoreData

public typealias WorkoutCoreDataClassSet = NSSet

@objc(Workout)
public class Workout: NSManagedObject {

}

extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var desc: String?
    @NSManaged public var time: Int16
    @NSManaged public var date: Date?
    @NSManaged public var exercises: NSSet?

}

// MARK: Generated accessors for exercise
extension Workout {

    @objc(addExerciseObject:)
    @NSManaged public func addToExercise(_ value: Exercise)

    @objc(removeExerciseObject:)
    @NSManaged public func removeFromExercise(_ value: Exercise)

    @objc(addExercise:)
    @NSManaged public func addToExercise(_ values: NSSet)

    @objc(removeExercise:)
    @NSManaged public func removeFromExercise(_ values: NSSet)

}

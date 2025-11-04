public import Foundation
public import CoreData

public typealias ExerciseCoreDataClassSet = NSSet

@objc(Exercise)
public class Exercise: NSManagedObject {

}

extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var repeats: Int16
    @NSManaged public var weight: Int16
    @NSManaged public var workout: Workout?

}


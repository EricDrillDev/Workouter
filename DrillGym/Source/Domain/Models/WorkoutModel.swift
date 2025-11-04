import Foundation

struct WorkoutModel: Identifiable, Hashable, Equatable {
    let id: UUID
    let name: String
    let description: String
    let data: Date
    let duration: Duration
    let exercises: [ExerciseModel]
}

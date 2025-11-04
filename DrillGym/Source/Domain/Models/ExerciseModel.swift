import Foundation

struct ExerciseModel: Identifiable, Hashable, Equatable{
    let id: UUID
    let name: String
    let repeats: Int
    let weight: Int
}

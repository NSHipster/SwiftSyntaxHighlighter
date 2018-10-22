import SwiftSyntax

extension Trivia {
    var containsBackticks: Bool {
        for case .backticks(_) in self {
            return true
        }
        
        return false
    }
}

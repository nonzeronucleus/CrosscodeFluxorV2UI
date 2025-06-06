import Foundation


struct SimpleError: LocalizedError {
    let message: String
    
    init(_ message:String) {
        self.message = message
    }
    
    var errorDescription: String? { message }
}

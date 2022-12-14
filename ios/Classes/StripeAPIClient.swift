import Foundation
import StripeTerminal

class StripeAPIClient: ConnectionTokenProvider {
    let methodChannel: FlutterMethodChannel
    
    init(methodChannel: FlutterMethodChannel){
        self.methodChannel = methodChannel
    }
    
    func fetchConnectionToken(_ completion: @escaping ConnectionTokenCompletionBlock) {
        methodChannel.invokeMethod("requestConnectionToken", arguments: nil) { secret in
                        if let token = secret as? String {
                            completion(token, nil)
                        } else {
                            completion(nil, StripeTerminalError.unableToFetchToken)
                        }

                        /* do{
                             let token =  secret as? String
                            completion(token, nil)
                        } catch {
                            completion(nil, StripeTerminalError.unableToFetchToken)
                        } */
        }
    }
}

enum StripeTerminalError: Error {
    // Throw when an invalid password is entered
    case unableToFetchToken

    // Throw in all other cases
    case unexpected(code: Int)
}

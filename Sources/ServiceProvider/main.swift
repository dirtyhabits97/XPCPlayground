import Foundation

// source: https://rderik.com/blog/xpc-services-on-macos-apps-using-swift/

// 1. create listener
let listener = NSXPCListener.service()
// 2. set its delegate object
// the delegate is in charge of
// accepting and setting up new incoming connectoins
let delegate = ServiceDelegate()
listener.delegate = delegate
// 3. start listening to connections
listener.resume()
RunLoop.main.run()

import Foundation

class ServiceDelegate: NSObject, NSXPCListenerDelegate {

  func listener(
    _ listener: NSXPCListener, 
    shouldAcceptNewConnection newConnection: NSXPCConnection
  ) -> Bool {
    // the interface to use
    newConnection.exportedInterface = NSXPCInterface(with: ServiceProviderXPCProtocol.self)

    let exportedObject = ServiceProviderXPC()
    // the "data" to share / export
    newConnection.exportedObject = exportedObject
    newConnection.resume()
    return true
  }

}

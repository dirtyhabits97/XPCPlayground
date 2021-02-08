import Foundation

/**
  This protocol defines the interface for our Service.

  It defines what functions we provide and their signatures.
 */
@objc(ServiceProviderXPCProtocol)
protocol ServiceProviderXPCProtocol {

  func getPublicIP(withReply reply: @escaping (String) -> Void)

}

import Foundation

@objc
class ServiceProviderXPC: NSObject, ServiceProviderXPCProtocol {
    
    func getPublicIP(withReply reply: @escaping (String) -> Void) {
        let pmset = Process()
        let pipe = Pipe()
        
        if #available(OSX 13, *) {
            pmset.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        } else {
            pmset.launchPath = "/usr/bin/env"
        }
        
        // We are going to 'dig' to obtain our public IP using
        // Cisco's opendns.com domain:
        // dig +short myip.opendns.com @resolver1.opendns.com
        pmset.arguments = ["dig", "+short", "myip.opendns.com", "@resolver1.opendns.com"]
        pmset.standardOutput = pipe
        
        if #available(OSX 13, *) {
            do {
                try pmset.run()
            } catch {
                reply("")
            }
        } else {
            pmset.launch()
        }
        
        pmset.waitUntilExit()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        if let output = String(data: data, encoding: .utf8) {
            reply(output.trimmingCharacters(in: .whitespacesAndNewlines))
        }
    }
    
}

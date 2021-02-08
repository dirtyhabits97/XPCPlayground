import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    
    var statusBarItem: NSStatusItem!
    var counter: Int = 0
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let statusBar = NSStatusBar.system
        statusBarItem = statusBar.statusItem(
            withLength: NSStatusItem.variableLength
        )
        let statusBarMenu = NSMenu(title: "Counter Bar Menu")
        statusBarItem.menu = statusBarMenu
        
        statusBarMenu.addItem(
            withTitle: "Increase",
            action: #selector(AppDelegate.increaseCount),
            keyEquivalent: ""
        )
        
        statusBarMenu.addItem(
            withTitle: "Decrease",
            action: #selector(AppDelegate.decreaseCount),
            keyEquivalent: ""
        )
        
        statusBarMenu.addItem(
            withTitle: "Get public ip",
            action: #selector(xpcCall),
            keyEquivalent: ""
        )
        
        statusBarMenu.addItem(
            withTitle: "Quit",
            action: #selector(AppDelegate.quit),
            keyEquivalent: ""
        )
    }
    
    @objc func showCounter() {
        statusBarItem.button?.title = "🌰 \(counter)"
    }
    
    @objc func increaseCount() {
        counter += 1
        showCounter()
    }
    
    @objc func decreaseCount() {
        counter -= 1
        showCounter()
    }
    
    @objc func quit() {
        NSApplication.shared.terminate(self)
    }
    
    @objc
    func xpcCall() {
        // 1. create a connection to the service
        let connection = NSXPCConnection(
            serviceName: "com.gerh.ServiceProviderXPC"
        )
        // 2. set the remote object interface
        connection.remoteObjectInterface = NSXPCInterface(
            with: ServiceProviderXPCProtocol.self
        )
        connection.resume()
        
        // 3. get an instance of the object that implements the interface
        guard let service = connection.remoteObjectProxyWithErrorHandler { (error) in
            print("Received error:", error)
        } as? ServiceProviderXPCProtocol else {
            return
        }
        // 4. make use of your service
        service.getPublicIP { (str) in
            DispatchQueue.main.async { [weak self] in
                self?.statusBarItem.button?.title = str
            }
        }
    }
    
}

@objc(ServiceProviderXPCProtocol)
protocol ServiceProviderXPCProtocol {
    func getPublicIP(withReply reply: @escaping (String) -> Void)
}

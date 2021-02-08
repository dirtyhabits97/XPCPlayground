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

}

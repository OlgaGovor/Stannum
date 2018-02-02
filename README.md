# Stannum
UI test helper in Swift

To use library just install it using cocoapods

Useful extensions:
extension String {
  random(strLength: Int) -> String - return random string with length strLenght, string contains small and capital letters of Latin Alphabet
  toBool() -> Bool - convert String to Bool, works with values(True/False, true/false, yes/no, 1/0), in case of error returns nil
}

extension XCTestCase {
  sctivateAppByBundleId(bundleId: String) - sctivate app by bundle identificator
}

extension XCUIApplication {
  goToBackground() - application goes to background, implemented by clicking Home button
  close() - hard close application
}

extension XCUIElement {
  clearAndEnterText(text: String) - clear input and enter text
  waitForHittable(timeout: TimeInterval = 10) -> Bool - wait till element isHittable=true for timeout
  forceTap() - force tap if for some reason element never becomes hittable
}


@_spi(Internals) import ComposableArchitecture
import XCTest

class BaseTCATestCase: XCTestCase {
  override func invokeTest() {
    withMainSerialExecutor {
      super.invokeTest()
    }
  }

  override func tearDown() {
    super.tearDown()
    XCTAssertEqual(_cancellationCancellables.count, 0, "\(self)")
    _cancellationCancellables.removeAll()
  }
}

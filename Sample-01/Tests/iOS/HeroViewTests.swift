import XCTest
import ViewInspector
@testable import SwiftRedirect

class HeroViewTests: XCTestCase {
    private let sut = HeroView()

    func testHasLogo() throws {
        let logo = try self.sut.inspect().image(0)
        XCTAssertEqual(try logo.actualImage().name(), "Auth0")
        XCTAssertEqual(try logo.aspectRatio().contentMode, .fit)
        XCTAssertEqual(try logo.fixedWidth(), 120)
        XCTAssertEqual(try logo.fixedHeight(), 120)
    }

    func testLogoUsesFixedSize() throws {
        let logo = try self.sut.inspect().image(0)
        XCTAssertEqual(try logo.fixedWidth(), 120)
        XCTAssertEqual(try logo.fixedHeight(), 120)
        XCTAssertEqual(try logo.aspectRatio().contentMode, .fit)
    }

    func testHasText() throws {
        let textViews = try self.sut.inspect().vStack(1).findAll(ViewType.Text.self)
        XCTAssertEqual(textViews.count, 3)
        XCTAssertEqual(try textViews[0].string(), "Swift")
        XCTAssertEqual(try textViews[1].string(), "Redirect")
        XCTAssertEqual(try textViews[2].string(), "App")
    }

    func testTextUsesCustomFont() throws {        
        XCTAssertEqual(try self.sut.inspect().vStack(1).find(text: "Swift").attributes().font().size(), 80)
        XCTAssertEqual(try self.sut.inspect().vStack(1).find(text: "Redirect").attributes().font().size(), 80)
        XCTAssertEqual(try self.sut.inspect().vStack(1).find(text: "App").attributes().font().size(), 50)
    }

    func testTextUsesFlexibleSize() throws {
        let vStack = try self.sut.inspect().vStack(1)
        XCTAssertEqual(try vStack.flexFrame().maxWidth, .infinity)
        XCTAssertEqual(try vStack.flexFrame().maxHeight, .infinity)
    }
}

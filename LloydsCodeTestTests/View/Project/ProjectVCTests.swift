//
//  ProjectVCTests.swift
//  LloydsCodeTestTests
//
//  Created by Darshan Gajera on 04/07/2022.
//

import XCTest
@testable import LloydsCodeTest

class ProjectVCTests: XCTestCase {

    var sut: ProjectVC!
    override func setUpWithError() throws {
        try super.setUpWithError()
        let projectVC: ProjectVC = UIStoryboard.main.instantiateViewController()
        sut = projectVC
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testViewDidLoad() throws {
        sut.viewDidLoad()
        XCTAssertEqual(AppString.Project.uppercased(), sut.title)
    }
    
    func testViewDidAppear() throws {
        sut.viewDidAppear(true)
        sleep(5)
        XCTAssertNotNil(sut.viewModel.projectCount)
    }
  
    func testSetTitleValuePass() throws {
        let title = "projects"
        sut.setTitle(title)
        XCTAssertEqual(sut.title, title)
    }
    
    func testOpenURL() throws {
        let url = "https://google.com"
        XCTAssertNotNil(sut.open(url:url))
    }
    
}

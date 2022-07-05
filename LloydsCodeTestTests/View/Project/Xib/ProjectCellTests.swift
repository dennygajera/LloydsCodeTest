//
//  ProjectCellTests.swift
//  LloydsCodeTestTests
//
//  Created by Darshan Gajera on 04/07/2022.
//

import XCTest
@testable import LloydsCodeTest

class ProjectCellTests: XCTestCase {

    var sut: ProjectCell!
    override func setUpWithError() throws {
        try super.setUpWithError()
        let bundle = Bundle(for: type(of: self))
        guard let cell = bundle.loadNibNamed("\(ProjectCell.self)", owner: nil)?.first as? ProjectCell else {
            XCTFail("Unable to create cell")
            return
        }
        sut = cell
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testSetData() throws {
        let mockProject = MockProjectData().data
        let projectViewModel = ProjectDataItemViewModel(mockProject)
        sut.setData(projectViewModel)
        
        XCTAssertEqual(projectViewModel.name, mockProject.name)
        XCTAssertEqual(projectViewModel.organization, mockProject.organization)
    }
}

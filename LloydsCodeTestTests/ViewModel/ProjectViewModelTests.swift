//
//  ProjectViewModelTests.swift
//  LloydsCodeTestTests
//
//  Created by Darshan Gajera on 04/07/2022.
//

import XCTest
@testable import LloydsCodeTest

class ProjectViewModelTests: XCTestCase {
    var sut: ProjectViewModel!
    var mockRequestManager: MockServiceHandlerManager!
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ProjectViewModel()
        if let projectData = MockProjectData().getProjectsDataFromFile() {
            sut.objTempProjectList = projectData
        }
        mockRequestManager = MockServiceHandlerManager()
    }

    override func tearDownWithError() throws {
        sut = nil
        mockRequestManager = nil
        try super.tearDownWithError()
    }
    
    func testFilterDataSeachNameFromDataSuccess() {
        sut.filterData(strSerchText: "master") { isSuccess in
            XCTAssertTrue(isSuccess)
        }
    }
    
    func testFilterDataSeachNameFromDataNotFound() {
        sut.filterData(strSerchText: "NotFoundString") { isSuccess in
            XCTAssertFalse(isSuccess)
        }
    }
    
    func testApiFetchProjects() {
        mockRequestManager.responseType = .success
        mockRequestManager.getWebService(wsMethod: API.code.url) {data in
            XCTAssertTrue(data != nil)
        }
    }
}

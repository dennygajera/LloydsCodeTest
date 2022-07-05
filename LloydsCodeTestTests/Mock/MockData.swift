//
//  MockData.swift
//  LloydsCodeTestTests
//
//  Created by Darshan Gajera on 04/07/2022.
//

import Foundation
@testable import LloydsCodeTest
import XCTest

class MockProjectData {
    let data = Project(organization: "mock ", name: "test", description: "test", date: DateTime(created: "2010-10-20", lastModified: "2010-10-21", metadataLastUpdated: "2010-10-20"), repositoryURL: "url")
    
    func getProjectsDataFromFile() -> [Project]? {
        let jsonData = dataFromJSON(withName: "Project")!
        do {
            let codeJson: CodeJSON = try JSONDecoder().getType(from: jsonData)
            return codeJson.releases
        } catch {
            return nil
        }
    }
}

func dataFromJSON(withName name: String) -> Data? {
    guard let fileURL = Bundle(for: LloydsCodeTestTests.self).url(forResource: name, withExtension: "json") else {
        return nil
    }
    return try? Data(contentsOf: fileURL)
}

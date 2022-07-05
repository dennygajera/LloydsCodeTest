//
//  Project.swift
//  LloydsCodeTest
//
//  Created by Darshan Gajera on 04/07/2022.
//

import Foundation

// MARK: - Model
struct CodeJSON: Codable {
    let agency: String
    let version: String
    let releases: [Project]
}

struct Project: Codable {
    let organization: String?
    let name: String
    let description: String
    let date: DateTime?
    let repositoryURL: String
}

struct DateTime: Codable {
    let created: String
    let lastModified: String
    let metadataLastUpdated: String
}

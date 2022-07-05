//
//  ProjectViewModel.swift
//  LloydsCodeTest
//
//  Created by Darshan Gajera on 04/07/2022.
//

import Foundation

class ProjectViewModel {
    private var objProjectList = [Project]()
    var objTempProjectList = [Project]()

    var projectCount: Int {
        return objProjectList.count
    }
    
    /// contest list fetch and save data into the variable
    func apiFetchProjects(completion :@escaping (_ isSuccess : Bool?) -> Void) {
        LoadingView.display(true)
        WebServiceHandler.shared.getWebService(wsMethod: API.code.url) { result in
            
            switch result {
            case .success(let data):
                do {
                    let root: CodeJSON = try JSONDecoder().getType(from: data)
                    self.objProjectList = root.releases
                    self.objTempProjectList = root.releases
                    LoadingView.display(false)
                    completion(true)
                } catch {
                    print("Error while converting data into model", error.localizedDescription)
                    LoadingView.display(false)
                    completion(false)
                }
            case .failure(let apiError):
                print(apiError.localizedDescription)
            }
        }
    }
    
    func filterData(strSerchText: String, completion: @escaping (_ isSuccess: Bool)->Void) {
        objProjectList = strSerchText.count == 0 ? objTempProjectList :  objTempProjectList.filter { singleContest in
            singleContest.name.lowercased().contains(strSerchText.lowercased())
        }
        completion(objProjectList.count > 0 ? true : false)
    }
    
    func cellViewModel(at indexPath: IndexPath) -> ProjectDataItem {
        return ProjectDataItemViewModel(objProjectList[indexPath.row])
    }
}

protocol ProjectDataItem {
    
    init(_ project: Project)
    
    var name: String { get }
    var organization: String { get }
    var date: String { get }
    var repositoryURL: String { get }
    
    var nameAccessibilityLabel: String { get }
    var organizationAccessibilityLabel: String { get }
    var dateAccessibilityLabel: String { get }
}

struct ProjectDataItemViewModel: ProjectDataItem {
    
    private let project: Project
    let dateFormatter = DateFormatter()
    let dateFormatterOutput = DateFormatter()
    
    init(_ project: Project) {
        self.project = project
    }
    
    var name: String {
        return project.name
    }
    
    var organization: String {
        return project.organization ?? ""
    }
    
    var date: String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatterOutput.dateFormat = "dd-MM-yyyy"
        guard let date = dateFormatter.date(from: project.date?.created ?? "") else {
            return "N/A"
        }
        return dateFormatterOutput.string(from: date)
    }
    
    var repositoryURL: String {
        return project.repositoryURL
    }
    
    var nameAccessibilityLabel: String {
        return name
    }
    
    var organizationAccessibilityLabel: String {
        return organization
    }
    
    var dateAccessibilityLabel: String {
        return date
    }
    
}

extension JSONDecoder {
    func getType<T : Decodable>(from jsonData: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: jsonData)
    }
}

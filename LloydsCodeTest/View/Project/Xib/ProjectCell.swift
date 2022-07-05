//
//  Project.swift
//  LloydsCodeTest
//
//  Created by Darshan Gajera on 04/07/2022.
//

import Foundation
import UIKit

class ProjectCell: UITableViewCell {
    // MARK: Outlets
    @IBOutlet weak private var lblName: UILabel!
    @IBOutlet weak private var lblOrganization: UILabel!
    @IBOutlet weak private var lblDate: UILabel!
    static let reuseidentifier = "ProjectCell"
    
    /// set contest data
    func setData(_ viewModel: ProjectDataItem) {
        lblName.text = viewModel.name
        lblOrganization.text = viewModel.organization
        lblDate.text = viewModel.date
        applyAccessibility(viewModel)
        selectionStyle = .none
    }
}

extension ProjectCell {
    func applyAccessibility(_ viewModel: ProjectDataItem) {
      lblName.accessibilityLabel = viewModel.nameAccessibilityLabel
        lblOrganization.accessibilityLabel = viewModel.organizationAccessibilityLabel
        lblDate.accessibilityLabel = viewModel.dateAccessibilityLabel
  }
}

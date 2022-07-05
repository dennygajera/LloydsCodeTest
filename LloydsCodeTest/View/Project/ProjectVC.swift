//
//  ProjectVC.swift
//  LloydsCodeTest
//
//  Created by Darshan Gajera on 04/07/2022.
//

import UIKit

class ProjectVC: UIViewController {

    //MARK: Outlet and Variable
    @IBOutlet weak private var tblView: UITableView!
    @IBOutlet weak private var txtSearch: UITextField!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                                    #selector(refresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.gray
        return refreshControl
    }()
    
    var viewModel = ProjectViewModel()
    
    //MARK: View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setInit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.fetchProjects() {
            DispatchQueue.main.async {
                self.tblView?.delegate = self
                self.tblView?.dataSource = self
                self.tblView?.reloadData()
            }
        }
    }
    
    //MARK: Methods
    func setInit() {
        setTitle(AppString.Project.uppercased())
        tblView?.register(UINib(nibName: Xib.projectCell, bundle: nil), forCellReuseIdentifier: ProjectCell.reuseidentifier)
        tblView?.addSubview(refreshControl)
        txtSearch?.delegate = self
    }
    
    /// Fetch all data from the server and set into tableview
    func fetchProjects(completionHandler: @escaping () -> Void) {
        self.viewModel.apiFetchProjects { isSuccess in
            if isSuccess! {
                completionHandler()
            }
        }
    }
    
    //MARK: refresh- To Refreh tableview
    @objc func refresh(_ sender: AnyObject) {
        fetchProjects { [weak self] in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
            }
        }
    }
}

//MARK: Tablview Delegate
extension ProjectVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.projectCount
    }
    
    /// Fetch all data from the server and set into tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProjectCell = tableView.dequeueReusableCell(for: indexPath)
        let projectViewModel = viewModel.cellViewModel(at: indexPath)
        cell.setData(projectViewModel)
        return cell
    }
    
    /// open ios default browser to load contest link
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let singleProject = viewModel.cellViewModel(at: indexPath)
        let url = singleProject.repositoryURL
        open(url: url)
    }
}

//MARK: TextField Delegate
extension ProjectVC: UITextFieldDelegate {
    /// when search contest and write something in the search textfield
    @IBAction func valueChange(_ sender: UITextField) {
        viewModel.filterData(strSerchText: sender.text!) { [weak self] isSuccess in
            self?.tblView.reloadData()
        }
    }
    
    /// when user click on return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ProjectVC: URLOpenable, CustomViewController {}

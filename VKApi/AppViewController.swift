//
//  AppViewController.swift
//  VKApi
//
//  Created by Amina TomasMart on 24.02.2024.
//

import UIKit

class AppViewController: UIViewController {
    
    let manager = VKManager()
    var groups: [VKGroup] = []
    
    lazy var table: UITableView = {
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        $0.dataSource = self
        $0.delegate = self
        return $0
    }(UITableView(frame: view.frame))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мои группы"
        view.addSubview(table)
        view.backgroundColor = .systemGray6
        manager.getGroups { [weak self] group in
            self?.groups = group
            DispatchQueue.main.async {
                self?.table.reloadData()
            }
        }
    }
}

extension AppViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.image = .add
        content.text = groups[indexPath.row].name
        content.secondaryText = groups[indexPath.row].screenName
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension AppViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailVC()
        vc.groups = groups[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

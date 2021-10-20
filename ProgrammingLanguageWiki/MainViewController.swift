//
// © 2021. yagom academy all rights reserved
// This tutorial is produced by Yagom Academy and is prohibited from redistributing or reproducing.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var listSegmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var currentList = ProgrammingLanguageInfoManager.shared.infoList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if listSegmentedControl.selectedSegmentIndex  == 1 {
            mainTableView.reloadData()
        }
    }

    private func setUpDelegate() {
        mainTableView.dataSource = self
        mainTableView.delegate = self
        searchBar.delegate = self
    }

    @IBAction func listSegment(_ sender: UISegmentedControl) {
        mainTableView.reloadData()
    }
}

// MARK: - UITableView DataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let isLikeSegmentSelected: Bool = listSegmentedControl.selectedSegmentIndex == 1
        let list = currentList.filter { item in
            return !isLikeSegmentSelected || item.isLike
        }
        
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as? MainTableViewCell else {
            return UITableViewCell()
        }
        let isLikeSegmentSelected: Bool = listSegmentedControl.selectedSegmentIndex == 1
        let list = currentList.filter { item in
            return !isLikeSegmentSelected || item.isLike
        }
        let item = list[indexPath.row]
        
        cell.logoImageView.image = item.logoImage
        cell.nameLabel.text = item.name
        
        return cell
    }
}

// MARK: - UITableView Delegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let isLikeSegmentSelected: Bool = listSegmentedControl.selectedSegmentIndex == 1
        let list = currentList.filter { item in
            return !isLikeSegmentSelected || item.isLike
        }
        
        guard let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }

        nextViewController.languageIndex = ProgrammingLanguageInfoManager.shared.infoList.firstIndex(of: list[indexPath.row])
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}

// MARK: - UISearchBar Delegate
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let input = searchBar.text, searchBar.text != "" else {
            currentList = ProgrammingLanguageInfoManager.shared.infoList
            mainTableView.reloadData()
            return
        }
        
        currentList = ProgrammingLanguageInfoManager.shared.infoList.filter {
            $0.name.lowercased().contains(input.lowercased())
        }
        
        mainTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - Keyboard Control
extension MainViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

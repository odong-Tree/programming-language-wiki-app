//
// © 2021. yagom academy all rights reserved
// This tutorial is produced by Yagom Academy and is prohibited from redistributing or reproducing.
//

import UIKit

protocol LikeButtonDelegate {
    func reloadCurrentList()
}

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
    
    private func updateCurrentListAccordingToSegment() {
        let segmentValue = listSegmentedControl.selectedSegmentIndex == 1
        currentList = ProgrammingLanguageInfoManager.shared.filteredList(isLikeSegment: segmentValue)
    }

    @IBAction func listSegment(_ sender: UISegmentedControl) {
        updateCurrentListAccordingToSegment()
        filterListOutWithSearchBar()
        mainTableView.reloadData()
    }
}

// MARK: - UITableView DataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell") as? MainTableViewCell else {
            return UITableViewCell()
        }
        let item = currentList[indexPath.row]
        
        cell.logoImageView.image = item.logoImage
        cell.nameLabel.text = item.name
        
        return cell
    }
}

// MARK: - UITableView Delegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        guard let language = ProgrammingLanguageInfoManager.shared.infoList.filter({ language in
            language.name == currentList[indexPath.row].name
        }).first else { return }

        nextViewController.languageIndex = ProgrammingLanguageInfoManager.shared.infoList.firstIndex(of: language)
        nextViewController.likeButtonDelegate = self
        self.navigationController?.pushViewController(nextViewController, animated: true)
        self.view.endEditing(true)
    }
}

// MARK: - UISearchBar Delegate
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterListOutWithSearchBar()
        mainTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    private func filterListOutWithSearchBar() {
        guard let input = searchBar.text, searchBar.text != "" else {
            updateCurrentListAccordingToSegment()
            mainTableView.reloadData()
            return
        }
        
        currentList = currentList.filter {
            $0.name.lowercased().contains(input.lowercased())
        }
    }
}

// MARK: - Keyboard Control
extension MainViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

// MARK: - LikeButton Delegate
extension MainViewController: LikeButtonDelegate {
    func reloadCurrentList() {
        updateCurrentListAccordingToSegment()
        filterListOutWithSearchBar()
    }
}

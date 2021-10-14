//
//  ViewController.swift
//  ProgrammingLanguageWiki
//
//  Created by 김동빈 on 2021/10/12.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var listSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if listSegmentedControl.selectedSegmentIndex  == 1 {
            mainCollectionView.reloadData()
        }
    }

    private func setUpDelegate() {
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
    }

    @IBAction func listSegment(_ sender: UISegmentedControl) {
        mainCollectionView.reloadData()
    }
}

// MARK: - CollectionView DataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let isLikeSegmentSelected: Bool = listSegmentedControl.selectedSegmentIndex == 1
        let list = ProgrammingLanguageInfoManager.shared.infoList.filter { item in
            return !isLikeSegmentSelected || item.isLike
        }
        
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as? MainCollectionViewCell else {
            return UICollectionViewCell()
        }
        let isLikeSegmentSelected: Bool = listSegmentedControl.selectedSegmentIndex == 1
        let list = ProgrammingLanguageInfoManager.shared.infoList.filter { item in
            return !isLikeSegmentSelected || item.isLike
        }
        let item = list[indexPath.row]
        
        cell.logoImageView.image = item.logoImage
        cell.nameLabel.text = item.name
        
        return cell
    }
}

// MARK: - CollectionView Delegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let isLikeSegmentSelected: Bool = listSegmentedControl.selectedSegmentIndex == 1
        let list = ProgrammingLanguageInfoManager.shared.infoList.filter { item in
            return !isLikeSegmentSelected || item.isLike
        }
        
        guard let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }

        nextViewController.programmingLanguage = list[indexPath.row]
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}

// MARK: - CollectionView Delegate FlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = mainCollectionView.frame.width * 0.45
        let height: CGFloat = width * 1.1
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset: CGFloat = mainCollectionView.frame.width * 0.1 / 3
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
}
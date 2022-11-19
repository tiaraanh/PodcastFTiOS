//
//  HomeViewController.swift
//  PodcastFTiOS
//
//  Created by Tiara H on 10/11/22.
//

import UIKit
import Kingfisher

class HomeViewController: BaseViewController {
    @IBOutlet var collectionView: UICollectionView!
    weak var recommendedListView: UICollectionView?

    var recommendedsViewModel = RecommendedViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
        loadRecommendeds(q: "makna")
        title = "Podcasts"
        
    }
    
    func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @objc func loadRecommendeds(q: String) {
        recommendedsViewModel.fetchPodcasts(q: q) { (result) in
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == self.collectionView {
            return 2
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            if section == 0 {
                return 1
            } else {
                return 9
            }
        } else {
//            return 8
            return recommendedsViewModel.numberOfRecommendeds
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView != self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommended", for: indexPath) as! RecommendedViewCell
            
            let index = indexPath.row
            cell.thumbImageView.kf.setImage(with: URL(string: recommendedsViewModel.recommendedImageUrl(at: index))) { (result) in
                switch result {
                case.success:
                    cell.thumbImageView.contentMode = .scaleAspectFill
                case .failure:
                    cell.thumbImageView.contentMode = .center
                    cell.thumbImageView.image = UIImage(systemName: "photo")
                }
                
            }
            
            return cell
        } else {
            
            // section 1
            if indexPath.section == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendedList", for: indexPath) as! RecommendedListViewCell
                
                cell.collectionView.backgroundColor = .clear
                self.recommendedListView = cell.collectionView
                
                cell.collectionView.dataSource = self
                cell.collectionView.delegate = self
                
                return cell
                
                // section 2 
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collections", for: indexPath) as! CollectionsViewCell
                
//                let item = indexPath.item
                cell.titleLabel.text = "Is it the Answer"
                cell.dateLabel.text = "Release date:  March, 23 - 2017"
                
                return cell
                
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
        
        let titleLabel = view.viewWithTag(100) as! UILabel
        let subtitleLabel = view.viewWithTag(101) as! UILabel
        
        if indexPath.section == 0 {
            titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
            titleLabel.text = "FazzTrack Weekly"
            titleLabel.isHidden = false
            subtitleLabel.text = "FazzTrack Podcast Collection"
            subtitleLabel.isHidden = false
        } else {
            titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
            titleLabel.text = "Collection"
            titleLabel.isHidden = false
            subtitleLabel.isHidden = true
            
            
        }
        
        return view
    }
}
    
// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            
            if collectionView == self.collectionView {
            if section == 0 {
                return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: -10)
            } else {
                // section 2
                return UIEdgeInsets(top: 0, left: -60, bottom: 0, right: -10)
            }

            } else {
                // section 1
                return UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
            }
            
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if collectionView == self.recommendedListView {
            return CGSize(width: 273, height: 187)
        } else {
        // section 2
        if indexPath.section != 0 {
            return CGSize(width: 80, height: 80)
        } else {
            // section 1
            let leftInset: CGFloat = 10.0
            let rightInset: CGFloat = 10.0
            
            let screenwidth = UIScreen.main.bounds.width
            let width = screenwidth - (leftInset + rightInset)
            let height = 187.0
            return CGSize(width: width, height: height)
        }
        }
        
    }
        
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
}

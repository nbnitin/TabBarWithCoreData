//
//  HomeViewController.swift
//  CoreDataWithTabBar
//
//  Created by Nitin Bhatia on 16/02/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    //outlets
    @IBOutlet weak var wholeDataLoader: UIActivityIndicatorView!
    @IBOutlet weak var collViewGifs: UICollectionView!
    
    //variables
    let vm = GetGifsViewModel()
    var data : AllGifModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collViewGifs.register(UINib(nibName: "GifDisplayCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "cell")
        
        Task {
            if let data = await vm.getAllGifs() {
                self.data = data
                collViewGifs.reloadData()
            } else {
                let alert = UIAlertController(title: "Error", message: "Something wentWrong", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .cancel)
                alert.addAction(alertAction)
                present(alert, animated: true)
            }
            wholeDataLoader.stopAnimating()
        }
    }
}

//MARK: - collection view delegates and datasource extension
extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data {
            return data.data?.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GifDisplayCollectionViewCell
        cell.configCell(data!.data?[indexPath.row].images?.fixedHeightSmall?.url ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 10, bottom: 10, right: 10)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  30
        let size = self.view.frame.width - padding
        return CGSize(width: size/2, height: size/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! GifDisplayCollectionViewCell
        
        if let _ = DataBaseHandler.shared.searchData(imageId: data!.data?[indexPath.row].images?.fixedHeightSmall?.url ?? "") {
            return
        }
        
        DataBaseHandler.shared.saveData(data: [["imageData":cell.img.image?.pngData(),"imageId": data!.data?[indexPath.row].images?.fixedHeightSmall?.url ?? ""]])
        cell.favouriteStatus(true)
       
        
    }
    
}

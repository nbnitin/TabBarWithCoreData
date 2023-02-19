//
//  FavoriteViewController.swift
//  CoreDataWithTabBar
//
//  Created by Nitin Bhatia on 16/02/23.
//

import UIKit

class FavoriteViewController: UIViewController {

    //outlets
    @IBOutlet weak var collViewFavourite: UICollectionView!
    
    //variables
    var data : [FavGifs] = [FavGifs]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collViewFavourite.register(UINib(nibName: "GifDisplayCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "cell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getData()
    }
    
    private func getData() {
        data = DataBaseHandler.shared.fetchData()
        
        if data.count == 0 {
            let alert = UIAlertController(title: "", message: "No record Found", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .cancel)
            alert.addAction(alertAction)
            present(alert, animated: true)
            return
        }
        collViewFavourite.reloadData()
    }

}

//MARK: - collection view delegates and datasource extension
extension FavoriteViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GifDisplayCollectionViewCell
        cell.configCell(data[indexPath.row].imageId!)
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
//         let cell = collectionView.cellForItem(at: indexPath) as! GifDisplayCollectionViewCell
//
//         DataBaseHandler.shared.saveData(data: [["imageData":cell.img.image?.pngData(),"imageId": data!.data?[indexPath.row].images?.fixedHeightSmall?.url ?? ""]])
//         cell.favouriteStatus(true)
//
        
    }
}

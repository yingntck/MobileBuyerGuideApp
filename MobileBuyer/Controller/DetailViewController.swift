//
//  DetailViewController.swift
//  MobileBuyer
//
//  Created by Nanthicha Kritveeranant on 28/8/2562 BE.
//  Copyright © 2562 Nanthicha Kritveeranant. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
  var detail: String = ""
  var price: Double = 0.0
  var raiting: Double = 0.0
  var id: Int = 0
  var pic: Picture!
  
  
  @IBOutlet weak var raitingLabel: UILabel!
  @IBOutlet weak var detailLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var mCollectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    detailLabel.text = detail
    raitingLabel.text = "Raiting: \(raiting)"
    priceLabel.text = "Price: $\(price)"
    id = 1
    feedPicData()
  }
  
  func feedPicData() {
    let _url = "https://scb-test-mobile.herokuapp.com/api/mobiles/\(id)/images//"
    
    FeedData.shared.getPicture(url: _url) { (result) in
      self.pic = result
      print(result)
      self.mCollectionView.reloadData()
    }
  }
}

extension DetailViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if let count = self.pic?.count {
      return count
    } else {
      return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? DetailCollectionViewCell
    cell?.mCollectionImageView.loadImageUrl(pic[indexPath.row].url)
    
    return cell!
  }
}

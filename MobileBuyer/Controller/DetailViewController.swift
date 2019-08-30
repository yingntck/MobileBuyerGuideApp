//
//  DetailViewController.swift
//  MobileBuyer
//
//  Created by Nanthicha Kritveeranant on 28/8/2562 BE.
//  Copyright © 2562 Nanthicha Kritveeranant. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UICollectionViewDataSource,  UICollectionViewDelegate {
  
  var name: String?
  var detail: String?
  var price: Double = 0.0
  var rating: Double = 0.0
  var idUser: Int?
  var mobileData: MobileModel?
  var picture: [PictureModel] = []
  
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var detailLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var mCollectionView: UICollectionView!
  @IBOutlet weak var titleName: UINavigationItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
    detailLabel.text = mobileData?.mobileDescription
    ratingLabel.text = "Rating: \(mobileData?.rating ?? 0.00)"
    priceLabel.text = "Price: $\(mobileData?.price ?? 0.00)"
    titleName.title = mobileData?.name
    
    feedPicData()
    mCollectionView.delegate = self
    mCollectionView.dataSource = self
  }
  
  func feedPicData() {
    if let num = mobileData?.id {
      FeedData.shared.getPicture(id: "\(num)") { (result) in
        self.picture = result
        self.mCollectionView.reloadData()
      }
    }
  }
  
  func isValidHTTP(url:String) -> Bool {
    let heads    = "((http|https)://)"
    let head     = "([(w|W)]{3}+\\.)?"
    let tail     = "\\.+[A-Za-z]{2,3}+(\\.)?+(/(.)*)?"
    let urlRegEx = heads+head+"+(.)+"+tail
    let httpTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)
    return httpTest.evaluate(with: url)
  }
  
  func checkHTTP(url:String) -> String {
    var link:String = url
    //    print(url)
    if isValidHTTP(url: url){
      //            print("correct")
    } else {
      link = "https://\(url)"
    }
    return link
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return picture.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? DetailCollectionViewCell
    
    var item = picture[indexPath.row].url
    item = checkHTTP(url: item)
    cell?.mCollectionImageView.loadImageUrl(item)
    return cell!
  }
}

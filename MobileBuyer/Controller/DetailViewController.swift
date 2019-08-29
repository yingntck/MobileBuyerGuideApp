//
//  DetailViewController.swift
//  MobileBuyer
//
//  Created by Nanthicha Kritveeranant on 28/8/2562 BE.
//  Copyright © 2562 Nanthicha Kritveeranant. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UICollectionViewDataSource,  UICollectionViewDelegate{
  
  var name: String?
  var detail: String?
  var price: Double = 0.0
  var raiting: Double = 0.0
  var idUser: Int = 0
  var pic: [PictureElement] = []
  
  @IBOutlet weak var raitingLabel: UILabel!
  @IBOutlet weak var detailLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var mCollectionView: UICollectionView!
  @IBOutlet weak var titleName: UINavigationItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    detailLabel.text = detail
    raitingLabel.text = "Raiting: \(raiting)"
    priceLabel.text = "Price: $\(price)"
    titleName.title = name
    
    feedPicData()
    mCollectionView.delegate = self
    mCollectionView.dataSource = self
  }
  
  func feedPicData() {
    let _url = "https://scb-test-mobile.herokuapp.com/api/mobiles/\(idUser)/images//"
    
    FeedData.shared.getPicture(url: _url) { (result) in
      self.pic = result
      //      print(result)
      self.mCollectionView.reloadData()
    }
  }
  
  func checkUrl() {
    
  }
  
}

extension DetailViewController {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.pic.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? DetailCollectionViewCell
    
    var item = self.pic[indexPath.row].url
    
    item = self.checkHTTP(url: item)
    
    print(item)
    cell?.mCollectionImageView.loadImageUrl(item)
    
    return cell!
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //    print("Hello")
  }
  
  func isValidHTTP(url:String) -> Bool{
    let head1    = "((http|https)://)"
    let head     = "([(w|W)]{3}+\\.)?"
    let tail     = "\\.+[A-Za-z]{2,3}+(\\.)?+(/(.)*)?"
    let urlRegEx = head1+head+"+(.)+"+tail
    let httpTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)
    return httpTest.evaluate(with: url)
  }
  
  func checkHTTP(url:String) -> String{
    var link:String = url
    print(url)
    if isValidHTTP(url: url){
      //            print("correct")
    } else {
      link = "https://\(url)"
    }
    return link
  }
}

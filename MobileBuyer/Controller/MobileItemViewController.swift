//
//  MobileItemViewController.swift
//  MobileBuyer
//
//  Created by Nanthicha Kritveeranant on 27/8/2562 BE.
//  Copyright © 2562 Nanthicha Kritveeranant. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire


class MobileItemViewController: UITableViewController {
  
  @IBOutlet weak var mTableView: UITableView!
  
  var dataInfo:[MobileElement] = []
  let _url = "https://scb-test-mobile.herokuapp.com/api/mobiles/"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    FeedData.shared.feed(url: _url) { (result) in
      for i in result {
        let newBean = MobileElement(rating: i.rating, id: i.id, thumbImageURL: i.thumbImageURL, price: i.price, brand: i.brand, name: i.name, mobileDescription: i.mobileDescription)
        self.dataInfo.append(newBean)
      }
      self.mTableView.reloadData()
//      print (self.dataInfo.count)
    }
  }
  
  @IBAction func sortBtn(_ sender: Any) {
    print("clicked")
  }
  
  @IBAction func starBtn(_ sender: Any) {
    print("click star")
  }
  
  @IBAction func allBtn(_ sender: Any) {
    print("click all")
  }
  
  @IBAction func favBtn(_ sender: Any) {
    print("click fav")
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataInfo.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "mobileCell") as? MobileTableViewCell
    let item = self.dataInfo[indexPath.row]
    
    cell?.nameLabel.text = item.name
    cell?.detailLabel.text = item.mobileDescription
    cell?.priceLabel.text = "Price: $\(item.price)"
    cell?.raitingLabel.text = "Raiting: \(item.rating)"
    cell?.ImageView.loadImageUrl(item.thumbImageURL)
    
    return cell!
  }
  
  func addCellToFavourite(cell: UITableViewCell) {
    
  }
  
  
  //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  //        print("Selected Row: \(indexPath.row)")
  //        self.mTableView.deselectRow(at: indexPath, animated: true)
  
  //        let item = self.dataInfo[indexPath.row]
  //        let vc = XCDYouTubeVideoPlayerViewController(videoIdentifier: item.id)
  //        self.present(vc, animated: true, completion: nil)
  //    }
  
}

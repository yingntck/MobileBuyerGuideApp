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
  var indexItem: Int = 0
  
  
  let _url = "https://scb-test-mobile.herokuapp.com/api/mobiles/"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    FeedData.shared.feed(url: _url) { (result) in
      for i in result {
        let newBean = MobileElement(rating: i.rating, id: i.id, thumbImageURL: i.thumbImageURL, price: i.price, brand: i.brand, name: i.name, mobileDescription: i.mobileDescription, isFav: false)
        self.dataInfo.append(newBean)
      }
      self.mTableView.reloadData()
      //      print (self.dataInfo.count)
    }
  }
  
  @IBAction func sortBtn(_ sender: Any) {
//    print("sort clicked")
    showSortAlert()
  }
  //
  //  @IBAction func starBtn(_ sender: Any) {
  //    print("click star")
  //  }
  //
  //  @IBAction func allBtn(_ sender: Any) {
  //    print("click all")
  //  }
  //
  //  @IBAction func favBtn(_ sender: Any) {
  //    print("click fav")
  //  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataInfo.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "mobileCell") as? MobileTableViewCell
    let item = self.dataInfo[indexPath.row]
    
    cell?.mobileVC = self
    cell?.index = indexPath.row
    cell?.nameLabel.text = item.name
    cell?.detailLabel.text = item.mobileDescription
    cell?.priceLabel.text = "Price: $\(item.price)"
    cell?.raitingLabel.text = "Raiting: \(item.rating)"
    cell?.ImageView.loadImageUrl(item.thumbImageURL)
    
    return cell!
  }
  
  func addCellToFavourite(cell: UITableViewCell) {
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail" {
      if let vc = segue.destination as? DetailViewController {
        let item = dataInfo[indexItem]
        vc.detail = item.mobileDescription
        vc.price = item.price
        vc.raiting = item.rating
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("Selected Row: \(indexPath.row)")
    self.mTableView.deselectRow(at: indexPath, animated: true)
    indexItem = indexPath.row
    performSegue(withIdentifier: "showDetail", sender: nil)
  }
  
  func showSortAlert() {
    let alert = UIAlertController(title: "Sort", message: nil, preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: "Price low to high", style: .default, handler: { (_) in
      self.dataInfo.sort(by: { (first, second) -> Bool in
        first.price<second.price
      })
      self.mTableView.reloadData()
    }))
    
    alert.addAction(UIAlertAction(title: "Price high to low", style: .default, handler: { (_) in
      self.dataInfo.sort(by: { (first, second) -> Bool in
        first.price>second.price
      })
      self.mTableView.reloadData()
    }))
    
    alert.addAction(UIAlertAction(title: "Rating", style: .default, handler: { (_) in
      self.dataInfo.sort(by: { (first, second) -> Bool in
        first.rating>second.rating
      })
      self.mTableView.reloadData()
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
      
    }))
    self.present(alert, animated: true, completion: nil)
  }
  
}

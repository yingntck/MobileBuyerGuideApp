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


class MobileItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var mTableView: UITableView!
  
  var dataInfo:[MobileElement] = []
  var indexItem: Int = 0
  var favoriteID:[Int] = []
  var isFavMode = false
  
  let _url = "https://scb-test-mobile.herokuapp.com/api/mobiles/"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    feedData()
  }
  
  @IBAction func sortBtn(_ sender: Any) {
    showSortAlert()
  }
  
  @IBAction func allBtn(_ sender: Any) {
    isFavMode = false
    mTableView.reloadData()
    
  }
  
  @IBAction func favBtn(_ sender: Any) {
    isFavMode = true
    mTableView.reloadData()
  }
  
  func feedData() {
    FeedData.shared.feed(url: _url) { (result) in
      for i in result {
        let newItem = MobileElement(rating: i.rating, id: i.id, thumbImageURL: i.thumbImageURL, price: i.price, brand: i.brand, name: i.name, mobileDescription: i.mobileDescription)
        self.dataInfo.append(newItem)
      }
      self.mTableView.reloadData()
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFavMode {
          // check favid == datainfo.id
          let displayFav = dataInfo.filter {
            return favoriteID.contains($0.id)
          }
          return displayFav.count
        }
        return dataInfo.count
  }
  
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    if isFavMode {
      return true
    } else {
      return false
    }
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      if isFavMode {
//        print("delete")
        favoriteID.remove(at: indexPath.row)
//        print(favoriteID)
        mTableView.reloadData()
      }
    }
  }
  
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "mobileCell") as? MobileTableViewCell
    
    if isFavMode {
      let displayFav = dataInfo.filter {
        return favoriteID.contains($0.id)
      }
      let item = displayFav[indexPath.row]

      showData(item: item, cell: cell!, indexPath: indexPath)
      cell?.starBtn.isHidden = true
      
      return cell!
    } else {
      let item = dataInfo[indexPath.row]
      
      showData(item: item, cell: cell!, indexPath: indexPath)
      cell?.updateStar(isFav: favoriteID.contains(item.id))
      cell?.starBtn.isHidden = false
      
      return cell!
    }
  }
  
  func showData(item: MobileElement,cell: MobileTableViewCell, indexPath: IndexPath) {
    cell.mobileVC = self
    cell.nameLabel.text = item.name
    cell.detailLabel.text = item.mobileDescription
    cell.priceLabel.text = "Price: $\(item.price)"
    cell.raitingLabel.text = "Raiting: \(item.rating)"
    cell.ImageView.loadImageUrl(item.thumbImageURL)
  }
  
  func addCellToFavourite(cell: UITableViewCell, isFav: Bool) {
    let favCell = mTableView.indexPath(for: cell)
    let index = favCell?.row
    let item = dataInfo[index!].id
    //    print("favCell: \(favCell!)")
    if isFav {
      if !favoriteID.contains(item) {
        favoriteID.append(item)
      }
    } else {
      if let index = favoriteID.firstIndex(of: item) {
        favoriteID.remove(at: index)
      }
      //      favId = favId.filter{
      //        return $0 != item
      //      }
    }
    print(favoriteID)
    mTableView.reloadData()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail" {
      if let vc = segue.destination as? DetailViewController {
        let item = dataInfo[indexItem]
        vc.detail = item.mobileDescription
        vc.price = item.price
        vc.raiting = item.rating
        vc.name = item.name
        vc.idUser = item.id
      }
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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

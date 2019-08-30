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
  @IBOutlet weak var allButton: UIButton!
  @IBOutlet weak var favoriteButton: UIButton!
  
  var dataInfo:[MobileElement] = []
  var indexItem: Int = 0
  var favoriteID:[Int] = []
  var isFavMode = false
  
  let _url = "https://scb-test-mobile.herokuapp.com/api/mobiles/"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    feedData()
    favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    allButton.addTarget(self, action: #selector(allButtonTapped), for: .touchUpInside)
    style()
  }
  
  @IBAction func sortButton(_ sender: Any) {
    showSortAlert()
  }
  
  @objc func allButtonTapped() {
    isFavMode = false
    allButton.setTitleColor(UIColor.black, for: .normal)
    favoriteButton.setTitleColor(UIColor.lightGray, for: .normal)
    mTableView.reloadData()
  }
  
  @objc func favoriteButtonTapped() {
    print("fav tapped")
    isFavMode = true
    allButton.setTitleColor(UIColor.lightGray, for: .normal)
    favoriteButton.setTitleColor(UIColor.black, for: .normal)
    mTableView.reloadData()
  }
  
  func style(){
    bottomBorderTextField(btn: allButton)
    bottomBorderTextField(btn: favoriteButton)
  }
  
  func bottomBorderTextField(btn: UIButton) {
    let bottomLine = CALayer()
    bottomLine.frame = CGRect(x: 0.0, y: btn.frame.height - 1, width: btn.frame.width - 1, height: 3.0)
    bottomLine.backgroundColor = UIColor.lightGray.cgColor
    btn.layer.addSublayer(bottomLine)
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
    cell.ratingLabel.text = "Rating: \(item.rating)"
    cell.ImageView.loadImageUrl(item.thumbImageURL)
  }
  
  func addCellToFavourite(cell: UITableViewCell, isFav: Bool) {
    let favCell = mTableView.indexPath(for: cell)
    if let index = favCell?.row {
      let item = dataInfo[index].id
      //    print("favCell: \(favCell!)")
      if isFav {
        if !favoriteID.contains(item) {
          favoriteID.append(item)
        }
      } else {
        if let index = favoriteID.firstIndex(of: item) {
          favoriteID.remove(at: index)
        }
      }
      print(favoriteID)
      mTableView.reloadData()
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail" {
      if let vc = segue.destination as? DetailViewController {
        if isFavMode {
          let displayFav = dataInfo.filter {
            return favoriteID.contains($0.id)
          }
          let item = displayFav[indexItem]
          vc.detail = item.mobileDescription
          vc.price = item.price
          vc.rating = item.rating
          vc.name = item.name
          vc.idUser = item.id
        } else {
          let item = dataInfo[indexItem]
          vc.detail = item.mobileDescription
          vc.price = item.price
          vc.rating = item.rating
          vc.name = item.name
          vc.idUser = item.id
        }
      }
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("Selected Row: \(indexPath.row)")
    mTableView.deselectRow(at: indexPath, animated: true)
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

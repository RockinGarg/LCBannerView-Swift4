//
//  ViewController.swift
//  LcBannerViewDemo
//
//  Created by IosDeveloper on 02/11/17.
//  Copyright © 2017 iOSDeveloper. All rights reserved.
//

import UIKit
import LCBannerView

class ViewController: UIViewController,LCBannerViewDelegate {
    
    
    @IBOutlet weak var baseBannerView: LCBannerView!
    @IBOutlet weak var DemoCollectionView: UICollectionView!
    
    //Cell Identifier
    let cellReuseIdentifier = "Cell"
    //Screen Size
    let width = UIScreen.main.bounds.size.width
    let Height = UIScreen.main.bounds.size.height
    
    var namesArray = ["1","2","3","4","5","6","7","8","9"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.DemoCollectionView.delegate = self
        self.DemoCollectionView.dataSource = self
        self.DemoCollectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        baseBannerView.addSubview(self.AddBannerView(bannerView: baseBannerView, imageUrlArray: ["http://wedding-dj-kent.com/wp-content/uploads/2015/12/1-IMG_2680.jpg","http://wedding-dj-kent.com/wp-content/uploads/2015/12/1-IMG_2680.jpg","http://wedding-dj-kent.com/wp-content/uploads/2015/12/1-IMG_2680.jpg","http://wedding-dj-kent.com/wp-content/uploads/2015/12/1-IMG_2680.jpg"]))

    }
    
    //Return a BannerView
    func AddBannerView(bannerView: UIView, imageUrlArray: [String]) -> LCBannerView{
        let banner = LCBannerView.init(frame: CGRect(x: 0, y: 0, width: bannerView.frame.size.width, height: bannerView.frame.size.height), delegate: self, imageURLs: imageUrlArray, placeholderImageName: "Concert", timeInterval: 3, currentPageIndicatorTintColor: UIColor.blue, pageIndicatorTintColor: UIColor.white)

        banner?.clipsToBounds = true
        return banner!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK:-----CollectionView Delegates------
extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    //Setting number of data in Section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return namesArray.count
    }
    //Setting number of sections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //Setting data in cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier,for: indexPath) as! CustomCollectionCell
        
        cell.cellLabel.text = namesArray[indexPath.row]
  
        // Delay 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            cell.cellBannerView.addSubview(self.AddBannerView(bannerView: cell.cellBannerView, imageUrlArray: ["http://wedding-dj-kent.com/wp-content/uploads/2015/12/1-IMG_2680.jpg","http://wedding-dj-kent.com/wp-content/uploads/2015/12/1-IMG_2680.jpg","http://wedding-dj-kent.com/wp-content/uploads/2015/12/1-IMG_2680.jpg","http://wedding-dj-kent.com/wp-content/uploads/2015/12/1-IMG_2680.jpg"]))
        }

        return cell
    }
    
    //Setting size of cell
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var cellSize = CGSize()
        
        //Seting Size cell as Required
        if indexPath.row % 3 == 2 {
            //If index is third
            cellSize =  CGSize(width: width - 14, height: Env.iPad ? Height*0.35 : Height*0.3)
        }
        else {
            //if not
            cellSize = CGSize(width: width/2 - 14, height: Env.iPad ? Height*0.35 : Height*0.3)
        }
        return cellSize
    }
    
    //Addigng insets Sopacing required
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return  UIEdgeInsetsMake(8, 8, 8, 8)
    }
    //Space between Sections
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }
    //Space between New Index Occurs
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 8
    }
}


//
//  ZHIntroViewController.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/2/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

let SegueIntroToMain = "SegueIntroToMain"
let SegueSettingsToCaloriesPerDrink = "SegueSettingsToCaloriesPerDrink"

class ZHIntroViewController: UIViewController {
    
    var user: ZHUserModel? = nil
    var introCompleteHandler:((user: ZHUserModel)->Void)!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var closeBarButton: UIBarButtonItem!

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navItem: UINavigationItem!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // See if there is a user in userdefaults
        let storedUser = ZHUserDefaults.sharedInstance.currentUser()
        if let storedUser = storedUser {
            user = storedUser
            navItem.leftBarButtonItem = closeBarButton
        } else {
            user = ZHUserModel()
            navItem.leftBarButtonItem = nil
        }

        let nib0 = UINib(nibName: "ZHIntroWelcomeCollectionViewCell", bundle: NSBundle.mainBundle())
        collectionView.registerNib(nib0, forCellWithReuseIdentifier: "ZHIntroWelcomeCollectionViewCell")
        let nib1 = UINib(nibName: "ZHIntroStartDateCollectionViewCell", bundle: NSBundle.mainBundle())
        collectionView.registerNib(nib1, forCellWithReuseIdentifier: "ZHIntroStartDateCollectionViewCell")
        let nib2 = UINib(nibName: "ZHIntroDrinksPerDayCollectionViewCell", bundle: NSBundle.mainBundle())
        collectionView.registerNib(nib2, forCellWithReuseIdentifier: "ZHIntroDrinksPerDayCollectionViewCell")
        let nib3 = UINib(nibName: "ZHIntroMoneyPerDayCollectionViewCell", bundle: NSBundle.mainBundle())
        collectionView.registerNib(nib3, forCellWithReuseIdentifier: "ZHIntroMoneyPerDayCollectionViewCell")
        let nib4 = UINib(nibName: "ZHIntroCaloriesPerDayCollectionViewCell", bundle: NSBundle.mainBundle())
        collectionView.registerNib(nib4, forCellWithReuseIdentifier: "ZHIntroCaloriesPerDayCollectionViewCell")
        let nib5 = UINib(nibName: "ZHIntroTodayCollectionViewCell", bundle: NSBundle.mainBundle())
        collectionView.registerNib(nib5, forCellWithReuseIdentifier: "ZHIntroTodayCollectionViewCell")
        let nib6 = UINib(nibName: "ZHIntroBadgeCollectionViewCell", bundle: NSBundle.mainBundle())
        collectionView.registerNib(nib6, forCellWithReuseIdentifier: "ZHIntroBadgeCollectionViewCell")
        let nib7 = UINib(nibName: "ZHIntroRedditCollectionViewCell", bundle: NSBundle.mainBundle())
        collectionView.registerNib(nib7, forCellWithReuseIdentifier: "ZHIntroRedditCollectionViewCell")
        let nib8 = UINib(nibName: "ZHIntroDoneCollectionViewCell", bundle: NSBundle.mainBundle())
        collectionView.registerNib(nib8, forCellWithReuseIdentifier: "ZHIntroDoneCollectionViewCell")
        let nib9 = UINib(nibName: "ZHIntroNotificationsCollectionViewCell", bundle: NSBundle.mainBundle())
        collectionView.registerNib(nib9, forCellWithReuseIdentifier: "ZHIntroNotificationsCollectionViewCell")

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollToNextPage() {
        var x = collectionView.contentOffset.x
        x += collectionView.bounds.width
        let offset = CGPoint(x: x, y: 0)
        collectionView.setContentOffset(offset, animated: true)
    }

    @IBAction func next(sender: AnyObject) {
        scrollToNextPage()
    }
    
    @IBAction func closeBarButtonAction(sender: AnyObject) {
        self.introCompleteHandler(user: self.user!)
    }
    
}

extension ZHIntroViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let page = round(scrollView.contentOffset.x / scrollView.bounds.size.width)
//        let page = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        pageControl.currentPage = Int(page)
    }
}

extension ZHIntroViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ZHIntroWelcomeCollectionViewCell", forIndexPath: indexPath) as? ZHIntroWelcomeCollectionViewCell
            cell?.user = user
            cell?.nextHandler = ({ () -> Void in
                self.scrollToNextPage()
            })
            return cell!
        case 1:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ZHIntroStartDateCollectionViewCell", forIndexPath: indexPath) as? ZHIntroStartDateCollectionViewCell
            cell?.user = user
            cell?.nextHandler = ({ () -> Void in
                self.scrollToNextPage()
            })
            return cell!
        case 2:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ZHIntroDrinksPerDayCollectionViewCell", forIndexPath: indexPath) as? ZHIntroDrinksPerDayCollectionViewCell
            cell?.user = user
            cell?.nextHandler = ({ () -> Void in
                self.scrollToNextPage()
            })
            return cell!
        case 3:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ZHIntroMoneyPerDayCollectionViewCell", forIndexPath: indexPath) as? ZHIntroMoneyPerDayCollectionViewCell
            cell?.user = user
            cell?.nextHandler = ({ () -> Void in
                self.scrollToNextPage()
            })
            return cell!
        case 4:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ZHIntroCaloriesPerDayCollectionViewCell", forIndexPath: indexPath) as? ZHIntroCaloriesPerDayCollectionViewCell
            cell?.user = user
            cell?.nextHandler = ({ () -> Void in
                self.scrollToNextPage()
            })
            cell?.helpHandler = ({ () -> Void in
                self.performSegueWithIdentifier(SegueSettingsToCaloriesPerDrink, sender: nil)
            })
            return cell!
        case 5:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ZHIntroTodayCollectionViewCell", forIndexPath: indexPath) as? ZHIntroTodayCollectionViewCell
            cell?.user = user
            cell?.nextHandler = ({ () -> Void in
                self.scrollToNextPage()
            })
            return cell!
        case 6:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ZHIntroNotificationsCollectionViewCell", forIndexPath: indexPath) as? ZHIntroNotificationsCollectionViewCell
            cell?.user = user
            cell?.nextHandler = ({ () -> Void in
                self.scrollToNextPage()
            })
            return cell!
        case 7:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ZHIntroDoneCollectionViewCell", forIndexPath: indexPath) as? ZHIntroDoneCollectionViewCell
            cell?.user = user
            cell?.nextHandler = ({ () -> Void in
                self.introCompleteHandler(user: self.user!)
            })
            return cell!
        default:
            return UICollectionViewCell()
        }
    }
    

}

extension ZHIntroViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

extension ZHIntroViewController: UIBarPositioningDelegate {
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return .TopAttached
    }
}






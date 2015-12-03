//
//  ZHIntroViewController.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/2/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit



class ZHIntroViewController: UIViewController {
    let SegueIntroToMain = "SegueIntroToMain"
    
    var introCompleteHandler:(()->Void)!
    
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet var introWelcomeView: UIView!
    @IBOutlet var introStartDateView: UIView!
    @IBOutlet var introDrinksPerDayView: UIView!
    @IBOutlet var introMoneyPerDayView: UIView!
    @IBOutlet var introCaloriesPerDrinkView: UIView!
    @IBOutlet var introTodayView: UIView!
    @IBOutlet var introBadgeView: UIView!
    @IBOutlet var introRedditView: UIView!
    @IBOutlet var introDoneView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func scrollToNextPage() {
        var x = collectionView.contentOffset.x
        x += collectionView.bounds.width
        let offset = CGPoint(x: x, y: 0)
        collectionView.setContentOffset(offset, animated: true)
    }

    @IBAction func next(sender: AnyObject) {
        scrollToNextPage()
    }
}

//extension ZHIntroViewController: UIScrollViewDelegate {
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        let page = round(scrollView.contentOffset.x / scrollView.bounds.size.width)
////        let page = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
//        pageControl.currentPage = Int(page)
//    }
//}

extension ZHIntroViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ZHIntroWelcomeCollectionViewCell", forIndexPath: indexPath) as? ZHIntroWelcomeCollectionViewCell
            cell?.nextHandler = ({ () -> Void in
                print("fired0")
                self.scrollToNextPage()
            })
            return cell!
        case 1:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ZHIntroStartDateCollectionViewCell", forIndexPath: indexPath) as? ZHIntroStartDateCollectionViewCell
            cell?.nextHandler = ({ () -> Void in
                print("fired1")
                self.scrollToNextPage()
            })
            return cell!
        case 2:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ZHIntroDrinksPerDayCollectionViewCell", forIndexPath: indexPath) as? ZHIntroDrinksPerDayCollectionViewCell
            cell?.nextHandler = ({ () -> Void in
                print("fired2")
                self.scrollToNextPage()
            })
            return cell!
        case 3:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ZHIntroMoneyPerDayCollectionViewCell", forIndexPath: indexPath) as? ZHIntroMoneyPerDayCollectionViewCell
            cell?.nextHandler = ({ () -> Void in
                print("fired3")
                self.scrollToNextPage()
            })
            return cell!
        case 4:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ZHIntroCaloriesPerDayCollectionViewCell", forIndexPath: indexPath) as? ZHIntroCaloriesPerDayCollectionViewCell
            cell?.nextHandler = ({ () -> Void in
                print("fired4")
                self.scrollToNextPage()
            })
            return cell!
        case 5:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ZHIntroTodayCollectionViewCell", forIndexPath: indexPath) as? ZHIntroTodayCollectionViewCell
            cell?.nextHandler = ({ () -> Void in
                print("fired5")
                self.scrollToNextPage()
            })
            return cell!
        case 6:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ZHIntroBadgeCollectionViewCell", forIndexPath: indexPath) as? ZHIntroBadgeCollectionViewCell
            cell?.nextHandler = ({ () -> Void in
                print("fired6")
                self.scrollToNextPage()
            })
            return cell!
        case 7:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ZHIntroRedditCollectionViewCell", forIndexPath: indexPath) as? ZHIntroRedditCollectionViewCell
            cell?.nextHandler = ({ () -> Void in
                print("fired7")
                self.scrollToNextPage()
            })
            return cell!
        case 8:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ZHIntroDoneCollectionViewCell", forIndexPath: indexPath) as? ZHIntroDoneCollectionViewCell
            cell?.nextHandler = ({ () -> Void in
                print("fired8")
                self.introCompleteHandler()
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
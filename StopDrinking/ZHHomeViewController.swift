//
//  ZHHomeViewController.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/2/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit


enum ZHHomeViewControllerTableViewSection: Int{
    case Status = 0
    case Reddit = 1
}



class ZHHomeViewController: UIViewController {
    let SegueMainToIntro = "SegueMainToIntro"
    let SegueMainToRedditThread = "SegueMainToRedditThread"
    var statusBarHidden: Bool = false
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [RKLink] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let user = ZHUserDefaults.sharedInstance.currentUser()
        if user == nil {
            performSegueWithIdentifier(self.SegueMainToIntro, sender: nil)
        } else {
            
        }
        
        reddit()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
//    override func preferredStatusBarStyle() -> UIStatusBarStyle {
//        return .LightContent
//    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SegueMainToIntro {
            let vc = segue.destinationViewController as? ZHIntroViewController
            vc?.introCompleteHandler = ({ (user: ZHUserModel) -> Void in
                
                ZHUserDefaults.sharedInstance.setCurrentUser(user)
                
                self.dismissViewControllerAnimated(true, completion: { () -> Void in
                    self.tableView.reloadData() 
                })
            })
        } else if segue.identifier == SegueMainToRedditThread {
            let vc = segue.destinationViewController as? ZHRedditThreadViewController
            vc?.post = sender as? RKLink
        }
    }
    
    // MARK: IBActions

    @IBAction func introButtonTouchUpInside(sender: AnyObject) {
        performSegueWithIdentifier(self.SegueMainToIntro, sender: nil)
    }
    
    // MARK: Private methods
    func reddit(){
        MBProgressHUD.showHUDAddedTo(view, animated: true)
        RKClient.sharedClient().subredditWithName("stopdrinking", completion: { (subreddit, error) -> Void in
            let pagination = RKPagination()
            RKClient.sharedClient().linksInSubreddit(subreddit as! RKSubreddit, category: RKSubredditCategory.Top, pagination: pagination, completion: { (posts: [AnyObject]!, page: RKPagination!, error:NSError!) -> Void in
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                if error == nil {
                    if self.posts.count == 0 {
                        self.posts = posts as! [RKLink]
                        var indexPaths: [NSIndexPath] = []
                        for index in 0..<posts.count {
                            let indexPath = NSIndexPath(forRow: index, inSection: ZHHomeViewControllerTableViewSection.Reddit.rawValue)
                            indexPaths.append(indexPath)
                        }
                        self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
                    } else {
                        self.tableView.reloadData()
                    }
                } else {
                    print("could not get subreddit links")
                }
            })
        })
    }

}

extension ZHHomeViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case ZHHomeViewControllerTableViewSection.Status.rawValue:
                return 1
        case ZHHomeViewControllerTableViewSection.Reddit.rawValue:
                return posts.count
        default:
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case ZHHomeViewControllerTableViewSection.Status.rawValue:
            let cell = tableView.dequeueReusableCellWithIdentifier("ZHHomeSummaryTableViewCell") as? ZHHomeSummaryTableViewCell
            let user = ZHUserDefaults.sharedInstance.currentUser()
            cell?.user = user
            return cell!
        case ZHHomeViewControllerTableViewSection.Reddit.rawValue:
            let cell = tableView.dequeueReusableCellWithIdentifier("ZHHomeRedditTableViewCell") as! ZHHomeRedditTableViewCell
            cell.post = posts[indexPath.row]
            cell.index = UInt(indexPath.row)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension ZHHomeViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == ZHHomeViewControllerTableViewSection.Reddit.rawValue {
            let post = posts[indexPath.row]
            performSegueWithIdentifier(SegueMainToRedditThread, sender: post)            
        }
    }
}


// This extension hides/shows the navigation bar and status bar as the user scrolls
extension ZHHomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y < view.bounds.size.height / 2.0 {
            showNavBar()
        } else {
            hideNavBar()
        }
    }
    
    func showNavBar() {
        if statusBarHidden == false {
            return
        }
        statusBarHidden = false
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    func hideNavBar() {
        if statusBarHidden == true {
            return
        }
        statusBarHidden = true
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Fade)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
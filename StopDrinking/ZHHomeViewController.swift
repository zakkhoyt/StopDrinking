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
    let SegueMainToWeb = "SegueMainToWeb"
    let SegueMainToAbout = "SegueMainToAbout"
    let SegueMainToRedditThread = "SegueMainToRedditThread"
    var category: RKSubredditCategory = .Hot
    var user: ZHUserModel? = nil

    var pagination: RKPagination? = nil
    var posts: [RKLink] = []
    var isGettingNextPage: Bool = false
    var refreshControl: UIRefreshControl? =  nil
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var categoryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryButton.setTitle("Hot", forState: UIControlState.Normal)
        setupTableView()
        setupUser()
        resetReddit()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SegueMainToIntro {
            let vc = segue.destinationViewController as? ZHIntroViewController
            vc?.introCompleteHandler = ({ (user: ZHUserModel) -> Void in
                self.user = user
                ZHUserDefaults.sharedInstance.setCurrentUser(user)
                
                self.dismissViewControllerAnimated(true, completion: { () -> Void in
                    self.tableView.reloadData()
                })
            })
        } else if segue.identifier == SegueMainToRedditThread {
            let vc = segue.destinationViewController as? ZHRedditThreadViewController
            vc?.post = sender as? RKLink
        } else if segue.identifier == SegueMainToWeb {
            let nc = segue.destinationViewController as! UINavigationController
            let vc = nc.viewControllers[0] as! ZHWebViewController
            vc.url = sender as? NSURL
            
        }
    }
    
    
    
    // MARK: Private methods
    
    func setupTableView() {
        
        
        let nib = NSBundle.mainBundle().loadNibNamed("ZHRedditThreadTableViewCell", owner: self, options: nil).first as? UINib
        tableView.registerNib(nib, forCellReuseIdentifier: "ZHRedditThreadTableViewCell")
        
        // Setup TableView
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Add pull to refresh control
        refreshControl = UIRefreshControl()
        let attr = [NSForegroundColorAttributeName : UIColor.yellowColor()]
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: attr)
        refreshControl?.tintColor = UIColor.yellowColor()
        refreshControl?.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl!)
    }
    
    func setupUser() {
        user = ZHUserDefaults.sharedInstance.currentUser()
        if user == nil {
            // Show setup screen
            performSegueWithIdentifier(self.SegueMainToIntro, sender: nil)
        } else {
            // Schedule notifications
            if user?.notificationTime != nil {
                ZHNotificationScheduler.scheduleNotifications()
            }
            
            // Update Badge
            let days = Int((user?.daysSinceStartDate()!)!)
            UIApplication.sharedApplication().applicationIconBadgeNumber = days
        }
    }
    
    func resetReddit() {
        pagination = nil
        posts = []
        tableView.reloadData()
        getNextPageOfPosts()
    }
    
    
    func getNextPageOfPosts(){
        
        if ZHReachability.isConnectedToNetwork() == false {
            self.presentAlertDialogWithMessage("Please check your internet connection and try again")
        } else {
            
            isGettingNextPage = true
            MBProgressHUD.showHUDAddedTo(view, animated: true)
            RKClient.sharedClient().subredditWithName("stopdrinking", completion: { (subreddit, error) -> Void in
                if error != nil {
                    self.presentAlertDialogWithTitle("Could not get subreddit", errorAsMessage: error)
                } else {
                    RKClient.sharedClient().linksInSubreddit(subreddit as! RKSubreddit, category: self.category, pagination: self.pagination, completion: { (posts: [AnyObject]!, newPagination: RKPagination!, error:NSError!) -> Void in
                        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                        
                        if error != nil {
                            self.presentAlertDialogWithTitle("Could not get posts. Try again later", errorAsMessage: error)
                        } else {
                            self.pagination = newPagination
                            let postsToAppend = posts as! [RKLink]
                            if postsToAppend.count == 0 {
                                self.tableView.reloadData()
                            } else {
                                let start = self.posts.count
                                // Append so self.posts
                                self.posts.appendContentsOf(postsToAppend)
                                let end = self.posts.count
                                
                                print("posts.count: \(self.posts.count)")
                                
                                // Get index paths to insert
                                var indexPaths: [NSIndexPath] = []
                                
                                for index in start ..< end {
                                    let indexPath = NSIndexPath(forRow: index, inSection: ZHHomeViewControllerTableViewSection.Reddit.rawValue)
                                    indexPaths.append(indexPath)
                                }
                                //                            self.tableView.beginUpdates()
                                self.tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
                                //                            self.tableView.endUpdates()
                                //                            self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: self.posts.count, inSection: ZHHomeViewControllerTableViewSection.Reddit.rawValue), atScrollPosition: .Bottom, animated: true)
                            }
                        }
                        
                        
                        // Pause so we don't get a shit load of next pages
                        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
                        dispatch_after(delayTime, dispatch_get_main_queue()) {
                            self.isGettingNextPage = false
                        }
                    })
                }
            })
        }
    }
    
    
    // MARK: IBActions
    
    func refreshControlAction(sender: UIRefreshControl) {
        sender.endRefreshing()
        resetReddit()
    }
    
    @IBAction func sortButtonTouchUpInside(sender: UIButton) {
        let ac = UIAlertController(title: "Category", message: nil, preferredStyle: .ActionSheet)
        
        ac.addAction(UIAlertAction(title: "Hot", style: .Default, handler: { (action) -> Void in
            self.category = .Hot
            self.categoryButton.setTitle("Hot", forState: UIControlState.Normal)
            self.resetReddit()
        }))
        
        ac.addAction(UIAlertAction(title: "New", style: .Default, handler: { (action) -> Void in
            self.category = .New
            self.categoryButton.setTitle("New", forState: UIControlState.Normal)
            self.resetReddit()
        }))
        
        ac.addAction(UIAlertAction(title: "Rising", style: .Default, handler: { (action) -> Void in
            self.category = .Rising
            self.categoryButton.setTitle("Rising", forState: UIControlState.Normal)
            self.resetReddit()
        }))
        
        ac.addAction(UIAlertAction(title: "Controversial", style: .Default, handler: { (action) -> Void in
            self.category = .Controversial
            self.categoryButton.setTitle("Controversial", forState: UIControlState.Normal)
            self.resetReddit()
        }))
        
        ac.addAction(UIAlertAction(title: "Top", style: .Default, handler: { (action) -> Void in
            self.category = .Top
            self.categoryButton.setTitle("Top", forState: UIControlState.Normal)
            self.resetReddit()
        }))

        
        ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action) -> Void in
        }))

        presentViewController(ac, animated: true, completion: nil)
    }
    
    @IBAction func introButtonTouchUpInside(sender: AnyObject) {
        
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        ac.addAction(UIAlertAction(title: "Your settings", style: .Default, handler: { (action) -> Void in
            self.performSegueWithIdentifier(self.SegueMainToIntro, sender: nil)
        }))
        
        ac.addAction(UIAlertAction(title: "About this app", style: .Default, handler: { (action) -> Void in
            self.performSegueWithIdentifier(self.SegueMainToAbout, sender: nil)
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action) -> Void in
            
        }))
        
        
        presentViewController(ac, animated: true, completion: nil)
        
        
    }
    
    @IBAction func helpBarButtonAction(sender: AnyObject) {
        let ac = UIAlertController(title: "Chat with someone", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        ac.addAction(UIAlertAction(title: "/r/stopdrinking main chat", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            let url = NSURL(string: "https://kiwiirc.com/client/irc.snoonet.org/stopdrinking/")
            self.performSegueWithIdentifier(self.SegueMainToWeb, sender: url)
        }))
        
        ac.addAction(UIAlertAction(title: "/r/stopdrinking alternate chat", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            let url = NSURL(string: "http://client00.chat.mibbit.com/?server=irc.snoonet.org&channel=%23stopdrinking")
            self.performSegueWithIdentifier(self.SegueMainToWeb, sender: url)
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler:nil))
        
        presentViewController(ac, animated: true) { () -> Void in
            
        }
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
            cell?.user = user
            return cell!
        case ZHHomeViewControllerTableViewSection.Reddit.rawValue:
            let cell = ZHRedditThreadTableViewCell.cellFromNib()
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
        if scrollView.contentSize.height == 0 || self.isGettingNextPage {
            return;
        } else if scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.size.height {
            getNextPageOfPosts()
        }
    }
}
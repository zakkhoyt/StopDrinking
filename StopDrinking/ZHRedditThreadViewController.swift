//
//  ZHRedditThreadViewController.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/3/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

enum ZHRedditThreadViewControllerSection: Int {
    case Post = 0
    case Comments = 1
}


class ZHRedditThreadViewController: UIViewController

{
    @IBOutlet var treeModel: TreeTable!
    @IBOutlet weak var treeView: UITableView!
    var expandedItems = NSMutableDictionary()
    
    
    
    @IBOutlet var sortBarButton: UIBarButtonItem!
    var post: RKLink? = nil {
        didSet {
            print("set post")
        }
    }
    var comments: [RKComment]? = nil
    var statusBarHidden: Bool = false
    var pagination: RKPagination? = nil
    var refreshControl: UIRefreshControl? =  nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.darkGrayColor()
        UIApplication.sharedApplication().statusBarHidden = false
        navigationItem.title = "Comments"
//        navigationItem.rightBarButtonItem = sortBarButton
        
        
        setupTreeView()
        resetComments()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return statusBarHidden
    }
    
    // MARK: Private methods
    
    func setupTreeView() {

        
        // Add pull to refresh control
        refreshControl = UIRefreshControl()
        let attr = [NSForegroundColorAttributeName : UIColor.yellowColor()]
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: attr)
        refreshControl?.tintColor = UIColor.yellowColor()
        refreshControl?.addTarget(self, action: #selector(ZHRedditThreadViewController.refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        treeView.addSubview(refreshControl!)
        
        let nib = UINib(nibName: "ZHRedditCommentTableViewCell", bundle: NSBundle.mainBundle())
        treeView.registerNib(nib, forCellReuseIdentifier: "ZHRedditCommentTableViewCell")
        treeView.estimatedRowHeight = 100;
        treeView.rowHeight = UITableViewAutomaticDimension
        treeView.backgroundColor = UIColor.darkGrayColor()
        treeView.separatorColor = UIColor.darkGrayColor()

    }
    
    
    func resetComments() {
        pagination = nil
        comments = []
        treeView.reloadData()
        getNextPageOfComments()
    }
    
    
    func getNextPageOfComments() {
        if ZHReachability.isConnectedToNetwork() == false {
            self.presentAlertDialogWithMessage("Please check your internet connection and try again")
        } else {
            MBProgressHUD.showHUDAddedTo(view, animated: true)
            RKClient.sharedClient().commentsForLink(post) { (comments, error) -> Void in
                if error != nil {
                    self.presentAlertDialogWithTitle("Could not get comments. Try again later", errorAsMessage: error)
                }  else {1
                    for comment in comments {
                        if comment is RKComment {
                            self.comments?.append(comment as! RKComment)
                        } else if comment is RKMoreComments {
                            //assert(false, "Finally found a RKMoreComments")
                            print("Finally found a RKMoreComments")
                        }
                    }
                    print("comments.count: \(self.comments?.count)")
                    self.treeView.reloadData()
                }
                MBProgressHUD.hideHUDForView(self.view, animated: true)
            }
        }
    }
    
    
    func getMoreComments() {
        //        RKClient.sharedClient().more
    }
    
    @IBAction func doneButtonAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    @IBAction func sortBarButtonAction(sender: AnyObject) {
        let ac = UIAlertController(title: "Category", message: nil, preferredStyle: .Alert)
        ac.popoverPresentationController?.barButtonItem = sender as? UIBarButtonItem
        
        ac.addAction(UIAlertAction(title: "Hot", style: .Default, handler: { (action) -> Void in
            //            self.category = .Hot
            //            self.categoryButton.setTitle("Hot", forState: UIControlState.Normal)
            //            self.resetReddit()
        }))
        
        ac.addAction(UIAlertAction(title: "New", style: .Default, handler: { (action) -> Void in
            //            self.category = .New
            //            self.categoryButton.setTitle("New", forState: UIControlState.Normal)
            //            self.resetReddit()
        }))
        
        ac.addAction(UIAlertAction(title: "Rising", style: .Default, handler: { (action) -> Void in
            //            self.category = .Rising
            //            self.categoryButton.setTitle("Rising", forState: UIControlState.Normal)
            //            self.resetReddit()
        }))
        
        ac.addAction(UIAlertAction(title: "Controversial", style: .Default, handler: { (action) -> Void in
            //            self.category = .Controversial
            //            self.categoryButton.setTitle("Controversial", forState: UIControlState.Normal)
            //            self.resetReddit()
        }))
        
        ac.addAction(UIAlertAction(title: "Top", style: .Default, handler: { (action) -> Void in
            //            self.category = .Top
            //            self.categoryButton.setTitle("Top", forState: UIControlState.Normal)
            //            self.resetReddit()
        }))
        
        presentViewController(ac, animated: true, completion: nil)
        
    }
    
    func refreshControlAction(sender: UIRefreshControl) {
        sender.endRefreshing()
        resetComments()
    }
    
    func commentForIndexPath(indexPath: NSIndexPath) -> RKComment? {
        // Only care about section 1
        if indexPath.section == 1 {
           // start at "row"
            if let comments = comments {
                let rootIndex = indexPath.indexAtPosition(1)
                var comment = comments[rootIndex]
                for i in 2..<indexPath.length {
                    let index = indexPath.indexAtPosition(i)
                    if index < comment.replies.count {
                        comment = comment.replies[index] as! RKComment
                    } else {
                        return nil
                    }
                }
                return comment
            }
        }
        return nil
    }
}

extension ZHRedditThreadViewController: TreeTableDataSource {
    
    // These two are additional to UITableViewDataSource
    func tableView(tableView: UITableView!, isCellExpanded indexPath: NSIndexPath!) -> Bool {

        let expanded = expandedItems[indexPath] as? Bool
        if let expanded = expanded {
            return expanded
        } else {
            return false
        }
    }
    
    func tableView(tableView: UITableView!, numberOfSubCellsForCellAtIndexPath indexPath: NSIndexPath!) -> UInt {
        switch(indexPath.section) {
        case 0:
            return 0
        case 1:
            if let comment = commentForIndexPath(indexPath) {
                return UInt(comment.replies.count)
            } else {
                return 0
            }
        default:
            print("Invalid section")
            return 0
        }
    }
    
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            if let comments = comments {
                return comments.count
            } else {
                assert(false)
                return 0
            }
        default:
            assert(false)
            return 0
        }
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = ZHRedditThreadTableViewCell.cellFromNib()
            if let post = post {
                cell.showDetails = true
                cell.post = post
            } else {
                print("could not unwrap post")
            }
            return cell

        case 1:
            
            let cell = tableView.dequeueReusableCellWithIdentifier("ZHRedditCommentTableViewCell") as? ZHRedditCommentTableViewCell

            if let _ = expandedItems[indexPath] {
                cell?.animateExpand(0.0)
            } else {
                cell?.animateCollapse(0.0)
            }
            
            let comment = self.commentForIndexPath(indexPath)
            cell?.comment = comment
            cell?.level = indexPath.length - 2
            return cell!

            
        default:
            assert(false)
            return UITableViewCell()
        }
        
    }
}

extension ZHRedditThreadViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath tableIndexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(tableIndexPath, animated: false)
        let treeIndexPath = tableView.treeIndexPathFromTablePath(tableIndexPath)
        var expanded = false
        if let _ = expandedItems[treeIndexPath] {
            expanded = true
        }
        
        switch tableIndexPath.section {

        case 1:
            
            let cell = tableView.cellForRowAtIndexPath(tableIndexPath) as? ZHRedditCommentTableViewCell
            
            if expanded {
                expandedItems.removeObjectForKey(treeIndexPath)
                tableView.collapse(treeIndexPath)
                cell?.animateCollapse(0.3)
            } else {
                expandedItems[treeIndexPath] = true
                tableView.expand(treeIndexPath)
                cell?.animateExpand(0.3)
            }
            
        default:
            print("disregard tap")
        }
    }
}


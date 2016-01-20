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


class ZHRedditThreadCellModel {
    var comment: RKComment
    var expanded: Bool
    init(comment: RKComment, expanded: Bool){
        self.comment = comment
        self.expanded = expanded
    }
}


class ZHRedditThreadViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var sortBarButton: UIBarButtonItem!
    var post: RKLink? = nil
    var commentModels: [ZHRedditThreadCellModel]? = nil
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
        refreshControl?.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
        treeView.scrollView.addSubview(refreshControl!)
        
        let nib = UINib(nibName: "ZHRedditCommentTableViewCell", bundle: NSBundle.mainBundle())
        tableView.registerNib(nib, forCellReuseIdentifier: "ZHRedditCommentTableViewCell")
        tableView.estimatedRowHeight = 100;
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = UIColor.darkGrayColor()
        tableView.separatorColor = UIColor.darkGrayColor()
        
    }
    
    
    func resetComments() {
        pagination = nil
        commentModels = []
        tableView.reloadData()
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
                }  else {
                    for comment in comments {
                        if comment is RKComment {
                            let model = ZHRedditThreadCellModel(comment: comment as! RKComment, expanded: false)
                            self.commentModels?.append(model)
                        } else if comment is RKMoreComments {
                            assert(false, "Finally found a RKMoreComments")
                        }
                    }
                    print("commentModels.count: \(self.commentModels?.count)")
                    self.tableView.reloadData()
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
}

extension ZHRedditThreadViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            if let commentModels = commentModels {
                return commentModels.count
            } else {
                assert(false)
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
            // TODO: Write a setting with all 3 parameters since they need to go in that order
//            cell?.treeView = treeView
//            cell?.level = treeView.levelForCellForItem(item)
//            let model =
//            cell?.model = model
//            
//            return cell

            
        default:
            assert(false)
            return UITableViewCell()
        }
        
    }
}

extension ZHRedditThreadViewController: UITableViewDelegate {
    
}

//extension ZHRedditThreadViewController: RATreeViewDataSource{
//    
//    func treeView(treeView: RATreeView!, numberOfChildrenOfItem item: AnyObject!) -> Int {
//        // Base case
//        if item == nil {
//            if let commentModels = commentModels {
//                return commentModels.count + 1
//            } else {
//                return 1
//            }
//        }
//        
//        if item is RKLink {
//            return 0
//        } else if item is ZHRedditThreadCellModel {
//            let commentModel = item as! ZHRedditThreadCellModel
//            return commentModel.comment.replies.count
//        }
//        
//        return 0
//        
//    }
//    
//    func treeView(treeView: RATreeView!, child index: Int, ofItem item: AnyObject!) -> AnyObject! {
//        if item == nil {
//            if index == ZHRedditThreadViewControllerSection.Post.rawValue {
//                return post
//            } else {
//                return commentModels![index-1]
//            }
//        } else {
//            let commentModel = item as! ZHRedditThreadCellModel
//            let comment = commentModel.comment.replies[index] as! RKComment
//            let nextCommentModel = ZHRedditThreadCellModel(comment: comment, expanded: false)
//            return nextCommentModel
//        }
//    }
//    
//    func treeView(treeView: RATreeView!, cellForItem item: AnyObject!) -> UITableViewCell! {
//        if item is RKLink {
//            let cell = ZHRedditThreadTableViewCell.cellFromNib()
//            if let post = item as! RKLink? {
//                cell.showDetails = true
//                cell.post = post
//            }
//            return cell
//        } else if item is ZHRedditThreadCellModel {
//            
//            let cell = treeView.dequeueReusableCellWithIdentifier("ZHRedditCommentTableViewCell") as? ZHRedditCommentTableViewCell
//            // TODO: Write a setting with all 3 parameters since they need to go in that order
//            cell?.treeView = treeView
//            cell?.level = treeView.levelForCellForItem(item)
//            let model = item as! ZHRedditThreadCellModel
//            cell?.model = model
//            
//            return cell
//        } else if item is RKComment {
//            
//        }
//        assert(false, "bad default case here")
//        return UITableViewCell()
//    }
//}
//
//extension ZHRedditThreadViewController: RATreeViewDelegate {
//    func treeView(treeView: RATreeView!, shouldCollapaseRowForItem item: AnyObject!) -> Bool {
//        
//        co = treeView.scrollView.contentOffset
//        
//        if item is RKLink {
//            return false
//        } else if item is ZHRedditThreadCellModel {
//            let commentModel = item as! ZHRedditThreadCellModel
//            return commentModel.comment.replies.count > 0 ? true : false
//        }
//
//        
//        
//        return false
//    }
//    
//    func treeView(treeView: RATreeView!, shouldExpandRowForItem item: AnyObject!) -> Bool {
//        
//        co = treeView.scrollView.contentOffset
//        
//        if item is RKLink {
//            return false
//        } else if item is ZHRedditThreadCellModel {
//            let commentModel = item as! ZHRedditThreadCellModel
//            return commentModel.comment.replies.count > 0 ? true : false
//        }
//
//        
//        return false
//    }
//}



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

    @IBOutlet weak var treeView: RATreeView!
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
        
        setupTreeView()
        resetComments()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
        navigationController?.setNavigationBarHidden(false, animated: true)
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

        
        treeView.rowsCollapsingAnimation = RATreeViewRowAnimationTop
        treeView.rowsExpandingAnimation = RATreeViewRowAnimationTop
        treeView.expandsChildRowsWhenRowExpands = false
        treeView.collapsesChildRowsWhenRowCollapses = false
        treeView.dataSource = self;
        treeView.delegate = self;
        treeView.separatorStyle = RATreeViewCellSeparatorStyleNone
        treeView.backgroundColor = UIColor.darkGrayColor()
        treeView.separatorColor = UIColor.darkGrayColor()

        
//        let nib = NSBundle.mainBundle().loadNibNamed("ZHRedditThreadTableViewCell", owner: self, options: nil).first as? UINib
//        tableView.registerNib(nib, forCellReuseIdentifier: "ZHRedditThreadTableViewCell")
//        
//        // Setup TableView
//        tableView.estimatedRowHeight = 100
//        tableView.rowHeight = UITableViewAutomaticDimension
        
    }

    
    func resetComments() {
        pagination = nil
        commentModels = []
        treeView.reloadData()
        getNextPageOfComments()
    }

    
    func getNextPageOfComments() {
        MBProgressHUD.showHUDAddedTo(view, animated: true)
        RKClient.sharedClient().commentsForLink(post, completion: { (comments, pagination, error) -> Void in
            if error == nil {
                for comment in comments {
                    let model = ZHRedditThreadCellModel(comment: comment as! RKComment, expanded: false)
                    self.commentModels?.append(model)
                }
                self.treeView.reloadData()
            }
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        })

    }
    
    @IBAction func doneButtonAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    func refreshControlAction(sender: UIRefreshControl) {
        sender.endRefreshing()
        resetComments()
    }
}


extension ZHRedditThreadViewController: RATreeViewDataSource{
    
    func treeView(treeView: RATreeView!, cellForItem item: AnyObject!) -> UITableViewCell! {
        if item is RKLink {
            let cell = ZHRedditThreadTableViewCell.cellFromNib()
            if let post = item as! RKLink? {
                cell.post = post
            }
            return cell
        } else if item is ZHRedditThreadCellModel {
            let cell = NSBundle.mainBundle().loadNibNamed("ZHRedditCommentTableViewCell", owner: self, options: nil)[0] as? ZHRedditCommentTableViewCell
            
            // TODO: Write a setting with all 3 parameters since they need to go in that order
            cell?.treeView = treeView
            cell?.level = treeView.levelForCellForItem(item)
            let model = item as! ZHRedditThreadCellModel
            cell?.model = model
            
            return cell
        } else if item is RKComment {
            
        }
        assert(false, "bad default case here")
        return UITableViewCell()
    }
    
    func treeView(treeView: RATreeView!, numberOfChildrenOfItem item: AnyObject!) -> Int {
        // Base case
        if item == nil {
            if let commentModels = commentModels {
                return commentModels.count + 1
            } else {
                return 1
            }
        }
        
        if item is RKLink {
            return 0
        } else if item is ZHRedditThreadCellModel {
            let commentModel = item as! ZHRedditThreadCellModel
            return commentModel.comment.replies.count
        }
        
        return 0

    }
    
    func treeView(treeView: RATreeView!, child index: Int, ofItem item: AnyObject!) -> AnyObject! {
        if item == nil {
            if index == ZHRedditThreadViewControllerSection.Post.rawValue {
                return post
            } else {
                return commentModels![index-1]
            }
        } else {
            let commentModel = item as! ZHRedditThreadCellModel
            let comment = commentModel.comment.replies[index] as! RKComment
            let nextCommentModel = ZHRedditThreadCellModel(comment: comment, expanded: false)
            return nextCommentModel
        }
    }
}

extension ZHRedditThreadViewController: RATreeViewDelegate {
    func treeView(treeView: RATreeView!, shouldCollapaseRowForItem item: AnyObject!) -> Bool {
        return false
    }
    
    func treeView(treeView: RATreeView!, shouldExpandRowForItem item: AnyObject!) -> Bool {
        return false
    }
    
//    func treeView(treeView: RATreeView!, willExpandRowForItem item: AnyObject!) {
//        if item is RKLink {
//            
//        } else if item is RKComment {
//            let cell = treeView.cellForItem(item) as! ZHRedditCommentTableViewCell
//            cell.expanded = true
////            treeView.scrollToNearestSelectedRowAtScrollPosition(RATreeViewScrollPositionTop, animated: true)
//////            treeView.scrollToRowForItem(item, atScrollPosition: RATreeViewScrollPositionTop, animated: true)
//        }
//    }
//    
//    func treeView(treeView: RATreeView!, willCollapseRowForItem item: AnyObject!) {
//        if item is RKLink {
//            
//        } else if item is RKComment {
//            let cell = treeView.cellForItem(item) as! ZHRedditCommentTableViewCell
//            cell.expanded = false
//        }
//
//    }
//
//    func treeView(treeView: RATreeView!, didExpandRowForItem item: AnyObject!) {
//        if item is RKLink {
//            
//        } else if item is RKComment {
//
//        }
//        
//    }
//
//    
//    func treeView(treeView: RATreeView!, didCollapseRowForItem item: AnyObject!) {
//        if item is RKLink {
//            
//        } else if item is RKComment {
//////            treeView.scrollToRowForItem(item, atScrollPosition: RATreeViewScrollPositionTop, animated: true)
////            treeView.scrollToNearestSelectedRowAtScrollPosition(RATreeViewScrollPositionTop, animated: true)
//        }
//    }
//    

}

// This extension hides/shows the navigation bar and status bar as the user scrolls
extension ZHRedditThreadViewController: UIScrollViewDelegate {
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        if scrollView.contentOffset.y < view.bounds.size.height / 2.0 {
//            showNavBar()
//        } else {
//            hideNavBar()
//        }
//    }
    
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

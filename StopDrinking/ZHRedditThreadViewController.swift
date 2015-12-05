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



class ZHRedditThreadViewController: UIViewController {

    @IBOutlet weak var treeView: RATreeView!
    var post: RKLink? = nil
    var comments: [RKComment]? = nil
    var statusBarHidden: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.darkGrayColor()
        
        UIApplication.sharedApplication().statusBarHidden = false
        treeView.rowsCollapsingAnimation = RATreeViewRowAnimationTop
        treeView.rowsExpandingAnimation = RATreeViewRowAnimationTop
        treeView.expandsChildRowsWhenRowExpands = true
        treeView.collapsesChildRowsWhenRowCollapses = true
        treeView.dataSource = self;
        treeView.delegate = self;
        treeView.separatorStyle = RATreeViewCellSeparatorStyleNone
        treeView.backgroundColor = UIColor.darkGrayColor()
        treeView.separatorColor = UIColor.darkGrayColor()
        
//        navigationItem.title = "Thread"
        
        MBProgressHUD.showHUDAddedTo(view, animated: true)
        RKClient.sharedClient().commentsForLink(post, completion: { (comments, pagination, error) -> Void in
            if error == nil {
                self.comments = comments as? [RKComment]
                self.treeView.reloadData()
            }
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func doneButtonAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }

}


extension ZHRedditThreadViewController: RATreeViewDataSource{
    
    func treeView(treeView: RATreeView!, cellForItem item: AnyObject!) -> UITableViewCell! {
        if item.isKindOfClass(RKComment) {
            let cell = NSBundle.mainBundle().loadNibNamed("ZHRedditCommentTableViewCell", owner: self, options: nil)[0] as? ZHRedditCommentTableViewCell
            cell?.expandButtonHandler = ({ (expand: Bool) -> Void in
                if expand == true {
                    treeView.expandRowForItem(item, expandChildren: true, withRowAnimation: RATreeViewRowAnimationTop)
                } else {
                    treeView.collapseRowForItem(item, collapseChildren: true, withRowAnimation: RATreeViewRowAnimationTop)
                }
            })
            
            if let comment = item as! RKComment? {
                cell?.comment = comment
            }
            cell?.level = treeView.levelForCellForItem(item)
            return cell
            
        } else if item.isKindOfClass(RKLink) {
//            let cell = NSBundle.mainBundle().loadNibNamed("ZHRedditPostDetailsTableViewCell", owner: self, options: nil)[0] as? ZHRedditPostDetailsTableViewCell
            let cell = ZHRedditThreadTableViewCell.cellFromNib()
            if let post = item as! RKLink? {
                cell.post = post
            }
            return cell
            
        }
        return UITableViewCell()
    }
    
    func treeView(treeView: RATreeView!, numberOfChildrenOfItem item: AnyObject!) -> Int {
        if item == nil {
            if let c = comments {
                return c.count + 1
            } else {
                return 1
            }
        }
        
        if item is RKLink {

        } else if item is RKComment {
            let comment = item as! RKComment
            return comment.replies.count
        }
        
        return 0

    }
    
    func treeView(treeView: RATreeView!, child index: Int, ofItem item: AnyObject!) -> AnyObject! {
        if item == nil {
            if index == ZHRedditThreadViewControllerSection.Post.rawValue {
                return post
            } else {
                return comments![index-1]
            }
        } else {

            let comment = item as! RKComment?
            return comment!.replies[index]
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

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        MBProgressHUD.showHUDAddedTo(view, animated: true)
        RKClient.sharedClient().commentsForLink(post, completion: { (comments, pagination, error) -> Void in
            if error == nil {
                for index in 0..<comments.count {
                    let comment = comments[index] as! RKComment
                    print("\(index): comment.replics \(comment.replies.count)")
                }
                self.comments = comments as? [RKComment]
                self.treeView.reloadData()
            }
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        })
    }
    
    @IBAction func doneButtonAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }

}


extension ZHRedditThreadViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        print(__FUNCTION__)
    }
}

extension ZHRedditThreadViewController: RATreeViewDataSource{
    
    func treeView(treeView: RATreeView!, cellForItem item: AnyObject!) -> UITableViewCell! {
        if item.isKindOfClass(RKComment) {
            let cell = NSBundle.mainBundle().loadNibNamed("ZHRedditCommentTableViewCell", owner: self, options: nil)[0] as? ZHRedditCommentTableViewCell
            if let comment = item as! RKComment? {
                cell?.comment = comment
            }
            cell?.level = treeView.levelForCellForItem(item)
            return cell
            
        } else if item.isKindOfClass(RKLink) {
            let cell = NSBundle.mainBundle().loadNibNamed("ZHRedditPostDetailsTableViewCell", owner: self, options: nil)[0] as? ZHRedditPostDetailsTableViewCell
            if let post = item as! RKLink? {
                cell?.post = post
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
        
        let comment = item as! RKComment
        return comment.replies.count
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
    
//    func treeView(treeView: RATreeView!, editingStyleForRowForItem item: AnyObject!) -> UITableViewCellEditingStyle {
//        return .None
//    }
//    
//    
    
    func treeView(treeView: RATreeView!, willExpandRowForItem item: AnyObject!) {
//        treeView.alwaysBounceHorizontal = false
//        treeView.scrollEnabled = false
        let cell = treeView.cellForItem(item) as! ZHRedditCommentTableViewCell
        cell.expanded = true
    }
    
    func treeView(treeView: RATreeView!, willCollapseRowForItem item: AnyObject!) {
//        treeView.alwaysBounceHorizontal = false
//        treeView.scrollEnabled = false

        let cell = treeView.cellForItem(item) as! ZHRedditCommentTableViewCell
        cell.expanded = false
    }
    
    
    func treeView(treeView: RATreeView!, didCollapseRowForItem item: AnyObject!) {
//        treeView.alwaysBounceHorizontal = true
//        treeView.scrollEnabled = true
        
    }
    
    func treeView(treeView: RATreeView!, didExpandRowForItem item: AnyObject!) {
//        treeView.alwaysBounceHorizontal = true
//        treeView.scrollEnabled = true

    }

}

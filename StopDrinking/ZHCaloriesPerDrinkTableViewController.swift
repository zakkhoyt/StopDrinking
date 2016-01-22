//
//  ZHCaloriesPerDrinkTableViewController.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/16/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class ZHCaloriesPerDrinkTableViewController: UITableViewController {

    
    let beers = [
        ("Light Beer", 100),
        ("Regular Beer", 150),
        ("Heavy Beer", 200),
        ("Malt Beverage", 250),
        ("Cider", 200),
    ]
    
    let spirits = [
        ("Vodka", 100),
        ("Whiskey", 100),
        ("Gin", 100),
        ("Rum", 100),
        ("Tequilla", 100),
    ]

    let wines = [
        ("Red", 120),
        ("Rose", 130),
        ("White", 120),
        ("Dessert", 200),
    ]

    let mixers = [
        ("Fruit Juice", 125),
        ("Tonic", 80),
        ("Soda", 130),
        ("Diet Soda", 0),
    ]


    @IBAction func closeBarButtonAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
 
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return beers.count
        case 1:
            return spirits.count
        case 2:
            return wines.count
        case 3:
            return mixers.count
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ZHCaloriesPerDrinkTableViewCell") as? ZHCaloriesPerDrinkTableViewCell
        
        switch indexPath.section {
        case 0:
            let beverage = beers[indexPath.row].0
            let calories = beers[indexPath.row].1
            cell?.setBeverage(beverage, calories: UInt(calories))
        case 1:
            let beverage = spirits[indexPath.row].0
            let calories = spirits[indexPath.row].1
            cell?.setBeverage(beverage, calories: UInt(calories))

        case 2:
            let beverage = wines[indexPath.row].0
            let calories = wines[indexPath.row].1
            cell?.setBeverage(beverage, calories: UInt(calories))

        case 3:
            let beverage = mixers[indexPath.row].0
            let calories = mixers[indexPath.row].1
            cell?.setBeverage(beverage, calories: UInt(calories))

        default:
            assert(false)
        }
        
        return cell!
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var calories = 0
        switch indexPath.section {
        case 0:
            calories = beers[indexPath.row].1
        case 1:
            calories = spirits[indexPath.row].1
        case 2:
            calories = wines[indexPath.row].1
        case 3:
            calories = mixers[indexPath.row].1
        default:
            assert(false)
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName("CaloriesSuggestionNotification", object: nil, userInfo: ["calories": calories])
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let frame = CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 60)
        let header = UITableViewHeaderFooterView(frame: frame)
        switch section {
        case 0:
            header.textLabel?.text = "Beers"
        case 1:
            header.textLabel?.text = "Spirits"
        case 2:
            header.textLabel?.text = "Wines"
        case 3:
            header.textLabel?.text = "Mixers"
        default:
            assert(false)
        }
        
        return header

        
        
    }
}
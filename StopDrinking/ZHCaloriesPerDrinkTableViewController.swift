//
//  ZHCaloriesPerDrinkTableViewController.swift
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/16/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

import UIKit

class ZHCaloriesPerDrinkTableViewController: UITableViewController {

    
    let bar = [
        ("7 oz Long Island", 780),
        ("8 oz Margarita", 740),
        ("6 oz Pina Colada", 644),
        ("9 oz Mai Tai", 620),
        ("12 oz Mudslide", 594),
        ("6 oz Appletini", 525),
        ("5 oz White Russian", 425),
        ("3 oz Cosmopolitan", 150),
    ]
    
    let beers = [
        ("12 oz Light Beer", 100),
        ("12 oz Regular Beer", 150),
        ("12 oz Heavy Beer", 200),
        ("12 oz Malt Beverage", 250),
        ("12 oz Cider", 200),
        ("6 oz Mojito", 160),
        ("10 oz Bloody Mary", 180),
        ("6 oz Jägerbomb", 200),
    ]
    
    let spirits = [
        ("1.5 oz Vodka", 100),
        ("1.5 oz Whiskey", 100),
        ("1.5 oz Gin", 100),
        ("1.5 oz Rum", 100),
        ("1.5 oz Tequilla", 100),
    ]

    let wines = [
        ("5 oz Red", 120),
        ("5 oz Rose", 130),
        ("5 oz White", 120),
        ("5 oz Dessert", 200),
    ]

    let mixers = [
        ("8 oz Fruit Juice", 125),
        ("8 oz Tonic", 80),
        ("8 oz Soda", 130),
        ("Diet Soda", 0),
    ]


    @IBAction func closeBarButtonAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
 
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return bar.count
        case 1:
            return beers.count
        case 2:
            return spirits.count
        case 3:
            return wines.count
        case 4:
            return mixers.count
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ZHCaloriesPerDrinkTableViewCell") as? ZHCaloriesPerDrinkTableViewCell
        
        switch indexPath.section {
        case 0:
            let beverage = bar[indexPath.row].0
            let calories = bar[indexPath.row].1
            cell?.setBeverage(beverage, calories: UInt(calories))
        case 1:
            let beverage = beers[indexPath.row].0
            let calories = beers[indexPath.row].1
            cell?.setBeverage(beverage, calories: UInt(calories))
        case 2:
            let beverage = spirits[indexPath.row].0
            let calories = spirits[indexPath.row].1
            cell?.setBeverage(beverage, calories: UInt(calories))
        case 3:
            let beverage = wines[indexPath.row].0
            let calories = wines[indexPath.row].1
            cell?.setBeverage(beverage, calories: UInt(calories))
        case 4:
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
            calories = bar[indexPath.row].1
        case 1:
            calories = beers[indexPath.row].1
        case 2:
            calories = spirits[indexPath.row].1
        case 3:
            calories = wines[indexPath.row].1
        case 4:
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
        header.textLabel?.textColor = UIColor.whiteColor()
        
        switch section {
        case 0:
            header.textLabel?.text = "Bar drinks"
        case 1:
            header.textLabel?.text = "Beers"
        case 2:
            header.textLabel?.text = "Spirits"
        case 3:
            header.textLabel?.text = "Wines"
        case 4:
            header.textLabel?.text = "Mixers"
        default:
            assert(false)
        }
        
        return header

        
        
    }
}
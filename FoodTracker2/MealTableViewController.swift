//
//  MealTableViewController.swift
//  FoodTracker2
//
//  Created by Madai on 7/14/16.
//  Copyright © 2016 Madai. All rights reserved.
//
// Ctrl - I to indent stuff

import UIKit

class MealTableViewController: UITableViewController {
    
    // MARK: Properties 
    
    var meals = [Meal]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // use the edit button item provided by the table view controller
        navigationItem.leftBarButtonItem = editButtonItem()
        
        // Load any saved meals, otherwise, load sample data
        if let savedMeals = loadMeals() {
            meals += savedMeals
//        if false {
            print("Meals are loading...")
        } else {
        // Load the sample , hard-coded, data
        loadSampleMeals()
        }
    }
    
    func loadSampleMeals()
    {
        let photo1 = UIImage(named: "BeBopBeginning" )
        let meal1 = Meal(name: "Meal 1", photo: photo1, rating: 5)
        
        let photo2 = UIImage(named: "BeBopEnding")
        let meal2 = Meal(name: "Meal 2", photo: photo2, rating: 5)
        
        let photo3 = UIImage(named: "Verification")
        let meal3 = Meal(name: "Meal 3", photo: photo3, rating: 1)
        
        meals += [ meal1!, meal2!, meal3! ]
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    //sections are groupings of cells,ie, # of lists we want
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows we want to display in each section/list
        return meals.count
        //array count method returns length
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //controls which cells for which rows are shown
        
        //previously set in storyboard, under attr -> id while selecting table view
        let cellIdentifier = "MealTableViewCell"
        
        // table view cells are reused and should be dequeued using a cell id
        // since we have a subclass we want to use for this table view, downcast the type of cell to our custom subclass
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MealTableViewCell
        
        //fetches the right meal for layout
        let meal = meals[indexPath.row]
        
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        
        return cell
    }
 
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        
        //if either downcast to MealViewController fails, or meal is nil, if fails
        if let sourceViewController = sender.sourceViewController as? MealViewController,
            meal = sourceViewController.meal {
            
            //if a row is selected...
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                //update an existing meal
                meals[selectedIndexPath.row] = meal
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
            else {
                //add a new meal, computes location where  new table view cell will be inserted
                // (it would be at the end), at the first (and only) section of the table view
                let newIndexPath = NSIndexPath(forRow: meals.count , inSection: 0)
                meals.append(meal)
                tableView.insertRowsAtIndexPaths([newIndexPath] , withRowAnimation: .Bottom)
            }
            
            // Save the meals
            saveMeals()
            
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            meals.removeAtIndex(indexPath.row)
            
            //save meal list since meal was deleted
            saveMeals()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ShowDetail"
        {
            //if downcast is unsuccessful, app will crash at runtime
            let mealDetailViewController = segue.destinationViewController as! MealViewController
            
            //Get Meal selected and display in MealViewController
            if let selectedMealCell = sender as? MealTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedMealCell)!
                let selectedMeal = meals[indexPath.row]
                mealDetailViewController.meal = selectedMeal
            }
            
        }
        else if segue.identifier == "AddItem"
        {
            print("Adding new meal.")
        }
    }
    
    // MARK: NSCoding - Data Persistence
    func saveMeals(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path!)
        
        if !isSuccessfulSave {
            print("Failed To Save Meals")
        }
        
    }
    
    func loadMeals() -> [Meal]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Meal.ArchiveURL.path!) as? [Meal]
    }
 

}

//
//  ItemsViewController.swift
//  prototype-table-Reema.Mousa
//
//  Created by Reema Mousa on 10/04/1443 AH.
//

import UIKit

class ItemsViewController: UITableViewController {
  
  var itemStore: ItemStore!
  
  @IBAction func addNewItem(_ sender: UIButton) {
    let newItem = itemStore.createItem()
    if let index = itemStore.allItems.firstIndex(of: newItem){
      let indexPath = IndexPath(row:index,section:0)
      
      tableView.insertRows(at: [indexPath], with: .automatic)
    }
  }
  @IBAction func toggleEditingMode(_ sender: UIButton) {
    if isEditing == true{
      sender.setTitle("Edit", for: .normal)
      setEditing(false, animated: true);
    }else{
      sender.setTitle("Done",for:.normal)
      setEditing(true, animated: true)
    }
  }
  //do
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return itemStore.allItems.count
  }
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Get a new or recycled cell
    
    // Set the text on the cell with the description of the item
    // that is at the nth index of items, where n = row this cell
    // will appear in on the table view
    let cell
    = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",
    for: indexPath)
    
    let item = itemStore.allItems[indexPath.row]
    cell.textLabel?.text = item.name
    cell.detailTextLabel?.text = "$\(item.valueInDollars)"
    return cell }
   //169
  override func tableView(_ tableView: UITableView,
                          commit editingStyle: UITableViewCell.EditingStyle,
                          forRowAt indexPath: IndexPath) {
    // If the table view is asking to commit a delete command...
    if editingStyle == .delete {
      let item = itemStore.allItems[indexPath.row]
      // Remove the item from the store
      itemStore.removeItem(item)
      // Also remove that row from the table view with an animation
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  //169
  override func tableView(_ tableView: UITableView,
                          moveRowAt sourceIndexPath: IndexPath,to destinationIndexPath: IndexPath) {
    itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
  }
}

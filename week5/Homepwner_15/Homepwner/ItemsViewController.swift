

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore?
    var imageStore: ImageStore?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    @IBAction func addNewItem(_ sender: AnyObject) {
        guard let newItem = itemStore?.createItem() else {
            return
        }
        
        guard let index = itemStore?.allItems.index(of: newItem) else {
            return
        }
        
        let indexPath = IndexPath(row: index, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowItem" else {
            return
        }
        
        guard let row = tableView.indexPathForSelectedRow?.row  else {
            return
        }
        
        let item = itemStore?.allItems[row]
        if let detailViewController = segue.destination as? DetailViewController {
            detailViewController.item = item
            detailViewController.imageStore = imageStore
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
        itemStore?.moveItemAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        
        guard let item = itemStore?.allItems[indexPath.row] else {
            return
        }
        
        let title = "Delete \(item.name)?"
        let message = "Are you sure you want to delete this item?"
        
        let ac = UIAlertController(title: title,
                                   message: message,
                                   preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive,
                                         handler: { (action) -> Void in
                                            self.itemStore?.removeItem(item)
                                            self.imageStore?.deleteImageForKey(item.itemKey)
                                            self.tableView.deleteRows(at: [indexPath], with: .automatic)
                                        })
        ac.addAction(deleteAction)
        present(ac, animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let itemStore = itemStore else {
            return 0
        }
        
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell",
                                                 for: indexPath) as! ItemCell
        
        guard let itemStore = itemStore else {
            return cell
        }
        
        cell.updateLabels()
        
        let item = itemStore.allItems[indexPath.row]
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"
        
        return cell
    }
}

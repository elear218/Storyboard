//
//  AcountTableViewController.swift
//  StoryBoardTest
//
//  Created by eall on 2018/3/2.
//  Copyright © 2018年 eall. All rights reserved.
//

import UIKit

enum ActionIdentifier: String {
    case MyFriends
    case NewTask
    case NewPublish
    case MyFollowing
    case MyFans
    case Feedback
    case AboutUs
    case VersionInfo
    case ModifyLanguage
}

class AcountTableViewController: UITableViewController {

    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.contentInsetAdjustment()
        
        tableView.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 18));
        tableView.tableFooterView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1));
        versionLabel.text = "v".appending(Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String)
        print(message: "1234567890")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print(message: "dealloc")
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        
        guard let taskVC = segue.destination as? TaskViewController else { return }
        
//        let taskVC: TaskViewController = segue.destination as! TaskViewController
        let cell: UITableViewCell = sender as! UITableViewCell
        
        //taskVC回调
        weak var weakTask: TaskViewController! = taskVC
        taskVC.backValueClosure = {(_ text: String) -> Void in
            print(message: weakTask.receivedStr)
            print(message: text)
//            self.tableView.backgroundColor = .red
        }
        
        //给taskVC的receivedStr赋值
        taskVC.setValue(cell.textLabel?.text, forKey: "receivedStr")
        
     }
 

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        guard let action = ActionIdentifier.init(rawValue: cell.actionIdentifier) else { return }
        //switch每个case默认break  如果想要执行完之后继续向下进行，在case里面加fallthrough
        switch action {
            case .MyFriends , .MyFollowing , .MyFans:
                print(message: 111)
//                fallthrough
            case .NewTask:
                print(message: 222)
                
            case .NewPublish:
                print(message: 333)
                
    //        case .MyFollowing:
    //            print(message: 333)
    //
    //        case .MyFans:
    //            print(message: 444)
                
            case .Feedback:
                print(message: 555)
                
            case .AboutUs:
                print(message: 666)
                
            case .VersionInfo:
                print(message: 777)
            
            case .ModifyLanguage:
//                print(message: 888);
                let targetVC: ModifyLanguageViewController? = ModifyLanguageViewController.loadNibVc()
                guard let vc = targetVC else { return }
//                self.navigationController?.pushViewController(vc, animated: true)
                self.navigationController?.present(vc, animated: true, completion: nil)
        }
    }

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
}

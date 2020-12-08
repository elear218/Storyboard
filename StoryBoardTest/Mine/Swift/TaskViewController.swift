//
//  TaskViewController.swift
//  StoryBoardTest
//
//  Created by eall on 2018/3/2.
//  Copyright © 2018年 eall. All rights reserved.
//

import UIKit

@objcMembers //加上@objcMembers  否则setValue forKey方法崩溃
class TaskViewController: UIViewController {

    var receivedStr : String = ""
    
    //自定义闭包closure
    var backValueClosure: (( _ text: String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        print(message: "task page")
        print(message: receivedStr)
        // Do any additional setup after loading the view.
    }

    @IBAction func back(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        if (self.backValueClosure != nil) {
            self.backValueClosure!("123456")
        }
    }
    
    deinit {
        print(message: "dealloc")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

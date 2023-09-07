//
//  NewItemViewController.swift
//  TodoHomeWork
//
//  Created by 長島啓太朗 on 2023/09/05.
//

import UIKit
import RealmSwift
class NewItemViewController: UIViewController {
    @IBOutlet var titleTextField:UITextField!
    @IBOutlet var bodyTextField:UITextField!
    @IBOutlet var doneDate:UIDatePicker!
    @IBOutlet var markSwitch:UISwitch!
    
    let realm = try!Realm()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func save(){
        let content = TodoContent()
        content.title = titleTextField.text ?? ""
        content.body = bodyTextField.text ?? ""
        content.isMarked = markSwitch.isOn
        createItem(content: content)
        self.dismiss(animated: true)
    }
    func createItem(content :TodoContent){
        try! realm.write{
            realm.add(content)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

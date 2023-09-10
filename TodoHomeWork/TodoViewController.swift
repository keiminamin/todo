//
//  ViewController.swift
//  TodoHomeWork
//
//  Created by 長島啓太朗 on 2023/09/04.
//

import UIKit
import RealmSwift
class TodoViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
    @IBOutlet var tableView: UITableView!
    let realm = try! Realm()
    var contents:Results<TodoContent>!
    var selectedCategory:Category!
    override func viewDidLoad() {
       
        super.viewDidLoad()
       
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TodoTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoCell")
        contents = readContents()
        navigationItem.title = selectedCategory.title
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        contents = readContents()
        tableView.reloadData()
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("セル\(indexPath.row)が選択されました")
            showAlertController(indexPath)
        }
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: "delete"){_,_,handler in
//            print("delete")
//
//            handler(true)
//        }
//        let editAction =  UIContextualAction(style: .normal, title: "edit"){_,_,handler in
//            print("edit")
//            handler(true)
//        }
//        let configuration = UISwipeActionsConfiguration(actions: [deleteAction,editAction])
//        configuration.performsFirstActionWithFullSwipe = true
//        return configuration
//    }
    
  
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            try! realm.write{
                realm.delete(contents[indexPath.row])
                tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
                tableView.reloadData()
            }
           
            
            
        }
    }
    func showAlertController(_ indexPath: IndexPath ){
        let alertController: UIAlertController = UIAlertController(title: "\(String(indexPath.row+1))番目のTodoを編集", message: contents[indexPath.row].title, preferredStyle: .alert)
        let df = DateFormatter()
        df.dateStyle = .short
        alertController.addTextField(configurationHandler: {(textField: UITextField!)in
            textField.text = self.contents[indexPath.row].title
        })
        alertController.addTextField(configurationHandler: {(textField: UITextField!)in
            textField.text = self.contents[indexPath.row].body
        })
//        alertController.addTextField(configurationHandler: {(textField: UITextField!)in
//            textField.text = df.string(from: self.contents[indexPath.row].date)
//        })
        alertController.addAction(UIAlertAction(title: "OK", style: .default,handler: {
            (action) -> Void in self.updateAlertControllerText(alertController,indexPath)
            }))
        self.present(alertController,animated: true,completion: nil)
    }
    func updateAlertControllerText(_ alertController:UIAlertController, _ indexPath:IndexPath){
//       let df = DateFormatter()
//        df.dateFormat = "yyyyMMdd"
        guard let textFields = alertController.textFields else {return}
        guard let title = textFields[0].text else {return}
        guard let body = textFields[1].text else {return}
//        let date =  df.date(from: textFields[2].text ?? "")
        try! realm.write{
            contents[indexPath.row].title = title
            contents[indexPath.row].body = body
            self.tableView.reloadData()
        }
       
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"TodoCell",for: indexPath) as! TodoTableViewCell
        let content: TodoContent = contents[indexPath.row]
        cell.setCell(title: content.title,body: content.body, date: content.date, isMarked: content.isMarked)
        return cell
    }
    func readContents()->Results<TodoContent>{
      
        return realm.objects(TodoContent.self).filter("category == %@", selectedCategory!)
    }
    func delete(){
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNewTodoView"{
            let newItemViewController = segue.destination as! NewTodoViewController
            newItemViewController.category = self.selectedCategory
        }
    }
}

